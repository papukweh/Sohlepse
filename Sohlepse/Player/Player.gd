extends KinematicBody2D

var GRAVITY = 700.0 # pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 400
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 300
const STOP_FORCE = 1500
const JUMP_SPEED = 380
const JUMP_MAX_AIRBORNE_TIME = 0.000000001

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
onready var clone = true
onready var on_act3 = global.current_act() == 3
onready var initpos = self.get_position()

func _process(delta):
	if Recorder == null and on_act3 and not clone:
		Recorder = get_parent().get_parent().get_recorder()
	if dead:
		return
	if Input.is_action_just_pressed("change-v"):
		invert_vertical *= -1
		self.rotate(PI)
		GRAVITY *= -1
	if Input.is_action_just_pressed("change-h"):
		invert_horizontal *= -1
	if Input.is_action_just_pressed("restart"):
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
	
func _physics_process(delta):
	if dead:
		return
	# Create forces
	var force = Vector2(0, GRAVITY)
	var stop = true
	
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
			$Siding.position.x = -64
		else:
			$sprite.scale.x = invert_vertical
			$Siding.position.x = 0
		
		siding_left = new_siding_left
	
	# Integrate forces to velocity
	velocity += force * delta
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if $RC_down.is_colliding():
		on_air_time = 0
		jumping = false
		#if in_terrain == 0:
			#terrain = 1.0

	if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not jumping:
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -invert_vertical * JUMP_SPEED * terrain
		jumping = true
	
	on_air_time += delta
	
func moving_left():
	return move_left and not move_right

func moving_right():
	return move_right and not move_left
	
func view():
	return $Siding.get_collider()
	
func die():
	dead = true
	$AnimationPlayer.play("Death")
	
func reset_position():
	self.set_position(initpos)
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Death":
		global.restart()
