extends BaseComponent
class_name HorizontalMovementComponent

@export var speed : float = 300.0
@export var speed_variance : bool = false

var variance = randf_range(0.8, 1.2)

func ready():
	if speed_variance:
		speed *= variance

func _Action(_args):
	
	if parent.direction:
		parent.velocity.x = parent.direction * speed
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, speed)
