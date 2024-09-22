extends WeaponBase
class_name Balls

@export var radius : float = 60.0
var rot_speed : int = 0

func _physics_process(delta: float) -> void:
	self.rotate(rot_speed * delta)

func Upgrade(level : int):
	rot_speed = (1.2 ** level) * speed
	for child in get_children():
		child.queue_free()
	
	for i in range(0, level):
		var ball : Area2D = projectile.instantiate()
		ball.collision_layer = 0
		ball.collision_mask = 0
		ball.set_collision_mask_value(Data.LAYERS_MAP[target], true)
		ball.area_entered.connect(Callable(self, "Hit"))
		self.add_child(ball)
		var offset = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * radius
		ball.position = offset
	
