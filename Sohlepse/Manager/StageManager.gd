extends Node2D

onready var id = global.current_stage
onready var fase = "res://Stages/stage"

onready var rand_bg = null
onready var volume = 0

func _ready():
	if id > global.FINAL:
		get_tree().change_scene("res://Menus/MenuPrincipal.tscn")
		return
	if global.DEBUG:
		fase = "res://Testes/test"
		print(fase+str(id))
	var stage = load(fase+str(id)+".tscn").instance()
	
	if stage.MODE == 1:
		$Setup/ViewportsH.name = "Viewports"
		$Setup/ViewportsV.queue_free()
	else:
		$Setup/ViewportsV.name = "Viewports"
		$Setup/ViewportsH.queue_free()
	
	$Setup/Viewports/C1/Viewport1.add_child(stage)
	$Setup.world = get_node("Setup/Viewports/C1/Viewport1/stage"+str(id)+"/")
	$Setup.can_load(stage.ACT, stage.MODE, stage.invert)
	
	if global.current_stage < 13:
		rand_bg = global.ACT1_BG2
		volume = -2
	elif global.current_stage < 25:
		rand_bg = global.ACT2_BG2
		volume = -10
	else:
		rand_bg = global.ACT3_BG2
		volume = -6
	$Timer.wait_time = rand_range(25,50)
	$Timer.start()

func _on_Timer_timeout():
	global.play_se(rand_bg, volume)
	$Timer.wait_time = rand_range(25,50)
	$Timer.start()
