extends Node2D
class_name WeaponBase

@export var speed : float = 1.0
@export var projectile : PackedScene
@export var type : WeaponData.WEAPONS
@export var target : Data.LAYERS = Data.LAYERS.ENEMY
@export var base_damage : int = 2
var damage
var weapon_data : WeaponData.Weapon

func _ready():
	damage = base_damage
	weapon_data = WeaponData.Get_Weapon(type)
	weapon_data.upgraded.connect(Callable(self, "Upgrade"))
	Upgrade(weapon_data.level)

func Upgrade(level : int):
	pass
	

func Hit(_area : Area2D):
	if _area is HurtboxComponent:
		_area.Damage(damage)
	
