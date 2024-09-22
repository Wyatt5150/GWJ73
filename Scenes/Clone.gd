extends WeaponBase
class_name Clone


func Upgrade(level : int):
	damage = base_damage * level
	%Timer.wait_time = max(0.2, 3 - (0.2 * level))
	%Timer.start()
	
func Fire():
	if weapon_data.level == 0:
		return
	var ball : Explosion = projectile.instantiate()
	ball.hit.connect(Callable(self, "Hit"))
	get_tree().root.add_child(ball)
	
	ball.global_position = self.global_position

func Hit(_area : Area2D):
	if _area is HurtboxComponent:
		_area.Damage(damage)
	
