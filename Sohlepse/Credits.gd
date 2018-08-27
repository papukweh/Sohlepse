extends Label


func _ready():

	pass

func _process(delta):
	if(Input.is_action_just_pressed("interact")):
		get_tree().change_scene("MenuPrincipal.tscn")
	pass
