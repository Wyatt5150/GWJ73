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
var starting_souls : int = 10

var death_cost : int = 1
var deaths : int = 0 :
	set(new_val):
		death_cost = 2 ** new_val
		deaths = new_val

var timing = false
var portal_timer : float = 50.0 :
	set(new_val):
		if current_floor == 0:
			%PortalTimer.text = "Portal Opens In: - -"
			portal_timer = 50.0
			return
		portal_timer = new_val
		if portal_timer > 0.0:
			get_tree().call_group("Portal", 'Open', false)
			%PortalTimer.text = "Portal Opens In: " + str(int(portal_timer))
			return
		else:
			get_tree().call_group("Portal", 'Open', true)
			%PortalTimer.text = "Portal Closes In: " + str(10 + int(portal_timer))
			if portal_timer < -10.0:
				portal_timer = 50.0
			return
			
		

func _ready() -> void:
	current_floor = 0
	StartLevel()

func _process(delta: float) -> void:
	if timing:
		portal_timer -= delta

func Transition(state : STATE = STATE.WIN):
	get_tree().call_group("Portal", 'Open', false)
	timing = false
	portal_timer = 50.0
	
	if state == STATE.WIN:
		current_floor += 1
	else:
		current_floor = 0
	
	get_tree().call_deferred("change_scene_to_packed", transition)


func StartLevel():
	timing = true
	Audio.ChangeMusic(Audio.MUSIC_TRACKS.CLOCK_TOWER)
	if current_floor == 0:
		WeaponData.Reset_Weapon_Data()
		souls = starting_souls
		deaths = 0
		get_tree().call_deferred("change_scene_to_file", SCENES_PATH[SCENES.MAIN_MENU])
	else:
		get_tree().call_deferred("change_scene_to_file", SCENES_PATH[SCENES.FLOOR])
	
