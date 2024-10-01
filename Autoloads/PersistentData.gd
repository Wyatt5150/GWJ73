extends Node
class_name Data_Handler

enum LAYERS {
	IMPASSABLE = 1,
	FALLTHROUGH = 2,
	PLAYER = 3,
	ENEMY = 5
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

@export var portal_time : float = 60.0

var current_floor = 0 :
	set(new_val):
		%FloorNumber.text = "Floor: " + str(new_val)
		current_floor = new_val

var souls : int = 0 : 
	set(new_val): 
		%SoulCount.text = "Souls: " + str(new_val)
		souls = new_val
var starting_souls : int = 9999

var death_cost : int = 1
var deaths : int = 0 :
	set(new_val):
		death_cost = 2 ** new_val
		deaths = new_val

signal clear_projectiles

var timing = false
var portal_timer : float = 60.0 :
	set(new_val):
		if current_floor == 0:
			%PortalTimer.text = "Portal Opens In: - -"
			portal_timer = 60.0
			return
		portal_timer = new_val
		if portal_timer > 0.0:
			get_tree().call_group("Portal", 'Open', false)
			%PortalTimer.text = "Portal Opens In: " + str(int(portal_timer))
			return
		else:
			get_tree().call_group("Portal", 'Open', true)
			%PortalTimer.text = "Portal Is Open"
			portal_timer = 0.0
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
	
	if state == STATE.WIN:
		current_floor += 1
	else:
		current_floor = 0
	
	get_tree().call_deferred("change_scene_to_packed", transition)

func StartLevel():
	clear_projectiles.emit()
	timing = true
	Audio.ChangeMusic(Audio.MUSIC_TRACKS.CLOCK_TOWER)
	if current_floor == 0:
		WeaponData.Reset_Weapon_Data()
		souls = starting_souls
		deaths = 0
		get_tree().call_deferred("change_scene_to_file", SCENES_PATH[SCENES.MAIN_MENU])
	else:
		portal_timer = portal_time
		get_tree().call_deferred("change_scene_to_file", SCENES_PATH[SCENES.FLOOR])
	
func _set_layers(node : CollisionObject2D, layers):
	node.set_collision_layer(0)
	for layer in layers:
		node.set_collision_layer_value(layer, true)

func _set_masks(node : CollisionObject2D, layers):
	node.set_collision_mask(0)
	for layer in layers:
		node.set_collision_mask_value(layer, true)
