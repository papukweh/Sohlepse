extends Area2D

onready var pai = null
onready var id = 0

func setup(receiver):
	id = int(get_name().substr(4,get_name().length()-4))
	pai = receiver
	
func _on_Area_body_entered(body):
	if body.get_name().begins_with("Player"):
		pai.body_entered(id)