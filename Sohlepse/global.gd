extends Node

var savegame = File.new() 
var save_path = "./savegame.save" 
var save_data = {"last_stage": 1}

var current_stage = 1 
var unlocked_stage = 1

var current_act = 1
var DEBUG = false
var restarting = false
const FINAL = 18

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