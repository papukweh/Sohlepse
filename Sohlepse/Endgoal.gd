extends Area2D

var inbody = null

func _process(delta):
	if inbody != null and inbody.get_name().begins_with("player") and Input.is_action_just_pressed("interact"):
		global.current_stage += 1
		get_tree().reload_current_scene()
		
func _on_Endgoal_body_entered(body):
	inbody = body

func _on_Endgoal_body_exited(body):
	inbody = null