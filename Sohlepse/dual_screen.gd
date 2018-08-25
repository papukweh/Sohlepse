extends Node2D

onready var Viewport1 = $Viewports/C1/Viewport1/
onready var Viewport2 = $Viewports/C2/Viewport2/
onready var camera1 = $Viewports/C1/Viewport1/Camera2D/
onready var camera2 = $Viewports/C2/Viewport2/Camera2D/
onready var world = null

func can_load():
	Viewport2.world_2d = Viewport1.world_2d
	camera1.target = world.get_node("Players/player1")
	camera2.target = world.get_node("Players/player2")
	set_camera_limits()

func set_camera_limits():
	var map_limits = [world.get_node("real").get_global_rect(), world.get_node("mirrored").get_global_rect()] 
	var cam = [camera1, camera2]
	for i in [0,1]:
		cam[i].limit_left = map_limits[i].position.x
		cam[i].limit_right = map_limits[i].end.x
		cam[i].limit_top = map_limits[i].position.y
		cam[i].limit_bottom = map_limits[i].end.y