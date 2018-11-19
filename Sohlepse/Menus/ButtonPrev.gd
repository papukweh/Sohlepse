extends Button


func _on_ButtonPrev_button_down():
	global.play_se(global.SE_CHANGE,-5)
	get_parent().get_parent()._atualiza((get_parent().get_parent().batch-1)*6 )


func _on_ButtonPrev_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
	$Label.set("custom_colors/font_color", Color(0,0,0))


func _on_ButtonPrev_mouse_exited():
	$Label.set("custom_colors/font_color", Color(0.86,0.96,0.92))
