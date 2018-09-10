extends StaticBody2D

signal triggered
signal default

func _onTriggered():
	self.hide()
	$CollisionShape2D.disabled = true
	
func _onDefault():
	self.show()
	$CollisionShape2D.disabled = false