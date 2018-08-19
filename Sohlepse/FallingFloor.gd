extends Area2D

var NumberOfTouches = 2
var isTouching = false

func _on_FallingFloor_body_entered(body):
	if(!isTouching and body.get_name() == "player"):
		NumberOfTouches = NumberOfTouches - 1
		isTouching = true
		if(NumberOfTouches == 0):
			queue_free()
	else:
		isTouching = false
