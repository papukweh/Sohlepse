extends Control
const no = 0
const yes = 1
var pressed = [false, false]
var buttons = ["No", "Yes"]
var label = ["Não", "Sim"]
var LABEL = ["NÃO", "SIM"]
var state = -1


func _process(delta):
	if Input.is_action_just_pressed("Pause") and get_parent().get_node("PauseMenu").inSure:
		get_node(buttons[no]).text = LABEL[no]
		get_node(buttons[yes]).text = label[yes]
		get_parent().get_node("PauseMenu").inSure = false
		hide()
	if get_parent().get_node("PauseMenu").inSure and get_parent().get_node("PauseMenu").pressed[4]:
		state = no
		get_parent().get_node("PauseMenu").pressed[4] = false
		get_node(buttons[no]).text = LABEL[no]
	if pressed[no]:
		state = -1
		get_parent().get_node("PauseMenu").inSure = false
		get_parent().get_node("PauseMenu").openA()
		hide()
		get_parent().get_node("PauseMenu").show()
		pressed[no] = false
	if pressed[yes]:
		get_tree().quit()
	if get_tree().paused and get_parent().get_node("PauseMenu").inSure:
		if Input.is_action_just_pressed("ui_accept"):
			pressed[state] = true
		if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
			get_node(buttons[state]).text = label[state]
			state = (state+1)%2
			get_node(buttons[state]).text = LABEL[state]			

func _on_No_pressed():
	pressed[no] = true



func _on_Yes_pressed():
	pressed[yes] = true

