extends Control

onready var options = false

func _process(delta):
	if options:
		return
	if Input.is_action_just_pressed("Pause") and get_parent().get_node("PauseMenu").inControls:
		get_parent().get_node("PauseMenu").inControls = false
		hide()
	if get_parent().get_node("PauseMenu").inControls and get_parent().get_node("PauseMenu").pressed[3]:
		get_parent().get_node("PauseMenu").pressed[3] = false
	if get_tree().paused and get_parent().get_node("PauseMenu").inControls:
		if Input.is_action_just_pressed("ui_accept"):
			_on_Voltar_pressed()
	else:
		hide()

func _on_Voltar_pressed():
		get_parent().get_node("PauseMenu").inControls = false
		get_parent().get_node("PauseMenu").openA()
		hide()
		get_parent().get_node("PauseMenu").show()
