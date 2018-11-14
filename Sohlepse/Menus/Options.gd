extends Control


func _ready():
	pass

func _process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		global.play_se(global.SE_CHANGE, -5)
		get_tree().change_scene("Menus/MenuPrincipal.tscn")


func _on_Back_pressed():
	global.play_se(global.SE_CHANGE, -5)
	get_tree().change_scene("Menus/MenuPrincipal.tscn")


func _on_Back_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
