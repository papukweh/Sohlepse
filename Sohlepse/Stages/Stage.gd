extends Node

export var ACT = 1 
export var PLAYERS = 1
export var MAX_CLONES = 3
export var MODE = 1
var recorder = null

func _ready():
	if ACT == 3:
		recorder = preload("res://Player/Recorder.tscn")
		self.add_child(recorder.instance())
		$Players/Player1.Recorder = get_node("Recorder")
		$Players/Player1.on_act3 = true