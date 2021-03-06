extends Area2D

onready var sig = get_name()
onready var activated = false
onready var transmitter = true
signal hit
signal triggered
	
func _ready():
	for n in get_tree().get_nodes_in_group(sig):
		#print("connecting "+sig+" to "+n.get_name())
		connect("triggered", n, "onTriggered")
	
func _on_Button_body_entered(body):
	if !activated:
		$CollisionShape2D.disabled = true
		$AnimatedSprite.animation = "pressed"
		emit_signal("hit")

func _on_Button_hit():
	global.play_se(global.SE_LEVER)
	activated = true
	emit_signal("triggered")

func onTriggered():
	pass