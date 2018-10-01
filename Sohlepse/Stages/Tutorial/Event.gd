extends Node2D

export(Array, Vector2) var events = []
export(Array, String) var labels = []
export(Array, Vector2) var pos = []
export(Array, Vector2) var areascale = []
onready var size = labels.size()
onready var checks = []
onready var last = 0
onready var stop = false
var area = preload("Area.tscn")
var label = preload("Label.tscn")

func _ready():
	for i in range (labels.size()):
		var l = label.instance()
		self.add_child(l)
		l = get_children()[-1]
		l.set_text(labels[i])
		l.set_position(pos[i])
		l.set_name("Label"+str(i))
		var a = area.instance()
		self.add_child(a)
		a = get_children()[-1]
		a.position = events[i]
		if areascale:
			a.scale = areascale[i]
		a.set_name("Area"+str(i))
		a.setup(self)
		checks.push_back(false)

func body_entered(id):
	if stop:
		return
	if !checks[last] and id == last:
		if last == 0:
			$Tween.interpolate_property(get_node("Label"+str(last)), "modulate",
			Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5,
			Tween.TRANS_LINEAR, Tween.EASE_IN)
		else:
			$Tween.interpolate_property(get_node("Label"+str(last-1)), "modulate",
	    Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5,
	    Tween.TRANS_LINEAR, Tween.EASE_IN)
		checks[last] = true
		$Tween.start()

func _on_Tween_tween_completed(object, key):
	if stop or last == 0:
		last +=1
		return
	if checks[last] and (last+1 >= size or not checks[last+1]):
		$Tween.interpolate_property(get_node("Label"+str(last)), "modulate",
		Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
		last +=1
		if last >= size:
			stop = true