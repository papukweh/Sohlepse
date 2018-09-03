extends StaticBody2D

signal triggered
signal default

func _on_Wall_triggered():
	self.hide()
	$CollisionShape2D.disabled = true
	
func _on_Wall_default():
	self.show()
	$CollisionShape2D.disabled = false