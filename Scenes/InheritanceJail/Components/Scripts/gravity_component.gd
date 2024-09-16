extends BaseComponent
class_name GravityComponent

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if parent.is_on_floor():
		parent.velocity.y = min(parent.velocity.y, gravity)
	else:
		parent.velocity.y += gravity * delta
