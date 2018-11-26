extends HBoxContainer

onready var vector = ["E", "setas", "R", "P", "G", "F", "Player", "Circle", "X"]

export(int, "E", "setas", "R", "P", "G", "F", "Player", "Circle", "X") var input = 0
export var label = ""

func ready():
	$Container/Label.text = label
	$Container/Sprite.texture = load("res://Assets/"+str(vector[input])+".png")       
