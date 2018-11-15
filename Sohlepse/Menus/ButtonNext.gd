extends Button



func _ready():
	if(get_parent().get_parent().batch*6 >= global.unlocked_stage):
		self.disabled = true

func _on_ButtonNext_button_down():
	global.play_se(global.SE_CHANGE, -5)
	get_parent().get_parent()._atualiza(get_parent().get_parent().batch*6 + 1)


func _on_ButtonNext_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
