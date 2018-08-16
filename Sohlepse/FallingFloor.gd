extends KinematicBody2D

var NumberOfTouches = 2
var isTouching = false


func fixed_process(delta):
	if($RayCast2D.getcollider() == get_node("player")) :
		if(!isTouching):
			NumberOfTouches = NumberOfTouches - 1
		isTouching = true
		if(NumberOfTouches == 0):
			self.free()
	else:
		isTouching = false
			