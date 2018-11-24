extends Node2D


func _ready():
	$Player.clone = true
	var arr = []
	for i in range(30):
		for i in range(10):
			arr.push_back([false, true, false, false])
		for i in range(2):
			arr.push_back([false, false, false, false])
	$Player/InputHandler.inputs = arr
	$Player/InputHandler.MODE = 0

func _on_Exit_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene("Manager/StageManager.tscn")
