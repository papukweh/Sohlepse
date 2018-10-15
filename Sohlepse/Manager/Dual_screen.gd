extends Node2D

onready var x = get_viewport().size.x
onready var y = get_viewport().size.y
onready var world = null

func can_load(act, mode, invert):
	var Viewport1 = $Viewports/C1/Viewport1/
	var Viewport2 = $Viewports/C2/Viewport2/
	var camera1 = $Viewports/C1/Viewport1/Camera2D/
	var camera2 = $Viewports/C2/Viewport2/Camera2D/
	
	if act == 2:
		Viewport2.world_2d = Viewport1.world_2d
		if mode == 2 and invert:
			Viewport2.render_target_v_flip = true
		camera1.target = world.get_node("Players/Player1")
		camera2.target = world.get_node("Players/Player2")
		set_camera_limits(camera1, camera2)
	elif act == 3:
		camera1.target = world.get_node("Players/Player1")
		$Viewports/C2.queue_free()
		$Viewports/Filter.queue_free()
		$Viewports/Division.queue_free()
	else:
		Viewport2.world_2d = Viewport1.world_2d
		camera1.target = world.get_node("Players/Player1")
		camera2.target = world.get_node("Players/Player1")
		#Viewport2.render_target_v_flip = true
		if mode == 1:
			camera1.zoom = Vector2(1.25, 1.25)
			camera2.zoom = Vector2(-1.25, 1.25)
		else:
			camera1.zoom = Vector2(1.25, 1.25)
			camera2.zoom = Vector2(1.25, -1.25)
		set_camera_limits(camera1, camera2)
func set_camera_limits(camera1, camera2):
	var map_limits = [world.get_node("Real").get_global_rect(), world.get_node("Mirrored").get_global_rect()] 
	var cam = [camera1, camera2]
	for i in [0,1]:
		print(map_limits[i].position.x)
		print(map_limits[i].end.x)
		print(map_limits[i].position.y)
		print(map_limits[i].end.y)
		cam[i].limit_left = map_limits[i].position.x
		cam[i].limit_right = map_limits[i].end.x
		cam[i].limit_top = map_limits[i].position.y
		cam[i].limit_bottom = map_limits[i].end.y