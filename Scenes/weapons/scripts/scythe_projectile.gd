extends Projectile
class_name ScytheProjectile

var direction = Vector2(1, 0)
var speed = 500.0
var rot_speed = 20

enum STATES {
	RISING,
	FIRING
}
var state = STATES.RISING

func _physics_process(delta: float) -> void:
	if not active:
		return
	rotate(rot_speed * delta)
	if state == STATES.FIRING:
		self.position += speed * direction * delta

func Fire():
	var target = %TargetingComponent.GetRandomTarget()
	if not is_instance_valid(target):
		await %TargetingComponent.area_entered
		target = %TargetingComponent.GetRandomTarget()
	
	direction = self.global_position.direction_to(target.global_position)
	
	await get_tree().create_timer(0.2).timeout
	
	state = STATES.FIRING
	direction = direction.normalized()
