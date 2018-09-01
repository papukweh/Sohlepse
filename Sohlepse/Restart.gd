extends Button

func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()