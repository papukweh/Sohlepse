extends Timer
var pan = null
var ptimer = null
var played = false
var anim = null

func _ready():
	pan = get_tree().get_root().get_child(1).get_node("Tutoriais")
	ptimer = pan.get_node("Panel5")
	anim = pan.get_node("Bomb")

func _process(delta):
	if time_left <= 2 and !played:
		print("ue")
		global.stop_bgm()
		global.play_se(global.SE_EXPLOSION, 3)
		anim.play("Booom")
		played = true
	ptimer.label = time_the_timer()
	ptimer.ready()
	if !anim.is_playing():
		anim.play("Flash")
	
func time_the_timer():
	if time_left < 10:
		return "0:0" + str(int(time_left)%60)
	elif time_left >= 60 and time_left < 70: 
		return str(int(time_left)/60) + ":0" + str(int(time_left)%60)
	else:
		return str(int(time_left)/60) + ":" + str(int(time_left)%60) 
	
func _on_Timer_timeout():
	global.restart()
