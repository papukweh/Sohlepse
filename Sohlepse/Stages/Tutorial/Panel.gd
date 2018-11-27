extends HBoxContainer

onready var vector = ["E", "setas", "R", "P", "G", "F", "Player", "Circle"]

export(int, "E", "setas", "R", "P", "G", "F", "Player", "Circle") var input = 0
export var label = ""

func ready():
	$Container/Label.text = label
	if input == 8:
		$Container/Sprite.texture = null
		$Container/Label.rect_position = Vector2(42,7)
	else:
		$Container/Sprite.texture = load("res://Assets/"+str(vector[input])+".png")       
