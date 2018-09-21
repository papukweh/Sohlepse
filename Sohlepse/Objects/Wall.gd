extends StaticBody2D

export var begin = 0 # 0 = default is enabled
signal triggered
export var activation = 0 #alternates
onready var active = true
onready var transmitter = false

func _ready():
	if begin != 0:
		self.hide()
		$CollisionShape2D.disabled = true
		active = false
	else:
		self.show()
		$CollisionShape2D.disabled = false
		active = true

func onTriggered():
	var trigger = true
	if activation != 0:
		for g in self.get_groups():
			if !g.begins_with("root"):
				for n in get_tree().get_nodes_in_group(g):
					#print(n.activated)
					if n.transmitter and !n.activated:
						trigger = false
	#print("trigger="+str(trigger)+" act="+str(active)+" and begin="+str(begin))
	if trigger:
		if active and begin == 0:
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
			self.hide()
			$CollisionShape2D.disabled = true
			active = false
		elif !active and begin == 0:
			self.show()
			$CollisionShape2D.disabled = false
			active = true
