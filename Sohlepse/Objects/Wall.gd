extends StaticBody2D

export var begin = 0 # 0 = default is enabled
signal triggered
export var activation = 0 #alternates
export var forest = 0
onready var active = true
onready var transmitter = false
onready var bcount = 0
onready var active_buttons = 1

func _ready():
	print("READY")
	if begin != 0:
		$Wall_spr.hide()
		$CollisionShape2D.disabled = true
		active = false
	else:
		$Wall_spr.show()
		$CollisionShape2D.disabled = false
		active = true
	
	if forest != 0:
		$Wall_spr.animation = "forest"
	
	for g in self.get_groups():
		print("TEM GRUPO")
		if !g.begins_with("root"):
			print("bcount+1")
			bcount = bcount + 1
	if activation != 0:
		if bcount == 1:
			print("setei 10")
			$AnimatedSprite.animation = "10"
		elif bcount == 2:
			$AnimatedSprite.animation = "20"
		elif bcount == 3:
			$AnimatedSprite.animation = "30"
		else:
			print("Invalid number of buttons for " + $Wall_spr.name)

func onTriggered():
	var trigger = false
	if !global.restarting:
		if activation != 0:
			active_buttons = 0 
			active = false
			for g in self.get_groups():
				if !g.begins_with("root") and !g.begins_with("idle"):
					if get_tree():
						for n in get_tree().get_nodes_in_group(g):
							#print(n.get_name())
							#$AnimatedSprite.animation = str(int($AnimatedSprite.animation) + 1)
							#print($AnimatedSprite.animation)
							#print(n.activated)
							if n.transmitter and n.activated:
								active_buttons += 1
			#print("ativados: " + str(active_buttons))
			global.play_se(global.SE_LED,-5)
			$Wall_spr.show()
			$CollisionShape2D.disabled = false
			if bcount == 2:
				$AnimatedSprite.animation = str(20+active_buttons)
			elif bcount == 3:
				$AnimatedSprite.animation = str(30+active_buttons)
			
			if bcount == active_buttons:
				active = true
				trigger = true
				#$Wall_spr.hide()
				#$CollisionShape2D.disabled = true
		#print("trigger="+str(trigger)+" act="+str(active)+" and begin="+str(begin))
			
		if activation == 0 or trigger:
			#print("trigger")
			#print("bcount="+str(bcount))
			global.play_se(global.SE_WALL,-12)
			var leds = int(str(bcount)+str(bcount))
			if active and begin == 0:
				$AnimatedSprite.animation = str(leds)
				$Wall_spr.hide()
				$CollisionShape2D.disabled = true
				active = false
			elif !active and begin != 0:
				$AnimatedSprite.animation = str(leds-1)
				$Wall_spr.show()
				$CollisionShape2D.disabled = false
				active = true
			elif active and begin != 0:
				$AnimatedSprite.animation = str(leds)
				$Wall_spr.hide()
				$CollisionShape2D.disabled = true
				active = false
			elif !active and begin == 0:
				$AnimatedSprite.animation = str(leds-1)
				$Wall_spr.show()
				$CollisionShape2D.disabled = false
				active = true
