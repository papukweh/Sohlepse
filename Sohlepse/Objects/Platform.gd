extends Area2D

func _on_Area2D_body_entered(body):
	if body.get_name().begins_with("Player"):
		body.platform = true

func _on_Area2D_body_exited(body):
	if body.get_name().begins_with("Player"):
		body.platform = false
