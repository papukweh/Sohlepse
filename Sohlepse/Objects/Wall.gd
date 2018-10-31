extends StaticBody2D

export var begin = 0 # 0 = default is enabled
signal triggered
export var activation = 0 #alternates
onready var active = true
onready var transmitter = false
onready var bcount = 0
onready var active_buttons = 1

func _ready():
	if begin != 0:
		self.hide()
		$CollisionShape2D.disabled = true
		active = false
	else:
		self.show()
		$CollisionShape2D.disabled = false
		active = true
	
	if activation != 0:
		for g in self.get_groups():
			if !g.begins_with("root"):
				bcount = bcount + 1
		if bcount == 1:
			$AnimatedSprite.animation = "10"
		elif bcount == 2:
			$AnimatedSprite.animation = "20"
		elif bcount == 3:
			$AnimatedSprite.animation = "30"
		else:
			print("Invalid number of buttons for " + self.name)

func onTriggered():
	if !global.restarting :
		var trigger = true
		if activation != 0:
			active_buttons = 0 
			for g in self.get_groups():
				if !g.begins_with("root") and !g.begins_with("idle"):
					if get_tree():
						for n in get_tree().get_nodes_in_group(g):
							print(n.get_name())
							$AnimatedSprite.animation = str(int($AnimatedSprite.animation) + 1)
							print($AnimatedSprite.animation)
							#print(n.activated)
							if n.transmitter and !n.activated:
								trigger = false
							elif n.transmitter and n.activated:
								print("entrei "+self.get_name())
								active_buttons += 1
			print("ativados: " + str(active_buttons))
			if bcount == 2 and active_buttons != 2:
				$AnimatedSprite.animation = str(20+active_buttons)
				self.show()
			elif bcount == 3 and active_buttons != 3:
				$AnimatedSprite.animation = str(30+active_buttons)
				self.show()
		print("trigger="+str(trigger)+" act="+str(active)+" and begin="+str(begin))
		
		if trigger:
			if active and begin == 0:
				print("some porra")
				self.hide()
				$CollisionShape2D.disabled = true
				active = false
			elif !active and begin != 0:
				self.show()
				$CollisionShape2D.disabled = false
				active = true
			elif active and begin != 0:
				self.hide()
				$CollisionShape2D.disabled = true
				active = false
			elif !active and begin == 0:
				self.show()
				$CollisionShape2D.disabled = false
				active = true
		elif activation != 0:
			if active and begin != 0:
				print("some porra2")
				self.hide()
				$CollisionShape2D.disabled = true
				active = false
			elif !active and begin == 0:
				self.show()
				$CollisionShape2D.disabled = false
				active = true
