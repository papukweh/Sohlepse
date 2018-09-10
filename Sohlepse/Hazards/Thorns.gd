extends Area2D

export var begin = 0 # 0 = default is deactivated
var on = false
signal triggered
signal default

func _ready():
	if begin == 0:
		$AnimatedSprite.animation = "off"
	else:
		on = true
		$AnimatedSprite.animation = "on"
	
func _onDefault():
	if begin == 0:
		on = false
		$AnimatedSprite.animation = "off"
	else:
		on = true
		$AnimatedSprite.animation = "on"

func _onTriggered():
	if begin == 0:
		on = true
		$AnimatedSprite.animation = "on"
	else:
		on = false
		$AnimatedSprite.animation = "off"

func _on_Thorns_body_entered(body):
	if (on and body.get_name().begins_with("Player") and not body.dead):
		body.die()
