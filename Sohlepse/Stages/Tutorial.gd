extends Node

signal body_entered
var playedsetas = false
var playedinteract = false

func _ready():
	$AnimationPlayer.play("Setas")
	var Endgoal = get_parent().get_node("EndgoalMirror")
	Endgoal.connect("body_entered", self, "_on_EndgoalMirror_body_Entered")
	
func _on_EndgoalMirror_body_Entered(body):
	if not playedsetas:
		$AnimationPlayer.play("Interact")
		playedsetas = true

func _on_Event_body_entered(body):
	if not playedinteract:
		$AnimationPlayer.play_backwards("Setas")
		playedinteract = true
