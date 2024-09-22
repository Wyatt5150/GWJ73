extends Node
class_name Data_Handler

enum LAYERS {
	IMPASSABLE,
	FALLTHROUGH,
	PLAYER,
	TOWER,
	ENEMY
}

const LAYERS_MAP : Dictionary = {
	LAYERS.IMPASSABLE : 1,
	LAYERS.FALLTHROUGH : 2,
	LAYERS.PLAYER : 3,
	LAYERS.TOWER : 4,
	LAYERS.ENEMY : 5
}

enum SCENES {
	MAIN_MENU,
	FLOOR
}

const SCENES_PATH : Dictionary = {
	SCENES.MAIN_MENU : "res://Levels/MainMenu.tscn",
	SCENES.FLOOR : "res://Levels/floor.tscn"
}

enum STATE {
	WIN,
	LOSE
}

@export var current_scene : SCENES = SCENES.MAIN_MENU
@export var transition : PackedScene

var SPAWNCAP = 50


var current_floor = 0 :
	set(new_val):
		%FloorNumber.text = "Floor: " + str(new_val)
		current_floor = new_val

var souls : int = 0 : 
	set(new_val): 
		%SoulCount.text = "Souls: " + str(new_val)
		souls = new_val
var starting_souls : int = 5

var death_cost : int = 1
var deaths : int = 0 :
	set(new_val):
		death_cost = 2 ** new_val
		deaths = new_val

func _ready() -> void:
	current_floor = 0
	StartLevel()

func Transition(state : STATE = STATE.WIN):
	get_tree().call_group("Portal", 'Open', false)
	
	if state == STATE.WIN:
		current_floor += 1
	else:
		current_floor = 0
	
	get_tree().change_scene_to_packed(transition)


func StartLevel():
	if current_floor == 0:
		WeaponData.Reset_Weapon_Data()
		souls = starting_souls
		deaths = 0
		get_tree().call_deferred("change_scene_to_file", SCENES_PATH[SCENES.MAIN_MENU])
		#TODO TIMER.stop
	else:
		get_tree().call_deferred("change_scene_to_file", SCENES_PATH[SCENES.FLOOR])
		#TODO TIMER.start
	
