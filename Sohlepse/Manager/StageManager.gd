extends Node2D

onready var id = global.current_stage

func _ready():
	if id > global.FINAL:
		get_tree().change_scene("res://Menus/MenuPrincipal.tscn")
		return
	var stage = load("res://Stages/stage"+str(id)+".tscn").instance()
	
	if stage.MODE == 1:
		$Setup/ViewportsH.name = "Viewports"
		$Setup/ViewportsV.queue_free()
	else:
		$Setup/ViewportsV.name = "Viewports"
		$Setup/ViewportsH.queue_free()
	
	$Setup/Viewports/C1/Viewport1.add_child(stage)
	$Setup.world = get_node("Setup/Viewports/C1/Viewport1/stage"+str(id)+"/")
	$Setup.can_load(stage.PLAYERS)