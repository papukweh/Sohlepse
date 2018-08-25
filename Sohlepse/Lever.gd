extends Area2D

var inbody = null
var activated = false
signal hit

onready var bid = get_name().substr(5,1)
onready var wall = get_parent().get_node("wall"+bid)

#lever1
func _ready():
	wall.connect("hidden", wall, "_on_Wall_hidden")
	wall.connect("shown", wall, "_on_Wall_shown")
	
func _process(delta):
	if inbody != null and inbody.get_name().begins_with("player") and Input.is_action_just_pressed("interact"):
		emit_signal("hit")
	
func _on_Lever_body_entered(body):
	inbody = body

func _on_Lever_body_exited(body):
	inbody = null

func _on_Lever_hit():
	if !activated:
		$AnimatedSprite.animation = "on"
		wall.emit_signal("hidden")
		activated = true
	else:
		$AnimatedSprite.animation = "off"
		wall.emit_signal("shown")
		activated = false




