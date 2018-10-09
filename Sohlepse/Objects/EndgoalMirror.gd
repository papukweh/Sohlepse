extends KinematicBody2D
var inbodyM = null
var inEndGoal = false

export var invert_vertical = 1
var GRAVITY = 700
var velocity = Vector2()

func _process(delta):
	if inbodyM != null and inbodyM.get_name().begins_with("Player"):
		inEndGoal = true
	else:
		inEndGoal = false
	pass

func _physics_process(delta):
	var force = Vector2(0, invert_vertical * GRAVITY)
	
	velocity += force * delta	
	velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_EndgoalMirror_body_entered(body):
	inbodyM = body
	pass

func _on_EndgoalMirror_body_exited(body):
	inbodyM = null
	pass
