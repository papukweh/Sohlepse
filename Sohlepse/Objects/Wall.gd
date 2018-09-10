extends StaticBody2D

export var begin = 0 # 0 = default is enabled
signal triggered
signal triggered2
signal default

func _ready():
	if begin != 0:
		self.hide()
		$CollisionShape2D.disabled = true

func _on_Wall_triggered():
	if begin == 0:
		self.hide()
		$CollisionShape2D.disabled = true
	else:
		self.show()
		$CollisionShape2D.disabled = false
		
func _on_Wall_triggered2():
	_on_Wall_triggered()

func _on_Wall_default():
	if begin == 0:
		self.show()
		$CollisionShape2D.disabled = false
	else:
		self.hide()
		$CollisionShape2D.disabled = true