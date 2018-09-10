extends Area2D

export var object = ""

#button1
onready var sig = get_name()
signal hit
signal triggered
signal default
	
func _ready():
	for n in get_tree().get_nodes_in_group(sig):
		connect("triggered", n, "_onTriggered")
		connect("default", n, "_onDefault")
	
func _on_Button_body_entered(body):
	$CollisionShape2D.disabled = true
	$AnimatedSprite.animation = "pressed"
	emit_signal("hit")

func _on_Button_hit():
	emit_signal("triggered")
