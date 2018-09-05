extends KinematicBody2D

export var invert_vertical = 1

var GRAVITY = 700.0 # pixels/second/second
var DEACCEL = 100.0
var velocity = Vector2()
onready var player = null

func _process(delta):
	if Input.is_action_just_pressed("change-v"):
		GRAVITY *= -1
	pass

func _physics_process(delta):
	var force = Vector2(0, invert_vertical * GRAVITY)
	if player and Input.is_action_pressed("interact"):
		player.pushing = true
		if player.moving_left():
			velocity.x = -200
		elif player.moving_right():
			velocity.x = 200
	else:
		velocity.x = 0
		
	velocity += force * delta	
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _on_RC_left_body_entered(body):
	if body.get_name().begins_with("Player") and body.view() == self:
		player = body

func _on_RC_left_body_exited(body):
	if body.get_name().begins_with("Player"):
		player = null
		body.pushing = false

func _on_RC_right_body_entered(body):
	if body.get_name().begins_with("Player") and body.view() == self:
		player = body

func _on_RC_right_body_exited(body):
	if body.get_name().begins_with("Player"):
		player = null
		body.pushing = false
