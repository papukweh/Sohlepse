extends Node

export var ACT = 1 
export var PLAYERS = 1
export var MAX_CLONES = 3
export var MODE = 1
export var invert = false
export(Array, bool) var hasTutorial = [false, false, false]
var recorder = null
var pan = null
var FINALSTAGE = "stage32"

func _ready():
	print("pai: " + self.get_parent().get_parent().get_parent().get_node("C2/Viewport2/ParallaxBackground").get_name())
	if ACT == 2 and self.get_name() != "stage12":
		self.get_parent().get_node("ParallaxBackground/ParallaxLayer/Lab").hide()
		self.get_parent().get_parent().get_parent().get_node("C2/Viewport2/ParallaxBackground/ParallaxLayer/Lab").hide()
		if self.get_name() == "stage13" or self.get_name() == "stage20":
			self.get_parent().get_parent().get_parent().get_node("C2/Viewport2/ParallaxBackground/ParallaxLayer/Forest").set_flip_v(true)
		if self.get_name() == "stage18":
			self.get_parent().get_parent().get_parent().get_node("C2/Viewport2/ParallaxBackground/ParallaxLayer/Forest").position.x = -160
			self.get_parent().get_parent().get_parent().get_node("C2/Viewport2/ParallaxBackground/ParallaxLayer/Forest").position.y = -150
		if self.get_name() == "stage19":
			self.get_parent().get_node("ParallaxBackground/ParallaxLayer/Forest").position.x = 670
			self.get_parent().get_parent().get_parent().get_node("C2/Viewport2/ParallaxBackground/ParallaxLayer/Forest").position.x = 1100
			self.get_parent().get_parent().get_parent().get_node("C2/Viewport2/ParallaxBackground/ParallaxLayer/Forest").position.y = -100
	elif ACT == 3:
		self.get_parent().get_node("ParallaxBackground/ParallaxLayer/Lab").position.x = 200
		if self.get_name() == "stage26":
			self.get_parent().get_node("ParallaxBackground/ParallaxLayer/Lab").scale.x = 1
			self.get_parent().get_node("ParallaxBackground/ParallaxLayer/Lab").scale.y = 1
		if self.get_name() == "stage32":
			self.get_parent().get_node("ParallaxBackground/ParallaxLayer/Lab").hide()
			self.get_parent().get_node("ParallaxBackground/ParallaxLayer/Forest").hide()
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
		if self.get_name() == FINALSTAGE:
			var p5 = pan.get_node("Panel5")
			p5.visible = true;
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
	