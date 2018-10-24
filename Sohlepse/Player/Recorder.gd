extends Node2D

onready var realplayer = null
onready var player = null
onready var recording = false
onready var states = null
onready var initial_pos = null
onready var clone = preload("Player.tscn")
onready var clones = []
onready var buffer = []
onready var pos = []
onready var state = null
onready var MAX = get_parent().MAX_CLONES

func _ready():
	if global.play:
		pos = global.load_pos()
		buffer = global.load_buffer()
		state = global.load_state()
		play_all_true()

func start_recording(body):
	if pos.size() < MAX:
		player = body
		realplayer = body
		initial_pos = player.get_global_position()
		states = []
		recording = true

func stop_recording():
	player = null
	recording = false
	pos.push_back(initial_pos)
	buffer.push_back(states)
	
func play_all():
	if not realplayer:
		return
	var state = [realplayer.invert_vertical, realplayer.invert_horizontal]
	global.save_clones(pos, buffer, state)
	global.play = true
	global.restart()

func play_all_true():
	while clones.size() > 0:
		var c = clones.pop_front()
		c.queue_free()
	for i in range(pos.size()):
		get_parent().add_child(clone.instance())
		var c = get_parent().get_children()[-1]
		c.hide()
		c.dead = true
		c.invert_vertical = state[0]
		c.invert_horizontal = state[1]
		c.set_position(pos[i])
		c.get_node("InputHandler").MODE = 2
		c.get_node("InputHandler").inputs = [] + buffer[i]
		c.show()
		c.dead = false
		c.ready = false
		clones.push_back(c)
	for c in clones:
		c.show()
		c.dead = false
	global.play = false
		
func _process(delta):
	if recording:
		var move_left = Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right")
		var move_right = Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left")
		var jump = Input.is_action_pressed("jump")
		var interacting = Input.is_action_pressed("interact")
		states.push_back([move_left, move_right, jump, interacting])
	

