extends Control


func _ready():
	pass

func _process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		get_tree().change_scene("Menus/MenuPrincipal.tscn")


func _on_Back_pressed():
	get_tree().change_scene("Menus/MenuPrincipal.tscn")
