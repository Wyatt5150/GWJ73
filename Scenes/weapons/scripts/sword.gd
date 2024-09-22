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
	%Timer.wait_time = max(0.2, 1.5 - (0.1 * level))
	
func Fire():
	if weapon_data.level == 0:
		return
	var ball : SwordProjectile = projectile.instantiate()
	ball.collision_layer = 0
	ball.collision_mask = 0
	ball.set_collision_mask_value(Data.LAYERS_MAP[target], true)
	ball.area_entered.connect(Callable(self, "Hit"))
	ball.pierce = pierce
	ball. direction = direction
	get_tree().root.add_child(ball)
	
	ball.global_position = self.global_position

func Hit(_area : Area2D):
	if _area is HurtboxComponent:
		_area.Damage(damage)
	
