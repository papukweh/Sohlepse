extends Area2D

export var object = ""
var inbody = null
var activated = false
var timeout = 0
signal hit
signal triggered
signal default

onready var sig = get_name()

#lever1
func _ready():
	for n in get_tree().get_nodes_in_group(sig):
		connect("triggered", n, "_onTriggered")
		connect("default", n, "_onDefault")
	#obj.connect("triggered", obj, "_on_" + object + "_triggered")
	#obj.connect("default", obj, "_on_" + object + "_default")
	
func _process(delta):
	timeout-=1
	if timeout <= 0 and inbody != null and inbody.get_name().begins_with("Player") and inbody.is_interacting():
		emit_signal("hit")
		timeout = 10
	
func _on_Lever_body_entered(body):
	inbody = body

func _on_Lever_body_exited(body):
	inbody = null

func _on_Lever_hit():
	if !activated:
		$AnimatedSprite.animation = "on"
		emit_signal("triggered")
		activated = true
	else:
		$AnimatedSprite.animation = "off"
		emit_signal("default")
		activated = false