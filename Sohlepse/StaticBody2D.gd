extends StaticBody2D

signal hit

func _process(delta):
	if $RayCast2D.is_colliding():
		$RayCast2D.queue_free()
		emit_signal("hit")


func _on_StaticBody2D_hit():
	$Sprite.queue_free()
