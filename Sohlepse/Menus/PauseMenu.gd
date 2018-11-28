extends Control
const Voltar = 0
const Menu = 1
const Restart = 2
const Options = 3
const Exit = 4
var pressed = [false, false, false, false, false]
var buttons = ["Voltar", "Menu", "Restart", "Options", "Exit"]
var on = [false, false, false, false, false]
var state = -1
var inSure = false
var inOptions = false
onready var MenuOptions = load("res://Menus/Options.tscn")

func openA():
	global.play_se(global.SE_PAUSE,-5)
#	get_node(buttons[0]).text = LABEL[0]
#	var i = 1
#	while(i <= 4):
#		get_node(buttons[i]).text = label[i]
#		i = i + 1
	state = 0
		
func _process(delta):
	if inOptions:
		return
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
	if pressed[Options]:
		global.play_se(global.SE_ACCEPT)
		$Options/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
		inOptions = true
		hide()
		get_parent().get_node("Options").show()
	if pressed[Exit]:
		global.play_se(global.SE_EXIT,-5)
		inSure = true
		hide()
		get_parent().get_node("Sure").show()
	if get_tree().paused and !inSure and !inOptions:
		if Input.is_action_just_pressed("ui_accept"):
			pressed[state] = true
		if Input.is_action_just_pressed("move_down"):
			global.play_se(global.SE_MOVE,-15)
			var newState = _one_down()
			_atualiza(newState)
		if Input.is_action_just_pressed("move_up"):
			global.play_se(global.SE_MOVE,-15)
		if Input.is_action_just_pressed("move_up"):
			var newState = _one_up()
			_atualiza(newState)
		if Input.is_action_just_pressed("move_right"):
			global.play_se(global.SE_MOVE,-15)
			var newState = _one_right()
			_atualiza(newState)
		if Input.is_action_just_pressed("move_left"):
			global.play_se(global.SE_MOVE,-15)
			var newState = _one_left()
			_atualiza(newState)
			
func _on_Voltar_pressed():
	global.play_se(global.SE_UNPAUSE)
	pressed[Voltar] = true 

func _on_Menu_pressed():
	global.play_se(global.SE_ACCEPT)
	pressed[Menu] = true

func _on_Restart_pressed():
	global.play_se(global.SE_ACCEPT)
	pressed[Restart] = true

func _on_Options_pressed():
	global.play_se(global.SE_ACCEPT)
	pressed[Options] = true

func _on_Exit_pressed():
	global.play_se(global.SE_EXIT,-5)
	pressed[Exit] = true
	
func _atualiza(newState):
	get_node(buttons[state]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[state] = false
	state = newState
	get_node(buttons[state]+"/Label").set("custom_colors/font_color", Color(0,0,0))
	on[state] = true

func _one_down():
	global.play_se(global.SE_MOVE,-15)
	if state == 1 or state == 2:
		 return 4
	if state == 4:
		return 0
	return state + 1
func _one_up():
	global.play_se(global.SE_MOVE,-15)
	if state == 3 or state == 2:
		 return 0
	if state == 0:
		return 4
	return state - 1
func _one_right():
	global.play_se(global.SE_MOVE,-15)
	if state == 0 or state == 4:
		return state
	else:
		return state%3 + 1
func _one_left():
	global.play_se(global.SE_MOVE,-15)
	if state == 0 or state == 4:
		return state
	else:
		return (state - 2)%3 + 1
	

func _on_Voltar_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$Voltar/Label.set("custom_colors/font_color", Color(0,0,0))
	on[0] = true
	for i in range (1,5):
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_Menu_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$Menu/Label.set("custom_colors/font_color", Color(0,0,0))
	on[1] = true
	for i in [0,2,3,4]:
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_Restart_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$Restart/Label.set("custom_colors/font_color", Color(0,0,0))
	on[2] = true
	for i in [0,1,3,4]:
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_Options_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$Options/Label.set("custom_colors/font_color", Color(0,0,0))
	on[3] = true
	for i in [0,1,2,4]:
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_Exit_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$Exit/Label.set("custom_colors/font_color", Color(0,0,0))
	on[4] = true
	for i in range(4):
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_Voltar_mouse_exited():
	$Voltar/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[0] = false

func _on_Menu_mouse_exited():
	$Menu/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[1] = false

func _on_Restart_mouse_exited():
	$Restart/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[2] = false

func _on_Options_mouse_exited():
	$Options/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[3] = false

func _on_Exit_mouse_exited():
	$Exit/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[4] = false
	