extends Area2D

export var object = ""
var inbody = null
var activated = false
var timeout = 0
signal hit

onready var bid = get_name().substr(5,2)
onready var obj = get_parent().get_node(object + bid)

#lever1
func _ready():
	obj.connect("triggered", obj, "_on_" + object + "_triggered")
	obj.connect("default", obj, "_on_" + object + "_default")
	
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
		obj.emit_signal("triggered")
		activated = true
	else:
		$AnimatedSprite.animation = "off"
		obj.emit_signal("default")
		activated = false