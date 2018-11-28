extends Node2D
var moveright = []
var lookleft = []
var interact = []
var count = 0

const MOVE_RIGHT = [false, true, false, false]
const MOVE_LEFT = [true, false, false, false]
const IDLE = [false, false, false, false]
const INTERACT = [false, false, false, true]

func _ready():
	global.stop_bgm()
	$Player2.clone = true
	$Player.clone = true
	$Player2.evil()
	$Player2.hide()
	for i in range(50):
		for i in range(10):
			moveright.push_back(MOVE_RIGHT)
		for i in range(2):
			moveright.push_back(IDLE)
	
	for i in range(100):
		interact.push_back(IDLE)
		lookleft.push_back(IDLE)
	
	for i in range(15):
		lookleft.push_back(MOVE_LEFT)
		interact.push_back(INTERACT)
	
	$Player/InputHandler.inputs = [] + moveright
	$Player/InputHandler.MODE = 0

func _on_Exit_body_entered(body):
	if body.get_name() == "Player" and count == 0:
		count+=1
	elif body.get_name() == "Player" and count == 1:
		count += 1
		$Player2.show()
		$Player2.terrain = 0.5
		$Player2.in_terrain +=1
		$Player/InputHandler.inputs = [] + lookleft
		$Player2/InputHandler.inputs = [] +  moveright
		$Player2/InputHandler.MODE = 0
	elif count == 2:
		count+=1
		$Player2/InputHandler.inputs = []
		$Player/InputHandler.inputs = [] + moveright
	elif count == 3:
		$Player/InputHandler.inputs = [] + interact
		global.play_se(global.SE_EVIL_LAUGH, -5)
		$Timer.start()

func _on_Timer_timeout():
	global.play_se(global.SE_JOGAR)
	get_tree().change_scene("Manager/StageManager.tscn")
