extends Button


func _on_ButtonPrev_button_down():
	global.play_se(global.SE_CHANGE,-5)
	get_parent().get_parent()._atualiza((get_parent().get_parent().batch-1)*6 )


func _on_ButtonPrev_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
