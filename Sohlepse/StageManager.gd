extends Node2D

onready var id = global.current_stage
onready var viewport = $Setup/Viewports/C1/Viewport1/
onready var stage = null

func _ready():
	stage = load("res://stage"+str(id)+".tscn")
	viewport.add_child(stage.instance())
	print(viewport.get_children())
	$Setup.world = get_node("Setup/Viewports/C1/Viewport1/stage"+str(id)+"/")
	$Setup.can_load()
	
func _process(delta):
		