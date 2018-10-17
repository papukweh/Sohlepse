extends Node2D

var oneway = false
export var activated = 0 #activated by default
export var motion = Vector2()
export var cycle = 1.0
var accum = 0.0
signal triggered
onready var objs = Dictionary()

func _ready():
	if $platform/CollisionShape2D.one_way_collision:
		oneway = true

func _physics_process(delta):
	var d = 0
	var xf = Transform2D()
	if activated == 0:
		accum += delta * (1.0 / cycle) * PI * 2.0
		accum = fmod(accum, PI * 2.0)
		d = sin(accum)
		xf[2]= motion * d 
		$platform.transform = xf
		
		if !objs.empty():
			for i in objs.values():
				if motion[1] != 0:
					if sign(i.velocity.y) != sign(d): 
						i.GRAVITY = -2
					else:
						i.GRAVITY = 0
				if i.get_name().begins_with("Player"):
					if oneway and motion[1] != 0:
						i.position.y = $platform.global_position.y - 42
					elif oneway and motion[1] == 0:
						i.velocity *= 1.01
					elif not i.jumping and i.jump:
						i.position += $platform.get_linear_velocity()*delta
				elif i.get_name().begins_with("Box"):
					if oneway:
						if motion[1] != 0:
							if !i.get_objs().empty():
								for a in i.get_objs().values():
									a.position.y = $platform.global_position.y - 86
							i.position.y = $platform.global_position.y - 42
						else:
							if !i.get_objs().empty():
								for a in i.get_objs().values():
									a.position += $platform.get_linear_velocity()*delta
							i.position += $platform.get_linear_velocity()*delta
					else:
						i.position += $platform.get_linear_velocity()*delta
						if !i.get_objs().empty():
							for a in i.get_objs().values():
								a.position += $platform.get_linear_velocity()*delta
				else:
					if oneway and motion[1] != 0:
						i.position += $platform.get_linear_velocity()*delta

func onTriggered():
	if activated == 1:
		activated = 0
	else:
		activated = 1

func _on_Area2D_body_entered(body):
	if body.is_in_group('gravity'):
		if body.get_name().begins_with("Player") and oneway:
			print("minhavel="+str(body.velocity.y))
			if body.velocity.y <= 0 and motion[1] != 0:
				return
		print("botei no ash: "+body.get_name())
		objs[body.get_name()] = body

func _on_Area2D_body_exited(body):
	if body.is_in_group('gravity'):
		if objs.has(body.get_name()):
			print("tirei do ash: "+body.get_name())
			body.GRAVITY = 700
			objs.erase(body.get_name())
