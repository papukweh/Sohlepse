extends Control

const continue_= 0
const levelSelect_ = 1
const options_ = 2
const credits_ = 3
const exit_ = 4
var state = 4
var pressed = [false, false, false, false, false]
var on = [false, false, false, false, false]
var buttons = ["continue", "levelSelect", "option", "credits", "exit"]

func _ready():
	global.initSound()

func _process(delta):
	if pressed[continue_]:
		global.DEBUG = false
		global.current_stage = global.unlocked_stage
		global.play_se(global.SE_JOGAR)
		get_tree().change_scene("res://Manager/StageManager.tscn")
	if pressed[levelSelect_]:
		global.play_se(global.SE_ACCEPT)
		global.DEBUG = false
		get_tree().change_scene("Menus/Stage_Menu.tscn")
	if pressed[options_]:
		global.play_se(global.SE_ACCEPT)
		get_tree().change_scene("Menus/Options.tscn")
	if pressed[credits_]:
		global.play_se(global.SE_ACCEPT)
		get_tree().change_scene("Menus/Credits.tscn")
	if pressed[exit_]:
		global.play_se(global.SE_ACCEPT)
		get_tree().change_scene("Menus/Pre-Menu.tscn")
	if Input.is_action_just_pressed("move_down"):
		global.play_se(global.SE_MOVE,-15)
		_atualiza((state+1)%5)
	if Input.is_action_just_pressed("move_up"):
		global.play_se(global.SE_MOVE,-15)
		_atualiza((state-1)%5)
	if Input.is_action_just_pressed("ui_accept"):
		pressed[state] = true

func _on_continue_pressed():
	pressed[continue_] = true

func _on_levelSelect_pressed():
	pressed[levelSelect_] = true

func _on_option_pressed():
	pressed[options_] = true

func _on_credits_pressed():
	pressed[credits_] = true
	
func _on_exit_pressed():
	pressed[exit_] = true

func _atualiza(newState):
	get_node(buttons[state]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[state] = false
	state = newState
	get_node(buttons[state]+"/Label").set("custom_colors/font_color", Color(0,0,0))
	on[state] = true

func _on_continue_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$continue/Label.set("custom_colors/font_color", Color(0,0,0))
	on[0] = true
	for i in range (1,5):
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))


func _on_levelSelect_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$levelSelect/Label.set("custom_colors/font_color", Color(0,0,0))
	on[1] = true
	for i in [0,2,3,4]:
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_option_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$option/Label.set("custom_colors/font_color", Color(0,0,0))
	on[2] = true
	for i in [0,1,3,4]:
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_credits_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$credits/Label.set("custom_colors/font_color", Color(0,0,0))
	on[3] = true
	for i in [0,1,2,4]:
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_exit_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$exit/Label.set("custom_colors/font_color", Color(0,0,0))
	on[4] = true
	for i in range(4):
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_continue_mouse_exited():
	$continue/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[0] = false

func _on_levelSelect_mouse_exited():
	$levelSelect/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[1] = false

func _on_option_mouse_exited():
	$option/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[2] = false

func _on_credits_mouse_exited():
	$credits/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[3] = false

func _on_exit_mouse_exited():
	$exit/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[4] = false