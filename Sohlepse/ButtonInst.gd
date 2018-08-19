extends StaticBody2D

onready var bid = get_name().substr(6,1)
onready var wall = get_parent().get_node("wall"+bid)
signal hit
signal out

func _ready():
	wall.connect("hidden", wall, "_on_Wall_hidden")
	wall.connect("shown", wall, "_on_Wall_shown")

func _process(delta):
	if $left.is_colliding() || $right.is_colliding() || $up.is_colliding():
		emit_signal("hit")
	else:
		emit_signal("out")

func _on_ButtonInst_hit():
	$AnimatedSprite.animation = "pressed"
	$CollisionShape2D.disabled = true
	wall.emit_signal("hidden")

func _on_ButtonInst_out():
	$AnimatedSprite.animation = "default"
	$CollisionShape2D.disabled = false
	wall.emit_signal("shown")
