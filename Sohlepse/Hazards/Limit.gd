extends Area2D
var time_left = 60
var inbody = null
var restart_wait_time = false
var timer = null

func _on_Limit_body_entered(body):
	if body.get_name().begins_with("Player"):
		timer = Timer.new()
		add_child(timer)
		timer.set_one_shot(true)
		timer.set_wait_time(1)
		timer.connect("timeout", self, "_timer_death")
		timer.start()
	else:
		body.queue_free()

func _timer_death():
	global.deaths += 1
	global.restart()