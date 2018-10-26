extends KinematicBody2D

var GRAVITY = 700.0 # pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 400
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 300
const STOP_FORCE = 1500
const JUMP_SPEED = 380
const JUMP_MAX_AIRBORNE_TIME = 0.2

const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

var velocity = Vector2()
var on_air_time = 0
var jumping = false
var pushing = false
var dead = false
var in_terrain = 0

var siding_left = false
var terrain = 1.0
onready var Recorder = null
export var invert_vertical = 1
export var invert_horizontal = 1
onready var move_left = false
onready var move_right = false
onready var recording = false
onready var jump = false
onready var on_act3 = false
onready var view = null
onready var interacting = false
onready var crushing = false
onready var time = 0.05
onready var platform = false
onready var initpos = self.get_position()
onready var ready = true
onready var carry = null
onready var restart = false
onready var clone = false
onready var dict = Dictionary()
onready var cnt = 0

func _ready():
	if invert_vertical == -1:
		self.rotate(PI)
		$sprite.scale.x = -1
	elif invert_horizontal == -1:
		$sprite.scale.x = -1
		siding_left = true
	ready = true

func _process(delta):
	if !ready:
		clone = true
		_ready()
	if dead:
		return
	
	restart = false
	if Input.is_action_just_pressed("change-v"):
		invert_vertical *= -1
		self.rotate(PI)
	if Input.is_action_just_pressed("change-h"):
		invert_horizontal *= -1
	if Input.is_action_just_pressed("restart"):
		global.clean()
		restart = true
		die()

	
func _physics_process(delta):
	#print(self.get_name()+str(restart))
	if dead:
		restart = false
		return
	# Create forces
	var force = Vector2(0, invert_vertical*GRAVITY)
	var stop = true

	var opa = siding()
	for a in opa:
		if a == self:
			continue
		elif a.get_name().begins_with("Box") or a.get_class() == "TileMap":
			view = a
			break

	var head = head()
	for body in head:
		#print(body.get_name())
		var cls = body.get_class()

		if body.is_in_group('safe') or body.get_name().begins_with("Player"):
			continue

		#print("tem um "+body.get_name()+" na minha cabeça")
		if cls == "RigidBody2D": 
			if body.get_linear_velocity().y > 0:
				if(!jumping):
					#print("no jump, being crushed")
					crushing = true
			elif self.GRAVITY < 0:
				#print("subindo")
				if (!jumping):
				#	print("mas no jump, being crushed")
					crushing = true
			else:
				crushing = false
		elif cls == "TileMap":
			if self.GRAVITY < 0 and !jumping and view != body:
				crushing = true
				#print("being cccrushed")
		elif cls == "KinematicBody2D":
			if body.get_name().begins_with("Box"):
				if !jumping and body.falling() and view != body:
					#print("boxcrsuh")
					crushing = true
				elif !jumping and body.velocity.y > 0:
					if body.falling():
					#print("crcrcush")
						crushing = true
		else:
			crushing = false
			#print("no crush "+cls)
			
	if not crushing:
		time = 0.05
	if crushing:
		time -= delta
	
	if time <= 0:
		die()
	
	if on_act3 and not clone:
		if Input.is_action_just_pressed("record"):
			if recording:
				Recorder.stop_recording()
				recording = false
			else:
				recording = true
				Recorder.start_recording(self)
		if Input.is_action_just_pressed("play"):
			Recorder.play_all()
	
	if Input.is_action_just_pressed("debug"):
		print(self.get_name()+": "+str(self.position))
	
	if pushing:
		if move_left:
			velocity.x = -175
		elif move_right:
			velocity.x = 175
	else:
		if move_left:
			if velocity.x <= WALK_MIN_SPEED * terrain and velocity.x > -WALK_MAX_SPEED * terrain:
				force.x -= WALK_FORCE
				stop = false
		elif move_right:
			if velocity.x >= -WALK_MIN_SPEED * terrain and velocity.x < WALK_MAX_SPEED * terrain:
				force.x += WALK_FORCE	
				stop = false
	
	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE * delta
		if vlen < 0:
			vlen = 0
		
		velocity.x = vlen * vsign
	
	var new_siding_left = siding_left
	# Check siding
	if velocity.x < 0 and move_left and not pushing:
		new_siding_left = true
	elif velocity.x > 0 and move_right and not pushing:
		new_siding_left = false
		
	# Update siding
	if new_siding_left != siding_left:
		if new_siding_left:
			$sprite.scale.x = -invert_vertical
		else:
			$sprite.scale.x = invert_vertical
		
		siding_left = new_siding_left
	
#	# Integrate forces to velocity
#	velocity += force * delta
#	# Integrate velocity into motion and move
#	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	#print(carry)
	var tmp = ground()
	var nope = true
	#print(tmp)
	for i in tmp[1]:
		if i.is_in_group('carry'):
			carry = i.get_parent().get_parent()
			if !dict.has(carry.get_name()):
				carry.entered(self)
				dict[carry.get_name()] = [cnt, carry]
				cnt += 1
			nope = false
	
	if nope and carry != null:
		carry.left(self)
		dict.erase(carry.get_name())
		carry = null

	if dict.size() > 1:
		var minn = 9999
		var minkey = ""
		for c in dict.keys():
			if dict[c][0] < minn:
				minn = dict[c][0]
				minkey = c
				
		dict[minkey][1].left(self)
		dict.erase(minkey)
		
#	if tmp[0] != null and tmp[0].is_in_group('carry'):
#		carry = tmp[0].get_parent().get_parent()
#		carry.entered(self)
#	elif tmp[1] != null and tmp[1].is_in_group('carry'):
#		carry = tmp[1].get_parent().get_parent()
#		carry.entered(self)
#	elif carry != null:
#		carry.left(self)
#		carry = null

	if (tmp[0].size() > 1 and not platform or in_terrain == 0 and terrain != 1):
		#print("enterando")
		on_air_time = 0
		jumping = false
		if (in_terrain == 0):
			terrain = 1

	if (on_air_time < JUMP_MAX_AIRBORNE_TIME and not jumping and jump) or (in_terrain > 0 and jump):
		#print(on_air_time)
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -invert_vertical * JUMP_SPEED * terrain
		jumping = true
		on_air_time += delta

		# Integrate forces to velocity
	velocity += force * delta
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))
		
func moving_left():
	return move_left and not move_right

func moving_right():
	return move_right and not move_left
	
func die():
	dead = true
	if invert_horizontal == -1 or invert_vertical == -1:
		$AnimationPlayer.play("Death2")
	else:
		$AnimationPlayer.play("Death")
	
func reset_position():
	self.set_position(initpos)
	
func ground():
	return [$Feet.get_overlapping_bodies(), $Feet.get_overlapping_areas()]
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name.begins_with("Death"):
		if restart or (!on_act3 and not clone):
			global.restart()
		elif !clone:
			if global.nclones > 0:
				Recorder.play_all()
			else:
				global.restart()
		else:
			return

func is_interacting():
	return interacting

func view():
	return view

func siding():
	return $sprite/Siding.get_overlapping_bodies()
	
func head():
	return $Head.get_overlapping_bodies()

