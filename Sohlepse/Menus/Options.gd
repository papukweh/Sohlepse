extends Control
onready var pause = false

func _ready():
	$Controls.options = true
	$Controls/Voltar.disabled = true
	$Controls/Voltar.hide()
	
	print(get_parent().get_name())
	if get_parent().get_name() == "Tutoriais":
		pause = true
		if Input.is_action_just_pressed("Pause") and get_parent().get_node("PauseMenu").inOptions:
			print("hide")
			get_parent().get_node("PauseMenu").inOptions = false
			queue_free()
		if get_parent().get_node("PauseMenu").inOptions and get_parent().get_node("PauseMenu").pressed[3]:
			get_parent().get_node("PauseMenu").pressed[3] = false
		if get_tree().paused and get_parent().get_node("PauseMenu").inOptions:
			if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
				$Back/Label.set("custom_colors/font_color", Color(0,0,0))
			if Input.is_action_just_pressed("ui_accept"):
				$Back/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
				_on_Back_pressed()
		else:
			hide()

func _on_Back_pressed():
	if pause:
		print("voltei")
		global.play_se(global.SE_CHANGE, -5)
		get_parent().get_node("PauseMenu").inOptions = false
		get_parent().get_node("PauseMenu").openA()
		print("hide")
		get_parent().get_node("PauseMenu").show()
		queue_free()
	else:	
		global.play_se(global.SE_CHANGE, -5)
		get_tree().change_scene("Menus/MenuPrincipal.tscn")


func _on_Back_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$Back/Label.set("custom_colors/font_color", Color(0,0,0))
	
func _on_Back_mouse_exited():
	$Back/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))


func _on_HSlider_value_changed(value):
	global.base_master = value
	global.recalibrate()


func _on_HSlider3_value_changed(value):
	global.base_se = value
	global.recalibrate()


func _on_HSlider2_value_changed(value):
	global.base_bgm = value
	global.recalibrate()
