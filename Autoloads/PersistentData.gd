extends Node

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

const FLOOR_PATH : Dictionary = {
	SCENES.MAIN_MENU : "",
	SCENES.FLOOR : "res://Levels/floor.tscn"
}

@export var current_scene : SCENES = SCENES.MAIN_MENU
@export var endless : bool = true

var SPAWNCAP = 50


var Upgrades : Dictionary = {
	
}


var current_floor = 0 :
	set(new_val):
		current_floor = new_val

var souls : int = 0
var starting_souls : int = 5

var death_cost : int = 1
var deaths : int = 0 :
	set(new_val):
		death_cost = 2 ** new_val
		deaths = new_val
