extends Node2D

export var begin = 0 # 0 = default is deactivated
export var activation = 0
export var forest = 0
onready var pref = "lab_"
onready var on = false
onready var inside = 0
onready var transmitter = false
onready var who = null

func _ready():
	if forest != 0:
		pref = "forest_"
	if begin == 0:
		$Body/AnimatedSprite.animation = pref + "off"
	else:
		on = true
		$Body/AnimatedSprite.animation = pref + "on"

func _process(delta):
	if on:
		try_kill()

func onTriggered():
	var trigger = true
	if activation != 0:
		for g in self.get_groups():
			if !g.begins_with("root") and !g.begins_with("idle"):
				for n in get_tree().get_nodes_in_group(g):
					print(n.get_name()+" in "+g)
					if n.transmitter and !n.activated:
						trigger = false

	if trigger: 
		global.play_se(global.SE_THORNS,-7)
		if !on and begin == 0:
			$Body/AnimatedSprite.animation = pref + "on"
			on = true
		elif on and begin != 0:
			$Body/AnimatedSprite.animation = pref + "off"
			on = false
		elif on and begin == 0:
			$Body/AnimatedSprite.animation = pref + "off"
			on = false
		elif !on and begin != 0:
			$Body/AnimatedSprite.animation = pref + "on"
			on = true
	elif activation != 0:
		global.play_se(global.SE_THORNS,-7)
		if on and begin == 0:
			$Body/AnimatedSprite.animation = pref + "off"
			on = false
		elif !on and begin != 0:
			$Body/AnimatedSprite.animation = pref + "on"
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