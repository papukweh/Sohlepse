extends Node

export var ACT = 1 
export var PLAYERS = 1
export var MAX_CLONES = 3
export var MODE = 1
export var invert = false
export(Array, bool) var hasTutorial = [false, false, false]
var recorder = null

func _ready():
	if ACT == 3:
		recorder = preload("res://Player/Recorder.tscn")
		self.add_child(recorder.instance())
		$Players/Player1.Recorder = get_node("Recorder")
		$Players/Player1.on_act3 = true
	
	if hasTutorial:
		for i in range(3):
			if hasTutorial[i]:
				var pan = get_tree().get_root().get_child(1).get_node("Tutoriais")
				var copy = get_node("Panel"+str(i))
				pan = pan.get_node("Panel"+str(i))
				pan.visible = true
				pan.label = copy.label
				pan.input = copy.input
				pan.ready()
				copy.queue_free()