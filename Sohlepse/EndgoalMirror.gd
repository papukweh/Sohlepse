extends Area2D
var inbodyM = null
var inEndGoal = false

func _process(delta):
	if inbodyM != null and inbodyM.get_name().begins_with("player"):
		inEndGoal = true
	else:
		inEndGoal = false
	pass
	
func _on_EndgoalMirror_body_entered(body):
	inbodyM = body
	pass

func _on_EndgoalMirror_body_exited(body):
	inbodyM = null
	pass
