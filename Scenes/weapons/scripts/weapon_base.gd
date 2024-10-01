extends Node2D
class_name WeaponBase

@export var base_fire_interval : float = 1.0
@export var projectile : PackedScene
@export var type : WeaponData.WEAPONS
@export var target_type : Array[Data.LAYERS] = [Data.LAYERS.ENEMY]
@export var base_damage : int = 2
var damage
var weapon_data : WeaponData.Weapon
var fire_interval

func _ready():
	fire_interval = base_fire_interval
	damage = base_damage
	weapon_data = WeaponData.Get_Weapon(type)
	weapon_data.upgraded.connect(Callable(self, "Upgrade"))
	Upgrade(weapon_data.level)
	_Fire()

func Upgrade(_level : int):
	printerr("No Upgrade method implemented for ", self.get_class())

func _Fire():
	if base_fire_interval < 0:
		return
	await get_tree().create_timer(fire_interval).timeout
	Fire()
	_Fire()

func Fire():
	pass

func SetChildRoot(_projectile : Area2D) -> Projectile:
	get_tree().root.add_child(_projectile)
	_projectile.global_position = self.global_position
	
	return _projectile
