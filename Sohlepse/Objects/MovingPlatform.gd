extends Node2D

export var activated = 0 #activated by default
export var motion = Vector2()
export var cycle = 1.0
export var invertido = false
var accum = 0.0
signal triggered
onready var objs = Dictionary()

func _physics_process(delta):
	var d = 0
	var xf = Transform2D()
	if activated == 0:
		accum += delta * (1.0 / cycle) * PI * 2.0
		accum = fmod(accum, PI * 2.0)
		d = sin(accum)
		xf[2]= motion * d 
		$platform.transform = xf
		
		if !objs.empty() and (invertido or motion[1] != 0):
			var corrige = 0
			#print(d)
			if d < 0:
				corrige = 700
			for i in objs.values():
				i.GRAVITY = 0
				i.position += $platform.get_linear_velocity()*delta
				if i.get_name().begins_with("Box"):
					if !i.get_objs().empty():
						for a in i.get_objs().values():
							a.position += $platform.get_linear_velocity()*delta
		
func onTriggered():
	if activated == 1:
		activated = 0
	else:
		activated = 1

func _on_Area2D_body_entered(body):
	var doit = false
	if body.is_in_group('gravity'):
		doit = true
		if body.get_name().begins_with("Player"):
			if body.ground().get_name() == "Area2D" or body.ground().get_name().begins_with("TileMap"):
				doit = true
			else:
				doit = false
	if doit:
		print("botei no ash: "+body.get_name())
		objs[body.get_name()] = body

func _on_Area2D_body_exited(body):
	
	if body.is_in_group('gravity'):
		if objs.has(body.get_name()):
			print("tirei do ash: "+body.get_name())
			body.GRAVITY = 700
			objs.erase(body.get_name())
