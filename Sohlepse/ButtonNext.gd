extends Button

onready var batch = get_parent().get_parent().batch
func _ready():
	if(batch*6 >= global.unlocked_stage):
		self.disabled = true

func _on_ButtonNext_button_down():
	get_parent().hide()
	get_parent().get_parent().get_node("Batch" + str(batch+1)).show()
	get_parent().get_parent()._atualiza(batch*6 + 1)
