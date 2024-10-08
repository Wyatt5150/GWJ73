extends WeaponBase
class_name Sword

@export var base_pierce : int = 3
var pierce
var direction : float

func ChangeDirection(_direction : float) -> void:
	if _direction:
		direction = _direction

func Upgrade(level : int):
	pierce = base_pierce + level
	damage = base_damage * level
	fire_interval = max(0.2, base_fire_interval - (0.1 * level))
	
func Fire():
	if weapon_data.level == 0:
		return
	var _projectile : Projectile = projectile.instantiate()
	_projectile._SetLayers(target_type)
	self.add_child(_projectile)
	_projectile.reparent(get_tree().root, true)
	
	_projectile.pierce = pierce
	_projectile.direction = direction
	_projectile._Fire()
