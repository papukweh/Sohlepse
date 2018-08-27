extends Button

func _on_Next_button_down():
	get_parent().hide()
	get_parent().get_parent().get_node("Batch2").show()
