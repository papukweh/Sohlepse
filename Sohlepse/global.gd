extends Node

var savegame = File.new() 
var save_path = "./savegame.save" 
var save_data = {"last_stage": 1}

var current_stage = 1 
var unlocked_stage = 1

var current_act = 1
var DEBUG = false
var restarting = false
var audio = null
const FINAL = 21
var MENU_THEME = load("res://Sound/he56.wav")
var ACT1_THEME = load("res://Sound/cy34no-kick.wav")
var ACT2_THEME = load("res://Sound/mu45.wav")
var ACT3_THEME = load("res://Sound/cy34.wav")

func restart():
	restarting = true
	get_tree().reload_current_scene()
	
var pos = []
var buffer = []
var state = []
var play = false
var nclones = 0

func save_clones(spos, sbuffer, sstate):
	pos = [] + spos
	buffer = [] + sbuffer
	state = sstate
	
func load_pos():
	return pos
	
func load_buffer():
	return buffer
	
func load_state():
	return state
	
func clean():
	pos = []
	buffer = []
	state = []
	nclones = 0
	
func progress():
	savegame.open(save_path, File.READ)
	save_data = savegame.get_var()
	savegame.close()
	#return save_data["last_stage"]
	return FINAL
	
func save():
	if current_stage > unlocked_stage:
		unlocked_stage = current_stage
		save_data["last_stage"] = current_stage
		savegame.open(save_path, File.WRITE)
		savegame.store_var(save_data)
		savegame.close()

func create_save():
	savegame.open(save_path, File.WRITE)
	savegame.store_var(save_data)
	savegame.close()

func _ready():
	if not savegame.file_exists(save_path):
		create_save()
	unlocked_stage = progress()
	
func initSound():
	if audio == null:
		audio = AudioStreamPlayer.new()
		self.add_child(audio)
		audio.stream = MENU_THEME
		audio.volume_db = -10
		audio.play()
	elif audio.stream != MENU_THEME:
		audio.stream = MENU_THEME
		audio.play()
	else:
		return
	
func play_bgm():
	if current_stage < 13:
		audio.stream = ACT1_THEME
	elif current_stage < 22:
		audio.stream = ACT2_THEME
	else:
		audio.stream = ACT3_THEME
	audio.play()