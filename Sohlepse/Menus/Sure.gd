extends Control
const no = 0
const yes = 1
var pressed = [false, false]
var buttons = ["No", "Yes"]
var on = [false, false]
var state = -1


func _process(delta):
	if Input.is_action_just_pressed("Pause") and get_parent().get_node("PauseMenu").inSure:
		get_parent().get_node("PauseMenu").inSure = false
		hide()
	if get_parent().get_node("PauseMenu").inSure and get_parent().get_node("PauseMenu").pressed[4]:
		state = no
		get_parent().get_node("PauseMenu").pressed[4] = false
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
			get_node(buttons[state]+"/Label").set("custom_colors/font_color", Color(0.86,0.96,0.92))
			on[state] = false
			state = (state+1)%2
			get_node(buttons[state]+"/Label").set("custom_colors/font_color", Color(0,0,0))
			on[state] = true

func _on_No_pressed():
	pressed[no] = true

func _on_Yes_pressed():
	pressed[yes] = true



func _on_Yes_mouse_entered():
	$Yes/Label.set("custom_colors/font_color", Color(0,0,0))
	on[1] = true
	if on[0]:
		$No/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))


func _on_Yes_mouse_exited():
	$Yes/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[1] = false


func _on_No_mouse_entered():
	$No/Label.set("custom_colors/font_color", Color(0,0,0))
	on[0] = true
	if on[1]:
		$Yes/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))


func _on_No_mouse_exited():
	$No/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
	on[0] = false
