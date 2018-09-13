extends Node

onready var waitingLabel2 = false
onready var waitingLabel3 = false
onready var played3 = false
onready var label1 = true
onready var label2 = false
onready var label3 = false


func _ready():
	$AnimationPlayer.play("anim1")

func _on_Event2_body_entered(body):
	if label1:
		$AnimationPlayer.play_backwards("anim1")
		label1 = false
		waitingLabel2 = true


func _on_Event3_body_entered(body):
	if label2:
		$AnimationPlayer.play_backwards("anim2")
		label2 = false	
		waitingLabel3 = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if waitingLabel2:
		$AnimationPlayer.play("anim2")
		waitingLabel2 = false
		label2 = true
	if waitingLabel3:
		$AnimationPlayer.play("anim3")
		waitingLabel3 = false
		label3 = true
		
		
		
