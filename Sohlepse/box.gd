extends KinematicBody2D

var GRAVITY = 700.0 # pixels/second/second
var velocity = Vector2()
onready var push = false

func _process(delta):
	if Input.is_action_just_pressed("change-v"):
		GRAVITY *= -1
	pass

func _physics_process(delta):
	var force = Vector2(0, GRAVITY)
	
	if Input.is_action_pressed("interact"):
		push = true
	else:
		push = false
		
	var player = null
	
	if $RC_left.is_colliding():
		player = $RC_left.get_collider()
	elif $RC_right.is_colliding():
		player = $RC_right.get_collider()
	
	if player != null and push:
		if player.moving_left():
			velocity.x = -200
		elif player.moving_right():
			velocity.x = 200
	else:
		velocity.x = 0	
		
	velocity += force * delta	
	velocity = move_and_slide(velocity, Vector2(0, -1))