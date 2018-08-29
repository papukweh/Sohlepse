extends Area2D

func _on_Area_body_entered(body):
	if (body.get_name().begins_with("player")):
		body.terrain = 0.2
		body.in_terrain = body.in_terrain + 1
		print ("inside: " + str(body.in_terrain))


func _on_Area_body_exited(body):
	if (body.get_name().begins_with("player")):
		body.in_terrain = body.in_terrain - 1
		print("out: " + str(body.in_terrain))
