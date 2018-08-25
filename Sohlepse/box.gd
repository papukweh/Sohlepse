extends KinematicBody2D

var GRAVITY = 700.0 # pixels/second/second
var DEACCEL = 100.0
var velocity = Vector2()

func _process(delta):
	if Input.is_action_just_pressed("change-v"):
		GRAVITY *= -1
	pass

func _physics_process(delta):
	var force = Vector2(0, GRAVITY)
	var player = null
	
	if $RC_left.is_colliding():
		player = $RC_left.get_collider()
	if $RC_right.is_colliding() and (player == null or not player.get_name().begins_with("player")):
		player = $RC_right.get_collider()
	
	if player != null and player.get_name().begins_with("player"):
		if Input.is_action_pressed("interact") and player.view() == self:
			player.pushing = true
			if player.moving_left():
				velocity.x = -200
			elif player.moving_right():
				velocity.x = 200
		else:
			player.pushing = false
	else:
		velocity.x = 0

	velocity += force * delta	
	velocity = move_and_slide(velocity, Vector2(0, -1))