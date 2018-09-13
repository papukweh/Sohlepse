extends Area2D

#button1
onready var sig = get_name()
onready var activated = false
onready var transmitter = true
signal hit
signal triggered
	
func _ready():
	for n in get_tree().get_nodes_in_group(sig):
		connect("triggered", n, "onTriggered")
	
func _on_Button_body_entered(body):
	$CollisionShape2D.disabled = true
	$AnimatedSprite.animation = "pressed"
	emit_signal("hit")

func _on_Button_hit():
	activated = true
	emit_signal("triggered")

func onTriggered():
	pass