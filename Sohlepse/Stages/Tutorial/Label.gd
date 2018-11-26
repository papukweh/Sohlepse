extends Node2D

func set_text(tex):
	$Label.text = tex
	
func set_pos(pos):
	self.position = pos

func red():
	$Label.set("custom_colors/font_color", Color(1,0,0))