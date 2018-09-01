extends Area2D

var NumberOfTouches = 2

func _on_FallingFloor_body_entered(body):
	if(body.get_name().begins_with("Player") or body.get_name().begins_with("Box")):
		NumberOfTouches = NumberOfTouches - 1
		if(NumberOfTouches == 1):
			$StaticBody2D/AnimatedSprite.animation = "broken"
		if(NumberOfTouches == 0):
			queue_free()
