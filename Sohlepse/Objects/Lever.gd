extends Area2D

onready var activated = false
onready var transmitter = true
var inbody = null
var timeout = 0
signal hit
signal triggered
export(Array, String) var names = []

onready var sig = get_name()

#lever1
func _ready():
	if names != null:
		for name in names:
			for n in get_tree().get_nodes_in_group(name):
				connect("triggered", n, "onTriggered")
	else:
		for n in get_tree().get_nodes_in_group(sig):
			connect("triggered", n, "onTriggered")
	
func _process(delta):
	timeout-=1
	if timeout <= 0 and inbody != null and inbody.is_in_group("Player") and inbody.is_interacting():
		emit_signal("hit")
		timeout = 10
	
func _on_Lever_body_entered(body):
	inbody = body

func _on_Lever_body_exited(body):
	inbody = null

func _on_Lever_hit():
	if !activated:
		$AnimatedSprite.animation = "on"
		activated = true
		emit_signal("triggered")

	else:
		$AnimatedSprite.animation = "off"
		activated = false
		emit_signal("triggered")


func onTriggered():
	pass