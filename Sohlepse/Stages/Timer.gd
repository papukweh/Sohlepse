extends Timer
var pan = null
var ptimer = null

func _ready():
	pan = get_tree().get_root().get_child(1).get_node("Tutoriais")
	ptimer = pan.get_node("Panel5")
	pass

func _process(delta):
	ptimer.label = time_the_timer()
	ptimer.ready()
	
func time_the_timer():
	if(time_left < 10):
		return "0:0" + str(int(time_left)%60)
	else:
		return str(int(time_left)/60) + ":" + str(int(time_left)%60) 
	
func _on_Timer_timeout():
	global.restart()
