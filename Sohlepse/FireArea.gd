extends Area2D

func _on_FireArea_body_entered(body):
	if (body.get_name().begins_with("player") and not body.dead):
		body.die()