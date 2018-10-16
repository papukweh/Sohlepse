extends KinematicBody2D

export var invert_vertical = 1

var GRAVITY = 700.0 # pixels/second/second
var DEACCEL = 100.0
var velocity = Vector2()
var oldposy = 0
onready var player = null
onready var objs = Dictionary()

func _ready():
	if invert_vertical == -1:
		self.scale.y = -1

func _process(delta):
	if Input.is_action_just_pressed("change-v"):
		GRAVITY *= -1
	pass

func _physics_process(delta):
	var force = Vector2(0, invert_vertical * GRAVITY)
	if player and player.is_interacting():
		player.pushing = true
		if player.moving_left():
			velocity.x = -200
		elif player.moving_right():
			velocity.x = 200
	else:
		velocity.x = 0
		
	velocity += force * delta	
	oldposy = position.y
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

func _on_Area2D_body_entered(body):
	if body.is_in_group('gravity') and body != self:
		if body.get_name().begins_with("Player"):
			if body.ground().get_name() == "Teto":
				print("coloquei !!!!!")
			else:
				return
			objs[body.get_name()] = body

func _on_Area2D_body_exited(body):
		if body.is_in_group('gravity') and body != self:
			if objs.has(body.get_name()):
				objs.erase(body.get_name())

func get_objs():
	return objs
		
func falling():
	return !$Down.is_colliding() or $Down.get_collider().get_name()=="Head"