extends Control


func _ready():
	$Controls.options = true
	$Controls/Voltar.disabled = true
	$Controls/Voltar.hide()

func _process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		global.play_se(global.SE_CHANGE, -5)
		get_tree().change_scene("Menus/MenuPrincipal.tscn")


func _on_Back_pressed():
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
