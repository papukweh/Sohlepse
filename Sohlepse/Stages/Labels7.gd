extends Node

onready var playedBackCuidado = false
onready var playedAgua = false

func _ready():
	$AnimationPlayer.play("Cuidado")

func _on_AnimationPlayer_animation_finished(anim_name):
	if playedBackCuidado and not playedAgua:
		$AnimationPlayer.play("Agua")
		playedAgua = true


func _on_Event_body_entered(body):
	if !playedBackCuidado:
		$AnimationPlayer.play_backwards("Cuidado")
		playedBackCuidado = true
