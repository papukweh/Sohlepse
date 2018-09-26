extends Button

onready var batch = get_parent().get_parent().batch

func _on_ButtonPrev_button_down():
	get_parent().hide()
	get_parent().get_parent().get_node("Batch" + str(batch-1)).show()
	get_parent().get_parent()._atualiza((batch-1)*6 )


