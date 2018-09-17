extends Button

func _on_Prev_button_down():
	get_parent().hide()
	get_parent().get_parent().get_node("Batch1").show()
	get_parent().get_parent()._atualiza(6)