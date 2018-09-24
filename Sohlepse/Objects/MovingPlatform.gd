extends Node2D

export var activated = 0 #activated by default
export var motion = Vector2()
export var cycle = 1.0
var accum = 0.0
signal triggered

func _ready():
	if motion.y != 0:
		$platform.add_to_group('kill')

func _physics_process(delta):
	if activated == 0:
		accum += delta * (1.0 / cycle) * PI * 2.0
		accum = fmod(accum, PI * 2.0)
		var d = sin(accum)
		var xf = Transform2D()
		xf[2]= motion * d 
		$platform.transform = xf
		
func onTriggered():
	if activated == 1:
		activated = 0
	else:
		activated = 1
