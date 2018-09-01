extends Node

export var ACT = 1
export var PLAYERS = 1
export var MIRRORS = 1
export var MAX_CLONES = 3
var recorder = null

func _ready():
	if ACT == 3:
		recorder = preload("res://Player/Recorder.tscn")
		self.add_child(recorder.instance())
		
func get_recorder():
	return get_node("Recorder")