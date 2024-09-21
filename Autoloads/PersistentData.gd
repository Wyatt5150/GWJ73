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
	FLOOR,
	TRANSITION
}

const SCENES_PATH : Dictionary = {
	SCENES.MAIN_MENU : "res://Levels/MainMenu.tscn",
	SCENES.FLOOR : "res://Levels/floor.tscn",
	SCENES.TRANSITION : ""
}

@export var current_scene : SCENES = SCENES.MAIN_MENU


var SPAWNCAP = 50




var current_floor = 0 :
	set(new_val):
		current_floor = new_val

var souls : int = 0 : 
	set(new_val): 
		souls = new_val
var starting_souls : int = 5

var death_cost : int = 1
var deaths : int = 0 :
	set(new_val):
		death_cost = 2 ** new_val
		deaths = new_val



func Transition():
	get_tree().call_group("Portal", 'Open', false)
	print("complete")
	await get_tree().create_timer(3.0).timeout
	
	get_tree().call_group("Portal", 'Open', true)

func Death():
	pass


func StartLevel():
	if current_floor == 0:
		%PortalTimer.hide()
	else:
		%PortalTimer.show()
	pass
