extends Node2D

export var begin = 0 # 0 = default is deactivated
export var activation = 0
onready var on = false
onready var inside = 0
onready var transmitter = false
onready var who = null

func _ready():
	if begin == 0:
		$Body/AnimatedSprite.animation = "off"
	else:
		on = true
		$Body/AnimatedSprite.animation = "on"

func _process(delta):
	if on:
		try_kill()

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
			$Body/AnimatedSprite.animation = "on"
			on = true
		elif on and begin != 0:
			$Body/AnimatedSprite.animation = "off"
			on = false
		elif on and begin == 0:
			$Body/AnimatedSprite.animation = "off"
			on = false
		elif !on and begin != 0:
			$Body/AnimatedSprite.animation = "on"
			on = true
	elif activation != 0:
		if on and begin == 0:
			$Body/AnimatedSprite.animation = "off"
			on = false
		elif !on and begin != 0:
			$Body/AnimatedSprite.animation = "on"
			on = true

func _on_Thorns_body_entered(body):
	if body.get_name().begins_with("Player"):
		who = body
		inside += 1
		if (on and not body.dead):
			body.die()

func _on_Thorns_body_exited(body):
	if body.get_name().begins_with("Player"):
		inside -= 1

func try_kill():
	var tmp = $Body/Area2D.get_overlapping_bodies()
	for i in tmp:
		if i.is_in_group("Player") and !i.dead:
			i.die()
			inside -= 1