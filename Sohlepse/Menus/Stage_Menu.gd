extends Control
var batch = 1
var state = 1
const maxBatch = 6
onready var ultimo = global.unlocked_stage

func _ready():
	if global.DEBUG:
		ultimo = 99
	get_node("Batch1/1").text = "0"
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if state == 0:
			global.play_se(global.SE_CHANGE,-5)
			get_tree().change_scene("Menus/MenuPrincipal.tscn")
		elif state == -1:
			global.play_se(global.SE_CHANGE,-5)
			_atualiza(6*(batch-1))
		elif state == -2:
			global.play_se(global.SE_CHANGE,-5)
			_atualiza(6*batch + 1)
		else:
			global.play_se(global.SE_JOGAR)
			global.current_stage = state
			get_tree().change_scene("Manager/StageManager.tscn")

	if Input.is_action_just_pressed("move_down"):
		var newState = _one_down()
		_atualiza(newState)
	if Input.is_action_just_pressed("move_up"):
		var newState = _one_up()
		_atualiza(newState)
	if Input.is_action_just_pressed("move_right"):
		var newState = _one_right()
		_atualiza(newState)
	if Input.is_action_just_pressed("move_left"):
		var newState = _one_left()
		_atualiza(newState)
		
func _atualiza(newState):
	global.play_se(global.SE_MOVE,-15)
	if state == 0:
		$Back/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	elif state == -1:
		get_node("Batch" + str(batch) + "/Prev/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))
	elif state == -2:
		get_node("Batch" + str(batch) + "/Next/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))
	elif state <= 32:
		get_node("Batch" + str(batch) + "/" + str(state))._on_1_mouse_exited()
	state = newState
	if state == 0:
		$Back/Label.set("custom_colors/font_color", Color(0,0,0))
	elif state == -1:
		get_node("Batch" + str(batch) + "/Prev/Label").set("custom_colors/font_color", Color(0,0,0))
	elif state == -2:
		get_node("Batch" + str(batch) + "/Next/Label").set("custom_colors/font_color", Color(0,0,0))
	else:
		if batch != ((state-1)/6) + 1:
			get_node("Batch" + str(batch)).hide()
			batch = ((state-1)/6) + 1
			get_node("Batch" + str(batch)).show()
		if state <= 32:
			get_node("Batch" + str(batch) + "/" + str(state))._on_1_mouse_entered()
	

func _one_down():
	if state == 0:
		return (batch -1)*6 + 1
	if state == 4 or state == -1:
		return 0
	if state == (batch -1)*6 + 4:
		return -1
	if state == -2:
		return 6*batch - 3
	if state == 6*batch and state < ultimo:
		return -2
	if (state-1)%6 < 3 and state + 3 > ultimo:
		return state
	return (state%6 + 2)%6 + 1 + 6*(batch - 1)
func _one_up():
	if state == 0 and batch != 1:
		return -1
	if state == 0 or state == -1:
		if ultimo < (batch -1)*6 + 4:
			return (batch -1)*6 + 1
		else:
			return (batch -1)*6 + 4
	if state == (batch -1)*6 + 1:
		return 0
	if state == (batch -1)*6 + 3 and ultimo > 6*batch:
		return -2
	if state == -2:
		return 6*batch
	if (state-1)%6 < 3 and state + 3 > ultimo:
		return state
	return (state%6 + 2)%6 + 1 + 6*(batch - 1)
func _one_right():
	if state == 0 and batch !=1:
		return - 1
	if state == -1:
		return (batch -1)*6 + 1
	if state == ultimo:
		return state
	if state == 6*batch:
		return -2
	if state == -2:
		return 6*batch + 1
	return state + 1
func _one_left():
	if state == 0:
		return 6*(batch-1)
	if state == -1:
		return 0
	if state == (batch -1)*6 + 1 and batch != 1:
		return -1
	if state == -2:
		return 6*batch
	return state - 1
		

func _on_Back_mouse_entered():
	$Back/Label.set("custom_colors/font_color", Color(0,0,0))


func _on_Back_mouse_exited():
	$Back/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))


func _on_Back_pressed():
	global.play_se(global.SE_CHANGE, -5)
	get_tree().change_scene("Menus/MenuPrincipal.tscn")
