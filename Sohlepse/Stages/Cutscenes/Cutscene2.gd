extends Node2D
var moveleft = []
var lookright = []
var interact = []
var count = 0

func _ready():
	global.stop_bgm()
	$Player2.clone = true
	$Player.clone = true
	$Player2.evil()
	$Player2.hide()
	for i in range(50):
		for i in range(10):
			moveleft.push_back([false,true,false,false])
		for i in range(2):
			moveleft.push_back([false,false,false,false])
	
	for i in range(100):
		interact.push_back([false,false,false,false])
		lookright.push_back([false,false,false,false])
	
	for i in range(15):
		lookright.push_back([true,false,false,false])
		interact.push_back([false,false,false,true])
	
	$Player/InputHandler.inputs = [] + moveleft
	$Player/InputHandler.MODE = 0

func _on_Exit_body_entered(body):
	if body.get_name() == "Player" and count == 0:
		count+=1
	elif body.get_name() == "Player" and count == 1:
		count += 1
		$Player2.show()
		$Player2.terrain = 0.5
		$Player2.in_terrain +=1
		$Player/InputHandler.inputs = [] + lookright
		$Player2/InputHandler.inputs = [] +  moveleft
		$Player2/InputHandler.MODE = 0
	elif count == 2:
		count+=1
		$Player2/InputHandler.inputs = []
		$Player/InputHandler.inputs = [] + moveleft
	elif count == 3:
		$Player/InputHandler.inputs = [] + interact
		global.play_se(global.SE_EVIL_LAUGH, -5)
		$Timer.start()

func _on_Timer_timeout():
	global.play_se(global.SE_JOGAR)
	get_tree().change_scene("Manager/StageManager.tscn")
