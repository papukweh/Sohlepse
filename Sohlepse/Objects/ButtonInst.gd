extends StaticBody2D

onready var sig = get_name()
onready var activated = false
onready var transmitter = true

signal hit
signal out
signal triggered

func _ready():
	for n in get_tree().get_nodes_in_group(sig):
		connect("triggered", n, "onTriggered")
	$AnimatedSprite.animation = "default"
	$CollisionShape2D.disabled = false

func _on_ButtonInst_hit(body):
	if body != self:
		$AnimatedSprite.animation = "pressed"
		$CollisionShape2D.disabled = true
		activated = true
		emit_signal("triggered")

func _on_ButtonInst_out(body):
	$AnimatedSprite.animation = "default"
	$CollisionShape2D.disabled = false
	activated = false
	emit_signal("triggered")

func onTriggered():
	pass