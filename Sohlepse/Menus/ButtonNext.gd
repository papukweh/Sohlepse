extends Button

func _ready():
	if(get_parent().get_parent().batch*6 >= global.unlocked_stage):
		self.disabled = true

func _on_ButtonNext_button_down():
	get_parent().get_parent()._atualiza(get_parent().get_parent().batch*6 + 1)
