extends Area2D

var NumberOfTouches = 2

func _on_FallingFloor_body_entered(body):
	if(body.get_name().begins_with("player") or body.get_name().begins_with("box")):
		NumberOfTouches = NumberOfTouches - 1
		if(NumberOfTouches == 0):
			queue_free()
