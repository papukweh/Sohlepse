extends Button
onready var id = self.get_name().right(4)
signal pressed_slot(slot)

func set_info(player, playtime, deaths, last_stage):
	$Info.set_text(" Jogador: "+str(player)+"\n Tempo de jogo: "+str(playtime)+"min\n Mortes: "+str(deaths)+"\n Fase atual: "+str(last_stage))
	$Number.set_text(id)
	$Sprite.texture = load("res://Assets/thumbnail"+str(last_stage)+".png")

func set_empty():
	$Info.set_text(" EMPTY ")
	$Number.set_text(id)
	$Sprite.hide()

func _on_Slot_pressed():
	emit_signal("pressed_slot", int(id))
