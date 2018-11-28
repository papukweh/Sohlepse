extends Node2D
var nothing = []
var move_r = []
var look_r = []
var interact_and_back = []
var played1 = false
var played2 = false

func _ready():
	$Player4.clone = true
	$Player3.clone = true
	look_r.push_back([false, true, false, false])
	look_r.push_back([false, true, false, false])
	for i in range(50):
		look_r.push_back([false, false, false, false])
		nothing.push_back([false, false, false, false])
	for i in range(200):
		for j in range(5):
			move_r.push_back([false, true, false, false])			
		move_r.push_back([false, false, false, false])
	interact_and_back.push_back([false, false, false, true])
	for i in range(200):
		interact_and_back.push_back([true, false, false, false])
	$Player3/InputHandler.inputs = nothing
	$Player4/InputHandler.inputs = move_r
	$Player3/InputHandler.MODE = 0
	$Player4/InputHandler.MODE = 0
	$Player4.evil()

func _process(delta):
	if $Event.checks[1] and !played2:
		$Player4/InputHandler.inputs = interact_and_back
		global.play_se(global.SE_EVIL_LAUGH, -5)
		$Anim.play("Flash")
		global.play_sirine()
		$HAHATimer.start()
		$EndTimer.start()
		played2 = true
	elif $Event.checks[0] and !played1:
		$Player4/InputHandler.inputs = nothing
		$HAHATimer.start()
		played1 = true
	pass

func _on_HAHATimer_timeout():
	if $Event.checks[1]:
		$Player3/InputHandler.inputs = look_r 
		$Anim2.play("Label")
	else:
		$Player4/InputHandler.inputs = move_r


func _on_EndTimer_timeout():
	get_tree().change_scene("Manager/StageManager.tscn")
