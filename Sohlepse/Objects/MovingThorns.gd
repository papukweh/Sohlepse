extends Node2D

export var activated = 0 #activated by default
export var thorn_begin = 1 #activated by default
export var motion = Vector2()
export var cycle = 1.0
export var forest = 0
onready var pref = "lab_"
var accum = 0.0
signal triggered
onready var objs = Dictionary()

func _ready():
	if forest != 0:
		pref = "forest_"
	if thorn_begin == 1:
		$Thorns.on = true
		$Thorns/Body/AnimatedSprite.animation = pref + "on"

func _physics_process(delta):
	if motion[0] == motion[1] and motion[1] == 0:
		return
	var d = 0
	var xf = Transform2D()
	if activated == 0:
		accum += delta * (1.0 / cycle) * PI * 2.0
		accum = fmod(accum, PI * 2.0)
		d = sin(accum)
		xf[2]= motion * d
		$Thorns/Body.transform = xf

		if !objs.empty(): #and motion[1] != 0:
			for i in objs.values():
				if motion[1] != 0:
					i.GRAVITY = -0.01
					#print("jump="+str(i.jump))
					#print("jumping="+str(i.jumping))
					i.position += 0.8*$Thorns/Body.get_linear_velocity()*delta
				#i.position.y = $platform.global_position.y - 42
				if i.get_name().begins_with("Box") or i.is_in_group("Player"):
					if !i.get_objs().empty():
						for a in i.get_objs().values():
							if motion[1] != 0:
								a.GRAVITY = -0.01
							a.position += 0.8*$Thorns/Body.get_linear_velocity()*delta
							a.carry = self
					i.position += 0.8*$Thorns/Body.get_linear_velocity()*delta
func onTriggered():
	if activated == 1:
		activated = 0
	else:
		activated = 1

func entered(body):
	#print(body.get_name()+" entrou em "+self.get_name())
	if motion[0] == motion[1] and motion[1] == 0:
		return
	elif !objs.has(body.get_name()):
		body.position.y = $Thorns/Body.global_position.y - 42
		objs[body.get_name()] = body
	return

func left(body):
	body.GRAVITY = 700
	if objs.has(body.get_name()):
		body.GRAVITY = 700
		objs.erase(body.get_name())

func _on_Area2D2_body_entered(body):
	if motion[0] == motion[1] and motion[1] == 0:
		return
	if body.is_in_group('gravity'):
		if body.get_name().begins_with("Player"):
			return
		body.position.y = $Thorns/Body.global_position.y - 42
		objs[body.get_name()] = body

func _on_Area2D2_body_exited(body):
	if motion[0] == motion[1] and motion[1] == 0:
		return
	if body.is_in_group('gravity'):
		if body.get_name().begins_with("Player"):
			return
		if objs.has(body.get_name()):
			#print("tirei do ash: "+body.get_name())
			body.GRAVITY = 700
			objs.erase(body.get_name())

