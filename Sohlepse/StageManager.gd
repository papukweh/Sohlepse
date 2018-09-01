extends Node2D

onready var id = global.current_stage
onready var viewport = $Setup/Viewports/C1/Viewport1/
onready var stage = null

func _ready():
	if id > global.FINAL:
		get_tree().change_scene("MenuPrincipal.tscn")
		return
	stage = load("res://stage"+str(id)+".tscn")
	viewport.add_child(stage.instance())
	$Setup.world = get_node("Setup/Viewports/C1/Viewport1/stage"+str(id)+"/")
	var mode = $Setup.world.PLAYERS
	$Setup.can_load(mode) 