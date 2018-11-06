extends Control
var batch = 1
var state = 1
const maxBatch = 4
onready var ultimo = global.unlocked_stage

func _ready():
	if global.DEBUG:
		ultimo = 99
	get_node("Batch1/1").text = "0"
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if state == 0:
			get_tree().change_scene("Menus/MenuPrincipal.tscn")
		elif state == -1:
			_atualiza(6*(batch-1))
		elif state == -2:
			_atualiza(6*batch + 1)
		else:
			global.current_stage = state
			get_tree().change_scene("Manager/StageManager.tscn")

	if Input.is_action_just_pressed("move_down"):
		var newState = _one_down()
		_atualiza(newState)
	if Input.is_action_just_pressed("jump"):
		var newState = _one_up()
		_atualiza(newState)
	if Input.is_action_just_pressed("move_right"):
		var newState = _one_right()
		_atualiza(newState)
	if Input.is_action_just_pressed("move_left"):
		var newState = _one_left()
		_atualiza(newState)
		
func _atualiza(newState):
	if state == 0:
		$Back.text = "Voltar"
	elif state == -1:
		get_node("Batch" + str(batch) + "/Prev").text = "Anterior"
	elif state == -2:
		get_node("Batch" + str(batch) + "/Next").text = "Próximo"
	else:
		get_node("Batch" + str(batch) + "/" + str(state)).text = ""
	state = newState
	if state == 0:
		$Back.text = "VOLTAR"
	elif state == -1:
		get_node("Batch" + str(batch) + "/Prev").text = "ANTERIOR"
	elif state == -2:
		get_node("Batch" + str(batch) + "/Next").text = "PRÓXIMO"
	else:
		if batch != ((state-1)/6) + 1:
			get_node("Batch" + str(batch)).hide()
			batch = ((state-1)/6) + 1
			get_node("Batch" + str(batch)).show()
		get_node("Batch" + str(batch) + "/" + str(state)).text = "0"
	

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
		
	


