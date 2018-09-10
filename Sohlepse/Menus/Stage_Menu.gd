extends Control
var batch = 1
var state = 1
const maxBatch = 2

func _ready():
	get_node("Batch1/1").text = "0"
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if state == 0:
			get_tree().change_scene("Menus/MenuPrincipal.tscn")
		if state <= global.unlocked_stage:
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
	else:
		get_node("Batch" + str(batch) + "/" + str(state)).text = ""
	state = newState
	if state == 0:
		$Back.text = "VOLTAR"
	else:
		if batch != ((state-1)/6) + 1:
			get_node("Batch" + str(batch)).hide()
			batch = ((state-1)/6) + 1
			get_node("Batch" + str(batch)).show()
		get_node("Batch" + str(batch) + "/" + str(state)).text = "0"
	

func _one_down():
	if state == 0:
		return 1
	return (state%6 + 2)%6 + 1 + 6*(batch - 1)
func _one_up():
	if state == 0:
		return 4
	return (state%6 + 2)%6 + 1 + 6*(batch - 1)
func _one_right():
	if state == 6*maxBatch:
		return state
	return state + 1
func _one_left():
	if state == 0:
		return state
	return state - 1
		
	


