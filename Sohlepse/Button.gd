extends Area2D

#button1
onready var bid = get_name().substr(6,1)
onready var wall = get_parent().get_node("wall"+bid)
signal hit
	
func _ready():
	wall.connect("hidden", wall, "_on_Wall_hidden")
	
func _on_Button_body_entered(body):
	$CollisionShape2D.disabled = true
	$AnimatedSprite.animation = "pressed"
	emit_signal("hit")

func _on_Button_hit():
	wall.emit_signal("hidden")
