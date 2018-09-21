extends Node2D

onready var x = get_viewport().size.x
onready var y = get_viewport().size.y
onready var world = null

func can_load(players):
	var Viewport1 = $Viewports/C1/Viewport1/
	var Viewport2 = $Viewports/C2/Viewport2/
	var camera1 = $Viewports/C1/Viewport1/Camera2D/
	var camera2 = $Viewports/C2/Viewport2/Camera2D/
	
	if players > 1:
		Viewport2.world_2d = Viewport1.world_2d
		camera1.target = world.get_node("Players/Player1")
		camera2.target = world.get_node("Players/Player2")
		set_camera_limits(camera1, camera2)
	else:
		camera1.target = world.get_node("Players/Player1")
		$Viewports/C2.queue_free()
		$Viewports/Filter.queue_free()
		$Viewports/Division.queue_free()

func set_camera_limits(camera1, camera2):
	var map_limits = [world.get_node("Real").get_global_rect(), world.get_node("Mirrored").get_global_rect()] 
	var cam = [camera1, camera2]
	for i in [0,1]:
		cam[i].limit_left = map_limits[i].position.x
		cam[i].limit_right = map_limits[i].end.x
		cam[i].limit_top = map_limits[i].position.y
		cam[i].limit_bottom = map_limits[i].end.y