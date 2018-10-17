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
		set_camera1_limits(camera1)
		set_camera2_limits(camera2, 0)
	elif act == 3:
		camera1.target = world.get_node("Players/Player1")
		$Viewports/C2.queue_free()
		$Viewports/Filter.queue_free()
		$Viewports/Division.queue_free()
		set_camera1_limits(camera1)
	else:
		Viewport2.world_2d = Viewport1.world_2d
		camera1.target = world.get_node("Players/Player1")
		camera2.target = world.get_node("Players/Player1")
		set_camera1_limits(camera1)
		if mode == 1:
			set_camera2_limits(camera2, 675)
		else:
			set_camera2_limits(camera2, 0)
			Viewport2.render_target_v_flip = true 
func set_camera1_limits(cam1):
	var map_limits = world.get_node("Real").get_global_rect()
	cam1.limit_left = map_limits.position.x
	cam1.limit_right = map_limits.end.x
	cam1.limit_top = map_limits.position.y
	cam1.limit_bottom = map_limits.end.y
func set_camera2_limits(cam2, desloc):
	var map_limits = world.get_node("Mirrored").get_global_rect()
	cam2.limit_left = map_limits.position.x - desloc
	cam2.limit_right = map_limits.end.x + desloc
	cam2.limit_top = map_limits.position.y
	cam2.limit_bottom = map_limits.end.y