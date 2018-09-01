extends Camera2D

onready var target = null

func _physics_process(delta):
	if target:
		target.clone = false
		position = target.position