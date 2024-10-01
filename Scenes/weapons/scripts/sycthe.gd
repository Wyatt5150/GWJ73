extends WeaponBase
class_name Scythe

var direction : float = 1.0

func ChangeDirection(_direction : float) -> void:
	if _direction:
		direction = _direction

func Upgrade(level : int):
	damage = base_damage * level
	fire_interval = max(0.2, base_fire_interval - (0.1 * level))
	
func Fire():
	if weapon_data.level == 0:
		return
	
	var _projectile : Bullet = projectile.instantiate()
	#_projectile._SetLayers(target_type)
	self.add_child(_projectile)
	_projectile.reparent(get_tree().root, true)
