extends Node

export var ACT = 1 
export var PLAYERS = 1
export var MAX_CLONES = 3
export var MODE = 1
export var invert = false
export(Array, bool) var hasTutorial = [false, false, false]
var recorder = null
var pan = null

func _ready():
	global.restarting = false
	if ACT == 3 and self.get_name() != "stage1":
		recorder = preload("res://Player/Recorder.tscn")
		self.add_child(recorder.instance())
		$Players/Player1.Recorder = get_node("Recorder")
		$Players/Player1.on_act3 = true
		$Players/Player1.Recorder.realplayer = $Players/Player1
		pan = get_tree().get_root().get_child(1).get_node("Tutoriais")
		var p3 = pan.get_node("Panel3")
		var p4 = pan.get_node("Panel4")
		var error = pan.get_node("Error")
		p3.label = str(MAX_CLONES - global.nclones)
		p3.input = 6
		p3.visible = true
		p3.ready()
		p4 = pan.get_node("Panel4")
		p4.label = "REC"
		p4.input = 7
		p4.visible = false
		p4.ready()
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
	global.play_bgm()

func recording(val):
	var p4 = pan.get_node("Panel4")
	var p3 = pan.get_node("Panel3")
	if !val:
		p4.visible = false
	else:
		p4.visible = true
	p3.label = str(MAX_CLONES - global.nclones)
	p3.ready()
func fail_recording(bol):
	var error = pan.get_node("Error")
	error.stop()
	error.frame = 0
	if bol:
		error.play()
	