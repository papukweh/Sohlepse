extends Area2D

onready var pai = null
onready var id = 0

func setup(receiver):
	id = int(get_name().substr(4,get_name().length()-4))
	pai = receiver
	
func _on_Area_body_entered(body):
	#print(pai.get_name()+" red:"+str(pai.red))
	#print(body.get_name().begins_with("Player"))
	if (pai.red and body.get_name() == "Player2") or (!pai.red and body.get_name().begins_with("Player") and body.prefix != "red") or (!pai.cutscene and body.get_name().begins_with("Player")):
		#print("entrei "+pai.get_name()+body.get_name())
		pai.body_entered(id)