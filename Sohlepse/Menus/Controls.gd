extends Control

onready var options = false

func _process(delta):
	if options:
		return
#	if Input.is_action_just_pressed("Pause") and get_parent().get_node("PauseMenu").inControls:
#		get_parent().get_node("PauseMenu").inControls = false
#		hide()
#	if get_parent().get_node("PauseMenu").inControls and get_parent().get_node("PauseMenu").pressed[3]:
#		get_parent().get_node("PauseMenu").pressed[3] = false
#	if get_tree().paused and get_parent().get_node("PauseMenu").inControls:
#		if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
#			$Voltar/Label.set("custom_colors/font_color", Color(0,0,0))
#		if Input.is_action_just_pressed("ui_accept"):
#			$Voltar/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
#			_on_Voltar_pressed()
#	else:
#		hide()
#
#func _on_Voltar_pressed():
#		get_parent().get_node("PauseMenu").inControls = false
#		get_parent().get_node("PauseMenu").openA()
#		hide()
#		get_parent().get_node("PauseMenu").show()


func _on_Voltar_mouse_entered():
	$Voltar/Label.set("custom_colors/font_color", Color(0,0,0))


func _on_Voltar_mouse_exited():
	$Voltar/Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
