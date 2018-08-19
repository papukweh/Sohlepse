extends KinematicBody2D

var GRAVITY = 700.0 # pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 500
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 400
const STOP_FORCE = 1500
const JUMP_SPEED = 500
const JUMP_MAX_AIRBORNE_TIME = 0.2

const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

var velocity = Vector2()
var on_air_time = 10
var jumping = false
var pushing = false

var siding_left = false
export var invert_vertical = 1
export var invert_horizontal = 1
onready var move_left = false
onready var move_right = false

func _process(delta):
	if Input.is_action_just_pressed("change-v"):
		invert_vertical *= -1
		self.rotate(PI)
		GRAVITY *= -1
	if Input.is_action_just_pressed("change-h"):
		invert_horizontal *= -1
	pass
	
func _physics_process(delta):
	# Create forces
	var force = Vector2(0, GRAVITY)
	if Input.is_action_pressed("interact"):
		pushing = true
	else:
		pushing = false
		
	if invert_horizontal == 1:
		move_left = Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right")
		move_right = Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left")
	else:
		move_right = Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right")
		move_left = Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left")
	
	var jump = Input.is_action_pressed("jump")
	var stop = true
	
	if pushing:
		if move_left:
			velocity.x = -200
		elif move_right:
			velocity.x = 200
	else:
		if move_left:
			if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
				force.x -= WALK_FORCE
				stop = false
		elif move_right:
			if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
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
	if velocity.x < 0 and move_left:
		new_siding_left = true
	elif velocity.x > 0 and move_right:
		new_siding_left = false
		
	# Update siding
	if new_siding_left != siding_left:
		if new_siding_left:
			$sprite.scale.x = -invert_vertical
		else:
			$sprite.scale.x = invert_vertical
		
		siding_left = new_siding_left
	
	# Integrate forces to velocity
	velocity += force * delta	
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if $RC_down.is_colliding():
		on_air_time = 0
		jumping = false

	if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not jumping:
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -invert_vertical * JUMP_SPEED
		jumping = true
	
	on_air_time += delta
	
func moving_left():
	return move_left and not move_right

func moving_right():
	return move_right and not move_left
