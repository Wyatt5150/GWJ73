extends Bullet
class_name ScytheProjectile

@export var targeter : TargetingComponent 
var rot_speed = 720

func _startup_action() -> void:
	var target = targeter.GetRandomTarget()
	while not is_instance_valid(target):
		await get_tree().create_timer(0.1).timeout
		target = targeter.GetRandomTarget()
	
	direction = self.global_position.direction_to(target.global_position)
	
	await get_tree().create_timer(0.2).timeout

func _physics_process(delta: float) -> void:
	self.rotate(deg_to_rad(rot_speed*delta))
	super._physics_process(delta)
