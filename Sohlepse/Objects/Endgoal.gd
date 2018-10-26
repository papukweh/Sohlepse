extends KinematicBody2D

export var invert_vertical = 1
var inbody = null
var GRAVITY = 700.0 # pixels/second/second
var velocity = Vector2()

func _process(delta):
	if inbody != null and inbody.get_name().begins_with("Player") and Input.is_action_just_pressed("interact"):
		if get_parent().get_node("EndgoalMirror") == null or get_parent().get_node("EndgoalMirror").inEndGoal:
			global.current_stage += 1
			global.save()
			global.clean()
			get_tree().reload_current_scene()

func _physics_process(delta):
	var force = Vector2(0, invert_vertical * GRAVITY)
	
	velocity += force * delta	
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _on_Endgoal_body_entered(body):
	print("etnei")
	inbody = body

func _on_Endgoal_body_exited(body):
	print("sai")
	inbody = null