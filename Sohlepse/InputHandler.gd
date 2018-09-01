extends Node

export var MODE = 1
onready var inputs = null
onready var player = get_parent()

func _process(delta):
	if player.dead:
		return
	if MODE == 1:
		if player.invert_horizontal == 1:
			player.move_left = Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right")
			player.move_right = Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left")
		else:
			player.move_right = Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right")
			player.move_left = Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left")
		
		player.jump = Input.is_action_pressed("jump")
	else:
		var input = inputs.pop_front()
		if input:
			player.move_left = input[0]
			player.move_right = input[1]
			player.jump = input[2]
		else:
			player.move_left = false
			player.move_right = false
			player.jump = false