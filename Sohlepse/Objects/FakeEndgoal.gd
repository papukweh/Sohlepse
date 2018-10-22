extends Area2D

onready var player = false

func _process(delta):
	if player and Input.is_action_just_pressed("interact"):
		self.hide()
	
	
func _on_FakeEndgoal_body_entered(body):
	if body.get_name().begins_with("Player"):
		player = true


func _on_FakeEndgoal_body_exited(body):
	if body.get_name().begins_with("Player"):
		player = false
