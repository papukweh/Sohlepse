extends Area2D

export var begin = 0 # 0 = default is deactivated
export var activation = 0
onready var on = false
onready var inside = false
onready var transmitter = false
onready var who = null

func _ready():
	if begin == 0:
		$AnimatedSprite.animation = "off"
	else:
		on = true
		$AnimatedSprite.animation = "on"
	
func onTriggered():
	var trigger = true
	if activation != 0:
		for g in self.get_groups():
			if !g.begins_with("root"):
				for n in get_tree().get_nodes_in_group(g):
					if n.transmitter and  !n.activated:
						trigger = false
						
	if trigger: 
		if !on and begin == 0:
			$AnimatedSprite.animation = "on"
			on = true
		elif on and begin != 0:
			$AnimatedSprite.animation = "off"
			on = false
		elif on and begin == 0:
			$AnimatedSprite.animation = "off"
			on = false
		elif !on and begin != 0:
			$AnimatedSprite.animation = "on"
			on = true
	elif activation != 0:
		if on and begin == 0:
			$AnimatedSprite.animation = "off"
			on = false
		elif !on and begin != 0:
			$AnimatedSprite.animation = "on"
			on = true
	if inside:
		_on_Thorns_body_entered(who)

func _on_Thorns_body_entered(body):
	who = body
	inside = true
	if (on and body.get_name().begins_with("Player") and not body.dead):
		body.die()


func _on_Thorns_body_exited(body):
	inside = false
