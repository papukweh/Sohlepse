extends Control

const continue_= 0
const levelSelect_ = 1
const tests_ = 2
const options_ = 3
const credits_ = 4
const exit_ = 5
var state = 0
var pressed = [false, false, false, false, false, false]
var buttons = ["continue", "levelSelect", "tests", "option", "credits", "exit"]
var label = ["Jogar", "Seleção de Fases", "Testes", "Opções", "Créditos", "Sair"]
var LABEL = ["JOGAR", "SELEÇÃO DE FASES", "TESTES", "OPÇÕES", "CRÉDITOS", "SAIR"]
func _ready():
	global.initSound()
	get_node("continue").text = "JOGAR"

func _process(delta):
	if pressed[continue_]:
		global.DEBUG = false
		global.current_stage = global.unlocked_stage
		get_tree().change_scene("res://Manager/StageManager.tscn")
	if pressed[levelSelect_]:
		global.DEBUG = false
		get_tree().change_scene("Menus/Stage_Menu.tscn")
	if pressed[tests_]:
		global.DEBUG = true
		get_tree().change_scene("Menus/Stage_Menu.tscn")
	if pressed[options_]:
		get_tree().change_scene("Menus/Options.tscn")
	if pressed[credits_]:
		get_tree().change_scene("Menus/Credits.tscn")
	if pressed[exit_]:
		get_tree().quit()
	if Input.is_action_just_pressed("move_down"):
		_atualiza((state+1)%6)
	if Input.is_action_just_pressed("jump"):
		_atualiza((state-1)%6)
	if Input.is_action_just_pressed("ui_accept"):
		pressed[state] = true

func _on_continue_pressed():
	pressed[continue_] = true

func _on_levelSelect_pressed():
	pressed[levelSelect_] = true

func _on_tests_pressed():
	pressed[tests_] = true

func _on_option_pressed():
	pressed[options_] = true

func _on_credits_pressed():
	pressed[credits_] = true
	
func _on_exit_pressed():
	pressed[exit_] = true

func _atualiza(newState):
	get_node(buttons[state]).text = label[state]
	state = newState
	get_node(buttons[state]).text = LABEL[state]
