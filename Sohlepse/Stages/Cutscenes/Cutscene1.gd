extends Node2D
var arr = []
var arr2 = []
var count = 0

func _ready():
	global.stop_bgm()
	$Player2.clone = true
	$Player.clone = true
	$Player2.evil()
	$Player2.hide()
	for i in range(30):
		for i in range(10):
			arr.push_back([false, true, false, false])
			arr2.push_back([false, true, false, false])
		for i in range(2):
			arr.push_back([false, false, false, false])
	$Player/InputHandler.inputs = arr
	$Player/InputHandler.MODE = 0

func _on_Exit_body_entered(body):
	if body.get_name() == "Player" and count == 0:
		count +=1
		return
	elif body.get_name() == "Player" and count == 1:
		$Player2.show()
		$Player2.terrain = 0.2
		$Player2.in_terrain +=1
		$Player2/InputHandler.inputs = arr2
		$Player2/InputHandler.MODE = 0
	elif body.get_name() == "Player2":
		get_tree().change_scene("Manager/StageManager.tscn")
