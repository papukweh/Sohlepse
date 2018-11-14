extends Area2D

func _on_Area_body_entered(body):
		if (body.is_in_group("gravity")):
			global.play_se(global.SE_WATER)
			if (body.is_in_group("Player")):
				body.terrain = 0.2
				body.in_terrain = body.in_terrain + 1


func _on_Area_body_exited(body):
	if (body.is_in_group("Player")):
		body.in_terrain = body.in_terrain - 1
		body.water = true
