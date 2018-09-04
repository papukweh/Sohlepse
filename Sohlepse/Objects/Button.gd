extends Area2D

export var object = ""

#button1
onready var bid = get_name().substr(6,2)
onready var obj = get_parent().get_node(object+bid)
signal hit
	
func _ready():
	obj.connect("triggered", obj, "_on_" + object + "_triggered")
	
func _on_Button_body_entered(body):
	$CollisionShape2D.disabled = true
	$AnimatedSprite.animation = "pressed"
	emit_signal("hit")

func _on_Button_hit():
	obj.emit_signal("triggered")
