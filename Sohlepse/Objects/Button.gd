extends Area2D

export var object = "" # Mandatory. Only needs the type of the object ('Wall'/'Thorns'), connects with the correct number right away
export var object2 = "" # Is optional. Must be the exact name of the node you want to link

#button1
onready var bid = get_name().substr(6,2)
onready var obj = get_parent().get_node(object+bid)
var obj2

signal hit
	
func _ready():
	obj.connect("triggered", obj, "_on_" + object + "_triggered")
	if object2 != "":
		obj2 = get_parent().get_node(object2)
		if object2.begins_with("Wall"):
			print("denovo")
			obj2.connect("triggered2", obj2, "_on_Wall_triggered2")
		elif object2.begins_with("Thorns"):
			obj2.connect("triggered2", obj2, "_on_Thorns_triggered2")
	
func _on_Button_body_entered(body):
	$CollisionShape2D.disabled = true
	$AnimatedSprite.animation = "pressed"
	emit_signal("hit")

func _on_Button_hit():
	obj.emit_signal("triggered")
	if object2 != "":
		obj2.emit_signal("triggered2")
