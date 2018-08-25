extends Camera2D

onready var target = null

func _physics_process(delta):
    if target:
        position = target.position