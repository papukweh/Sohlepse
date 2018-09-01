extends Node2D

onready var player = null
onready var recording = false
onready var states = null
onready var initial_pos = null
onready var clone = preload("res://player.tscn")
onready var clones = []
onready var buffer = []
onready var pos = []
onready var MAX = get_parent().MAX_CLONES

func start_recording(body):
	if clones.size() < MAX:
		player = body
		initial_pos = player.get_position()
		states = []
		recording = true

func stop_recording():
	player = null
	recording = false
	pos.push_back(initial_pos)
	buffer.push_back(states)
	

func play_all():
	while clones.size() > 0:
		var c = clones.pop_front()
		c.queue_free()
	for i in range(pos.size()):
		get_parent().add_child(clone.instance())
		var c = get_parent().get_children()[-1]
		print(c)
		c.hide()
		c.dead = true
		c.clone = true
		c.set_position(pos[i])
		c.get_node("InputHandler").MODE = 2
		c.get_node("InputHandler").inputs = [] + buffer[i]
		c.show()
		c.dead = false
		clones.push_back(c)
	for c in clones:
		c.show()
		c.dead = false
		
func _process(delta):
	if recording:
		var move_left = Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right")
		var move_right = Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left")
		var jump = Input.is_action_pressed("jump")
		states.push_back([move_left, move_right, jump])
	
