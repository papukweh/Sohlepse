extends Control
var continue_pressed = false
var levelSelect_pressed = false
var options_pressed = false
var credits_pressed = false
var exit_pressed = false
var state = 0
var buttons = ["continue", "levelSelect", "option", "credits", "exit"]
var label = ["Continuar", "Seleção de Fases", "Opções", "Créditos", "Sair"]
var LABEL = ["CONTINUAR", "SELEÇÃO DE FASES", "OPÇÕES", "CRÉDITOS", "SAIR"]
func _ready():
	get_node("continue").text = "CONTINUAR"

func _process(delta):
	if continue_pressed or (Input.is_action_just_pressed("interact") and state == 0):
		global.current_stage = global.unlocked_stage
		get_tree().change_scene("StageManager.tscn")
	if levelSelect_pressed or (Input.is_action_just_pressed("interact") and state == 1):
		get_tree().change_scene("Stage_Menu.tscn")
	if options_pressed or (Input.is_action_just_pressed("interact") and state == 2):
		get_tree().change_scene("Options.tscn")
	if credits_pressed or (Input.is_action_just_pressed("interact") and state == 3):
		get_tree().change_scene("Credits.tscn")
	if exit_pressed or (Input.is_action_just_pressed("interact") and state == 4):
		get_tree().quit()
	if Input.is_action_just_pressed("move_down"):
		get_node(buttons[state]).text = label[state]
		state = (state+1)%5
		get_node(buttons[state]).text = LABEL[state]
	if Input.is_action_just_pressed("jump"):
		get_node(buttons[state]).text = label[state]
		state = (state-1)%5
		get_node(buttons[state]).text = LABEL[state]

func _on_continue_pressed():
	continue_pressed = true

func _on_levelSelect_pressed():
	levelSelect_pressed = true

func _on_option_pressed():
	options_pressed = true

func _on_credits_pressed():
	credits_pressed = true
	
func _on_exit_pressed():
	exit_pressed = true
