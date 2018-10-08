extends Button


func _on_ButtonPrev_button_down():
	get_parent().get_parent()._atualiza((get_parent().get_parent().batch-1)*6 )
