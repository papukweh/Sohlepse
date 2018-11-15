extends Control
const Voltar = 0
const Menu = 1
const Restart = 2
const Controles = 3
const Exit = 4
var pressed = [false, false, false, false, false]
var buttons = ["Voltar", "Menu", "Restart", "Controles", "Exit"]
var label = ["Voltar ao Jogo", "Menu", "Recomeçar", "Controles", "Sair"]
var LABEL = ["VOLTAR AO JOGO", "MENU", "RECOMEÇAR", "CONTROLES", "SAIR"]
var state = -1
var inSure = false
var inControls = false

func openA():
	global.play_se(global.SE_PAUSE,-5)
	get_node(buttons[0]).text = LABEL[0]
	var i = 1
	while(i <= 4):
		get_node(buttons[i]).text = label[i]
		i = i + 1
	state = 0
		
func _process(delta):
	if Input.is_action_just_pressed("Pause") or pressed[Voltar]:
		if get_tree().paused:
			global.play_se(global.SE_UNPAUSE,-5)
			state = -1
			pressed[Voltar] = false
			hide()
			get_tree().paused = false
		else:
			openA()
			show()
			get_tree().paused = true
	if pressed[Menu]:
		global.play_se(global.SE_ACCEPT)
		get_tree().paused = false
		get_tree().change_scene("Menus/MenuPrincipal.tscn")
	if pressed[Restart]:
		global.play_se(global.SE_ACCEPT)
		get_tree().paused = false
		get_tree().reload_current_scene()
	if pressed[Controles]:
		global.play_se(global.SE_ACCEPT)
		inControls = true
		hide()
		get_parent().get_node("Controls").show()
	if pressed[Exit]:
		global.play_se(global.SE_EXIT,-5)
		inSure = true
		hide()
		get_parent().get_node("Sure").show()
	if get_tree().paused and !inSure and !inControls:
		if Input.is_action_just_pressed("ui_accept"):
			pressed[state] = true
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
			
func _on_Voltar_pressed():
	pressed[Voltar] = true 

func _on_Menu_pressed():
	pressed[Menu] = true

func _on_Restart_pressed():
	pressed[Restart] = true

func _on_Controles_pressed():
	pressed[Controles] = true

func _on_Exit_pressed():
	pressed[Exit] = true
	
func _atualiza(newState):
	global.play_se(global.SE_MOVE,-15)
	get_node(buttons[state]).text = label[state]
	state = newState
	get_node(buttons[state]).text = LABEL[state]

func _one_down():
	if state == 1 or state == 2:
		 return 4
	if state == 4:
		return 0
	return state + 1
func _one_up():
	if state == 3 or state == 2:
		 return 0
	if state == 0:
		return 4
	return state - 1
func _one_right():
	if state == 0 or state == 4:
		return state
	else:
		return state%3 + 1
func _one_left():
	if state == 0 or state == 4:
		return state
	else:
		return (state - 2)%3 + 1
	

func _on_Voltar_mouse_entered():
	global.play_se(global.SE_MOVE,-15)


func _on_Menu_mouse_entered():
	global.play_se(global.SE_MOVE,-15)


func _on_Controles_mouse_entered():
	global.play_se(global.SE_MOVE,-15)


func _on_Exit_mouse_entered():
	global.play_se(global.SE_MOVE,-15)


func _on_Restart_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
