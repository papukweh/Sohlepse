extends StaticBody2D

export var object = ""

onready var bid = get_name().substr(6,2)
onready var obj = get_parent().get_node(object+bid)
signal hit
signal out

func _ready():
	obj.connect("triggered", obj, "_on_" + object + "_triggered")
	obj.connect("default", obj, "_on_" + object + "_default")

func _process(delta):
	if $left.is_colliding() || $right.is_colliding() || $up.is_colliding():
		emit_signal("hit")
	else:
		emit_signal("out")

func _on_ButtonInst_hit():
	$AnimatedSprite.animation = "pressed"
	$CollisionShape2D.disabled = true
	obj.emit_signal("triggered")

func _on_ButtonInst_out():
	$AnimatedSprite.animation = "default"
	$CollisionShape2D.disabled = false
	obj.emit_signal("default")
