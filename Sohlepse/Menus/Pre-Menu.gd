extends Control

const newGame_= 0
const cont_ = 1
const exit_ = 2
var state = 0
var estado = 0
var saveslot = 0
var pressed = [false, false, false]
var on = [false, false, false]
var buttons = ["newGame", "continue", "exit"]
var block = false
var hasData = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var fake = false

signal pressed_slot(slot)

func _ready():
	if global.splash:
		$AnimationPlayer.play("splash")
		global.splash = false
	global.initSound()
	var container = $Save_window/ScrollContainer/VBoxContainer
	var id = 0
	for i in range(1,13):
		var status = global.load_game(i)
		var line = ceil(float(i)/2)
		id = "0"+str(i) if i < 10 else str(i)
		container.get_node("Line"+str(line)+"/Slot"+id).connect("pressed_slot",self, "_on_Slot_pressed")
		if status == 0:
			hasData[i] = 1
			container.get_node("Line"+str(line)+"/Slot"+id).set_info(global.get_player(), global.get_playtime(), global.get_deaths(), global.get_last_stage())
		else:
			container.get_node("Line"+str(line)+"/Slot"+id).set_empty()

func _process(delta):
	if !block:
		if pressed[newGame_]:
			block = true
			$Save_window.show()
			estado = 1
	#		global.DEBUG = false
	#		global.current_stage = global.unlocked_stage
	#		global.play_se(global.SE_JOGAR)
	#		get_tree().change_scene("res://Manager/StageManager.tscn")
		if pressed[cont_]:
			block = true
			$Save_window.show()
			estado = 2
	#		global.play_se(global.SE_ACCEPT)
	#		global.DEBUG = false
	#		get_tree().change_scene("Menus/Stage_Menu.tscn")
		if pressed[exit_]:
			global.play_se(global.SE_ACCEPT)
			get_tree().quit()
		if Input.is_action_just_pressed("move_down"):
			global.play_se(global.SE_MOVE,-15)
			_atualiza((state+1)%3)
		if Input.is_action_just_pressed("move_up"):
			global.play_se(global.SE_MOVE,-15)
			_atualiza((state-1)%3)
		if Input.is_action_just_pressed("ui_accept"):
			pressed[state] = true
	else:
		$newGame.disabled = true
		$continue.disabled = true
		$exit.disabled = true

func _on_continue_pressed():
	pressed[newGame_] = true

func _on_levelSelect_pressed():
	pressed[cont_] = true

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
	$newGame/Label.set("custom_colors/font_color", Color(0,0,0))
	on[0] = true
	for i in range (1,3):
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_levelSelect_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$continue/Label.set("custom_colors/font_color", Color(0,0,0))
	on[1] = true
	for i in [0,2]:
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_exit_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$exit/Label.set("custom_colors/font_color", Color(0,0,0))
	on[2] = true
	for i in range(2):
		if on[i]:
			get_node(buttons[i]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))

func _on_continue_mouse_exited():
	$newGame/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[0] = false

func _on_levelSelect_mouse_exited():
	$continue/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[1] = false

func _on_exit_mouse_exited():
	$exit/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[2] = false

func _on_Slot_pressed(num):
	block = true
	press(num)
	
func press(slot):
	if estado == 1: #ng
		if hasData[slot] == 1:
			saveslot = slot
			fake = false
			$ConfirmationDialog.dialog_text = "Sobrescrever?"
			$ConfirmationDialog.popup()
			return
		$Name_entry.show()
		saveslot = slot
	elif estado == 2: #cont
		if hasData[slot] == 0:
			$ConfirmationDialog.dialog_text = "Não há o que carregar nesse slot!"
			$ConfirmationDialog.popup()
			fake = true
			return
		global.load_game(slot)
		global.current_stage = global.unlocked_stage
		get_tree().change_scene("Menus/MenuPrincipal.tscn")


func _on_LineEdit_text_entered(new_text):
	print("complete")
	var name = new_text.substr(18,-1)
	global.new_game(saveslot, new_text)
	global.current_stage = global.unlocked_stage
	get_tree().change_scene("Menus/Credits.tscn")

func _on_ConfirmationDialog_confirmed():
	if fake:
		return
	$Name_entry.show()
