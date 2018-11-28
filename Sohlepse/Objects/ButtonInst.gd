extends StaticBody2D

onready var sig = get_name()
onready var activated = false
onready var transmitter = true
onready var cbody = 0
export(Array, String) var names = []

signal hit
signal out
signal triggered

func _ready():
	#print(names)
	if names != null:
		#print("not null")
		for name in names:
			for n in get_tree().get_nodes_in_group(name):
				#print("connecting "+sig+" to "+n.get_name())
				connect("triggered", n, "onTriggered")
	else:
		#print("is null")
		for n in get_tree().get_nodes_in_group(sig):
			#print("connecting "+sig+" to "+n.get_name())
			connect("triggered", n, "onTriggered")
	$AnimatedSprite.animation = "default"
	$CollisionShape2D.disabled = false

func _on_ButtonInst_hit(body):
	global.play_se(global.SE_LEVER)
	if body != self:
		cbody +=1
		$AnimatedSprite.animation = "pressed"
		$CollisionShape2D.disabled = true
		if !activated:
			activated = true
			emit_signal("triggered")

func _on_ButtonInst_out(body):
	cbody -= 1
	if cbody == 0 and body != self:
		$AnimatedSprite.animation = "default"
		$CollisionShape2D.disabled = false
		activated = false
		emit_signal("triggered")

func onTriggered():
	pass