extends Area2D

export var forest = 0
onready var pref = "lab_"
var NumberOfTouches = 2

func _ready():
	if forest != 0:
		pref = "forest_"
	$StaticBody2D/AnimatedSprite.animation = pref + "default"
	
func _on_FallingFloor_body_entered(body):
	if(body.get_name().begins_with("Player") or body.get_name().begins_with("Box")):
		NumberOfTouches = NumberOfTouches - 1
		if(NumberOfTouches == 1):
			$StaticBody2D/AnimatedSprite.animation = pref + "broken"
		if(NumberOfTouches == 0):
			$Timer.start()

func _on_Timer_timeout():
	queue_free()
