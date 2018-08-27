extends Area2D

func _on_Area_body_entered(body):
	if (body.get_name().begins_with("player")):
		body.terrain = 0.2
		body.in_terrain = true
		print ("inside")


func _on_Area_body_exited(body):
	if (body.get_name().begins_with("player")):
		body.in_terrain = false
		print("out")
