extends Node

var savegame = File.new() 
var save_path = "./savegame.save" 
var save_data = {"last_stage": 1}

var current_stage = 0 
var unlocked_stage = 1

func restart():
	get_tree().reload_current_scene()
	
func progress():
	savegame.open(save_path, File.READ)
	save_data = savegame.get_var()
	savegame.close()
	return save_data["last_stage"]
	
func save():
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