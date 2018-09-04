extends Node

onready var playedcaixas = false
onready var playedalavancas = false

func _ready():
	$AnimationPlayer.play("Caixas")

func _on_Event_body_entered(body):
	if not playedcaixas:
		$AnimationPlayer.play_backwards("Caixas")
		playedcaixas = true

func _on_AnimationPlayer_animation_finished(anim):
	if playedcaixas and not playedalavancas:
		$AnimationPlayer.play("Alavancas")
		playedalavancas = true
