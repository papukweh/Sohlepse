extends Button

func _on_Back_pressed():
	global.play_se(global.SE_CHANGE, -5)
	get_tree().change_scene("Menus/MenuPrincipal.tscn")
