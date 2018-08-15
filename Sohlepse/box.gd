extends RigidBody2D

var WALK_ACCEL = 10000.0
var WALK_DEACCEL = 5000.0
var WALK_MAX_VELOCITY = 200.0

onready var push = false

func _integrate_forces(s):
	var lv = s.get_linear_velocity()
	var step = s.get_step()
	push = Input.is_action_pressed("push-and-pull")
	
	if push:
		if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
			if lv.x > -WALK_MAX_VELOCITY:
				lv.x -= WALK_ACCEL * step
		elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
			if lv.x < WALK_MAX_VELOCITY:
				lv.x += WALK_ACCEL * step
				
		
	s.set_linear_velocity(lv)