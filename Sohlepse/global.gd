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
const FINAL = 32

var MENU_THEME = load("res://Sound/he56.wav")
var ACT1_THEME = load("res://Sound/cy34.wav")
var ACT2_THEME = load("res://Sound/mu45.wav")
var ACT3_THEME = load("res://Sound/cy67.wav")

var ACT1_BG = load("res://Sound/385943__inspectorj__ambience-machine-factory-a.wav")
var ACT1_BG2 = load("res://Sound/13538__bjornredtail__printernoise.wav")
var ACT2_BG = load("res://Sound/Night_Sounds_-_Crickets-Lisa_Redfern-591005346.wav")
var ACT2_BG2 = load("res://Sound/cartoon-wolf-daniel_simon.wav")
var ACT3_BG = load("res://Sound/385943__inspectorj__ambience-machine-factory-a.wav")
var ACT3_BG2 = load("res://Sound/65145__andaris__bounce.wav")
var ACT3_BG3 = load("res://Sound/432068__screamstudio__future-alarm.wav")

var SE_JOGAR = load("res://Sound/145459__soughtaftersounds__menu-click-sparkle.wav")
var SE_MOVE = load("res://Sound/397599__nightflame__menu-fx-02.wav")
var SE_ACCEPT = load("res://Sound/427993__newagesoup__newagesoup-fx-gui-682.wav")
var SE_CHANGE = load("res://Sound/403011__inspectorj__ui-confirmation-alert-b1.wav")
var SE_PAUSE = load("res://Sound/403009__inspectorj__ui-confirmation-alert-b3.wav")
var SE_UNPAUSE = load("res://Sound/403010__inspectorj__ui-confirmation-alert-b2.wav")
var SE_EXIT = load("res://Sound/413749__inspectorj__ui-confirmation-alert-d1.wav")

var SE_DIE = load("res://Sound/257710__vmgraw__grunt-1.wav")
var SE_WALKING = load("res://Sound/151229__owlstorm__grassy-footstep-2.wav")
var SE_LEVER = load("res://Sound/277651__coral-island-studios__button-4.wav")
var SE_BOX = load("res://Sound/218035__nitramdoh__moving-with-table.wav")
var SE_BREAK = load("res://Sound/446118__justinvoke__crack-1.wav")
var SE_WATER = load("res://Sound/190085__tran5ient__splash9.wav")
var SE_METAL = load("res://Sound/403162__fallujahqc__footstep-metal.wav")
var SE_THORNS = load("res://Sound/443806__deathscyp__spiketrap.wav")
var SE_WALL = load("res://Sound/425090__neospica__pressurized-door-opening.wav")
var SE_LED = load("res://Sound/154953__keykrusher__microwave-beep.wav")
var SE_PLATFORM = load("res://Sound/28341__xsub__5400-spin-down.wav")
var SE_EVIL_LAUGH = load("res://Sound/Evil_Laugh_Male_6-Himan-1359990674.wav")
var SE_EXPLOSION = load("res://Sound/33245__ljudman__grenade.wav")

onready var base_master = -10
onready var base_bgm = 0
onready var base_se = 0

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
	return save_data["last_stage"]
	#return FINAL
	
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
			audio[i].volume_db = base_master
	else:
		audio[0].stop()
	if music == null:
		music = AudioStreamPlayer.new()
		self.add_child(music)
		music.stream = MENU_THEME
		music.volume_db = base_master -5
		music.play()
	elif music.stream != MENU_THEME:
		music.stream = MENU_THEME
		music.volume_db = base_master -5
		music.play()
	else:
		return

func recalibrate():
	music.volume_db = base_master + base_bgm - 10
	for i in range(10):
		audio[i].volume_db = base_master + base_se

func stop_bgm():
	music.stop()

func play_bgm():
	if current_stage < 13:
		music.stream = ACT1_THEME
		music.volume_db = base_master + base_bgm + 2
		audio[0].stream = ACT1_BG
		audio[0].volume_db = base_master + base_se -10
		audio[0].play()
	elif current_stage < 25:
		music.stream = ACT2_THEME
		music.volume_db = base_master + base_bgm  - 5
		audio[0].stream = ACT2_BG
		audio[0].volume_db = base_master + base_se -20
		audio[0].play()
	else:
		music.stream = ACT3_THEME
		music.volume_db = base_master + base_bgm  + 2
		if current_stage == 32:
			audio[0].stream = ACT3_BG3
			audio[0].volume_db = base_master + base_se -5
		else:
			audio[0].stream = ACT3_BG
			audio[0].volume_db = base_master + base_se -20
	audio[0].play()
	music.play()

func play_se(sound, loud=0):
	for i in range(10):
		if get_tree().paused and i >= 3:
			audio[i].playing = false
		if audio[i].playing and audio[i].stream == sound and !get_tree().paused:
			return
		elif !audio[i].playing:
			audio[i].volume_db = base_master + base_se + loud
			audio[i].stream = sound
			audio[i].play()
			return
