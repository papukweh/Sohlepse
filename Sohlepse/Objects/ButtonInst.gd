extends StaticBody2D

export var object = ""

onready var sig = get_name()

signal hit
signal out
signal triggered
signal default

func _ready():
	for n in get_tree().get_nodes_in_group(sig):
		connect("triggered", n, "_onTriggered")
		connect("default", n, "_onDefault")

func _process(delta):
	if $left.is_colliding() || $right.is_colliding() || $up.is_colliding():
		emit_signal("hit")
	else:
		emit_signal("out")

func _on_ButtonInst_hit():
	$AnimatedSprite.animation = "pressed"
	$CollisionShape2D.disabled = true
	emit_signal("triggered")

func _on_ButtonInst_out():
	$AnimatedSprite.animation = "default"
	$CollisionShape2D.disabled = false
	emit_signal("default")
