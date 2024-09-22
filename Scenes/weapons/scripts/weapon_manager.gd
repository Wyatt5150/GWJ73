extends Node

enum WEAPONS {
	SYCTHE,
	SWORD,
	BALL,
	CLONE,
	HOMING
}

class Weapon:
	const base_path = "res://Scenes/weapons/"
	const base_sprite_path = "res://icon.svg"
	var path : String
	var sprite_path : String
	var level : int = 0
	var active : bool = false
	
	func _init(_path : String, sprite : String = base_sprite_path) -> void:
		self.path = base_path + _path
		self.sprite_path = sprite
	
	func Reset() -> void:
		level = 0
		active = false
	
	func Upgrade() -> void:
		level += 1
		active = true
	
	func Spawn() -> Node2D:
		var entity = load(path)
		
		return entity
	
	func Get_Icon() -> Texture:
		var sprite = load(sprite_path)
		return sprite


var WEAPON_DATA : Dictionary = {
	WEAPONS.SYCTHE : Weapon.new(
		".tscn",
		"res://Assets/Sycthe.png"
	),
	WEAPONS.SWORD : Weapon.new(
		".tscn",
		"res://NotMine/swrod.png"
	),
	WEAPONS.BALL :Weapon.new(
		".tscn",
		"res://NotMine/electricBall.png"
	),
	WEAPONS.CLONE : Weapon.new(
		".tscn",
		"res://NotMine/CloneIcon.png"
	),
	WEAPONS.HOMING : Weapon.new(
		".tscn",
		"res://NotMine/HomingBase.png"
	)
}

func Reset_Weapon_Data() -> void:
	for weapon in WEAPONS.values():
		WEAPON_DATA[weapon].Reset()

func Upgrade_Weapon(weapon : WEAPONS) -> void:
	WEAPON_DATA[weapon].Upgrade()

func Get_Weapon(weapon : WEAPONS) -> Weapon:
	return WEAPON_DATA[weapon]

func Get_Random() -> WEAPONS:
	return WEAPON_DATA.keys().pick_random()
