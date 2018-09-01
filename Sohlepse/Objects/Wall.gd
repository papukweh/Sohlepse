extends StaticBody2D

signal hidden
signal shown

func _on_Wall_hidden():
	self.hide()
	$CollisionShape2D.disabled = true
	
func _on_Wall_shown():
	self.show()
	$CollisionShape2D.disabled = false