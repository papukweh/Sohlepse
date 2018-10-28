extends KinematicBody2D

export var invert_vertical = 1

var GRAVITY = 700.0 # pixels/second/second
var DEACCEL = 100.0
var velocity = Vector2()
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

	if player != null:
		player.pushing = false
		player = null
	
	var left = left()
	#print(left)
	for l in left:
		print(l.get_name())
		if l.get_name() == "Siding":
			player = l.get_parent().get_parent()
			break
		if player:
			player.pushing = false
			player = null

	var right = right()
	#print(right)
	if player == null:
		for r in right:
			if r.get_name() == "Siding":
				player = r.get_parent().get_parent()
				break
			if player:
				player.pushing = false
				player = null

	if player != null and player.is_interacting():
		player.pushing = true
		if player.moving_left():
			velocity.x = -200
		elif player.moving_right():
			velocity.x = 200
	else:
		velocity.x = 0
		
	velocity += force * delta	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
#	if player != null:
#		player.pushing = false
#		player = null
#
#func _on_RC_left_body_entered(body):
#	if body.get_name().begins_with("Player") and body.view() == self:
#		player = body
#
#func _on_RC_left_body_exited(body):
#	if body.get_name().begins_with("Player"):
#		player = null
#		body.pushing = false
#
#func _on_RC_right_body_entered(body):
#	if body.get_name().begins_with("Player") and body.view() == self:
#		player = body
#
#func _on_RC_right_body_exited(body):
#	if body.get_name().begins_with("Player"):
#		player = null
#		body.pushing = false

func _on_Area2D_body_entered(body):
	if body.is_in_group('gravity') and body != self:
		if body.get_name().begins_with("Player"):
			var tmp = body.ground()
			var confirm = false
			for t in tmp[1]:
				if t.get_name() == "Teto":
					confirm = true
			if not confirm:
				return
			objs[body.get_name()] = body

func _on_Area2D_body_exited(body):
		if body.is_in_group('gravity') and body != self:
			body.GRAVITY = 700
			if objs.has(body.get_name()):
				objs.erase(body.get_name())

func get_objs():
	return objs

func falling():
	print("falling")
	var tmp = $Down.get_overlapping_areas()
	for x in tmp:
		print(x.get_name())
		var p1 = x.get_global_position().y
		var box = self.get_global_position().y
		if x.get_name()=="Head" and (p1 > box):
			return true
		else:
			return false

func left():
	return $RC_left.get_overlapping_areas()
	
func right():
	return $RC_right.get_overlapping_areas()