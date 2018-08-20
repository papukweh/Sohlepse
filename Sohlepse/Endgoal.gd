extends Area2D

var inbody = null

func _process(delta):
	if inbody != null and inbody.get_name().begins_with("player") and Input.is_action_just_pressed("interact"):
		#stage1
		var level = get_tree().get_current_scene().get_name()
		level = level.substr(5,len(level)-1)
		var next = int(level)+1
		next = "stage"+str(next)+".tscn"
		get_tree().change_scene(next)
		
func _on_Endgoal_body_entered(body):
	inbody = body

func _on_Endgoal_body_exited(body):
	inbody = null