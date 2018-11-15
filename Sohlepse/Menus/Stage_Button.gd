extends Button

onready var id = int(get_name())

func _ready():
	if id <= global.unlocked_stage:
		#pass
		$Sprite.texture = load("Assets/thumbnail"+str(id)+".png")
	else:
		$Sprite.texture = null
		self.disabled = true
	
func _on_button_down():
	global.current_stage = id
	global.play_se(global.SE_JOGAR)
	get_tree().change_scene("res://Manager/StageManager.tscn")
	
func _on_1_mouse_entered():
	global.play_se(global.SE_MOVE,-15)
