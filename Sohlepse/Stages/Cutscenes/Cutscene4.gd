extends Node2D
var moveright = []
var stop = []
var moveleft = []
var interact = []
var count = 0

var color = Color(0, 0, 0, 255)
var color2 = Color(0, 0, 0, 0)

const MOVE_RIGHT = [false, true, false, false]
const MOVE_LEFT = [true, false, false, false]
const IDLE = [false, false, false, false]
const INTERACT = [false, false, false, true]

func _ready():
	global.stop_siren()
	global.stop_bgm()
	$Player2.clone = true
	$Player.clone = true
	$Player.hide()
	$Player.terrain = 0.4
	$Player.in_terrain +=1
	$Player2.wife()
	$Player2.hide()
	for i in range(50):
		for i in range(10):
			moveright.push_back(MOVE_RIGHT)
			moveleft.push_back(MOVE_LEFT)
		for i in range(2):
			moveright.push_back(IDLE)
			moveleft.push_back(IDLE)
	
	for i in range(100):
		interact.push_back(IDLE)
		stop.push_back(IDLE)
	
	for i in range(15):
		stop.push_back(IDLE)
		interact.push_back(INTERACT)
	
	$Player/InputHandler.inputs = [] + moveright
	$Player/InputHandler.MODE = 0


func _on_Exit_body_entered(body):
	if body.get_name() == "Player" and count == 0:
		count+=1
		$AnimationPlayer.play("Fadeout")
		$Player.show()
	elif body.get_name() == "Player" and count == 1:
		count += 1
		$Player/InputHandler.inputs = [] + stop
		$Player2.show()
		$Player2.terrain = 0.5
		$Player2.in_terrain +=1
		$Player2/InputHandler.inputs = [] +  moveleft
		$Player2/InputHandler.MODE = 0
	elif count == 2:
		count+=1
		$Player2/InputHandler.inputs = []
		$Player/InputHandler.inputs = [] + moveright
	elif count == 3:
		count+=1
		$Player/InputHandler.inputs = [] + moveright
	elif count == 4:
		$Player/InputHandler.inputs = [] + interact
		$Timer.start()
		$AnimationPlayer.play_backwards("Fadeout")
		$Event2.hide()

func _on_Timer_timeout():
	global.play_se(global.SE_JOGAR)
	get_tree().change_scene("res://Menus/Credits.tscn")