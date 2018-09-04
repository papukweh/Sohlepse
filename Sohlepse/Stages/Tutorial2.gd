extends Node

var playedcaixas = false
var playedalavanca = false

func _ready():
	$AnimationPlayer.play("Caixas")

func _on_Event_body_entered(body):
	if not playedcaixas:
		$AnimationPlayer.play_backwards("Caixas")
		playedcaixas = true
	if not playedalavanca:
		$AnimationPlayer.play("Alavancas")
		playedalavanca = true
