extends Node

var savegame = File.new() 
var save_path = "./savegame.save" 
var save_data = {"last_stage": 1}

var current_stage = 1 
var unlocked_stage = 1

var current_act = 1
var DEBUG = false
var restarting = false
var music = null
var audio = []
const FINAL = 21
var MENU_THEME = load("res://Sound/he56.wav")
var ACT1_THEME = load("res://Sound/cy34no-kick.wav")
var ACT2_THEME = load("res://Sound/mu45.wav")
var ACT3_THEME = load("res://Sound/cy34.wav")

var ACT1_BG = load("res://Sound/385943__inspectorj__ambience-machine-factory-a.wav")
var ACT2_BG = load("res://Sound/Cowbell Reversed.wav")
var ACT3_BG = load("res://Sound/Textile Printer.wav")

var SE_JOGAR = load("res://Sound/145459__soughtaftersounds__menu-click-sparkle.wav")
var SE_MOVE = load("res://Sound/397599__nightflame__menu-fx-02.wav")
var SE_ACCEPT = load("res://Sound/427993__newagesoup__newagesoup-fx-gui-682.wav")
var SE_CHANGE = load("res://Sound/237713__hydranos__beepd.wav")
var SE_LEVER = load("res://Sound/277651__coral-island-studios__button-4.wav")
var SE_BOX = load("res://Sound/218035__nitramdoh__moving-with-table.wav")
var SE_BREAK = load("res://Sound/446118__justinvoke__crack-1.wav")
var SE_WATER = load("res://Sound/190085__tran5ient__splash9.wav")

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
	if audio.size() == 0:
		for i in range(10):
			audio.push_back(AudioStreamPlayer.new())
			self.add_child(audio[i])
			audio[i].volume_db = 0
	else:
		audio[0].stop()
	if music == null:
		music = AudioStreamPlayer.new()
		self.add_child(music)
		music.stream = MENU_THEME
		music.volume_db = -10
		music.play()
	elif music.stream != MENU_THEME:
		music.stream = MENU_THEME
		music.play()
	else:
		return
	
func play_bgm():
	if current_stage < 13:
		music.stream = ACT1_THEME
		audio[0].stream = ACT1_BG
		audio[0].volume_db = -20
		audio[0].play()
	elif current_stage < 22:
		music.stream = ACT2_THEME
		audio[0].stream = ACT2_BG
		audio[0].volume_db = -10
		audio[0].play()
	else:
		music.stream = ACT3_THEME
		audio[0].stream = ACT3_BG
		audio[0].volume_db = -10
		audio[0].play()
	music.play()

func play_se(sound, loud=0):
		for i in range(10):
			if audio[i].playing and audio[i].stream == sound:
				return
			elif !audio[i].playing:
				audio[i].volume_db = loud
				audio[i].stream = sound
				audio[i].play()
				return
