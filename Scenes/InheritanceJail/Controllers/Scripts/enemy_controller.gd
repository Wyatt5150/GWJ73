extends BaseController
class_name EnemyController

@export var tracking_update_interval : float = 0.5
@export var stutter : float = 50.0

@export var x_offset : float = 50
@export var y_offset : float = 30

var tracking_update_stutter : float = randf_range(0.0, 0.20)
var target : Vector2 = Vector2.ZERO

func ready():
	UpdateTrackingPosition()
	$Timer.wait_time = tracking_update_interval + tracking_update_stutter
	$Timer.start()

func _physics_process(delta: float) -> void:
	if parent.global_position.x < target.x - x_offset:
		parent.direction = 1.0
	elif parent.global_position.x > target.x + x_offset:
		parent.direction = -1.0
	else:
		parent.direction = 0.0
	
	Do_Action("Movement", [delta])
	
	
	if parent.global_position.y > target.y + y_offset:
		Do_Action("Jump", [delta])
	
	if parent.global_position.y < target.y - y_offset:
		Do_Action("Fallthrough", [false])
	else:
		Do_Action("Fallthrough", [true])
	
	parent.move_and_slide()

func UpdateTrackingPosition():
	if !is_instance_valid(parent.tracking):
		Do_Action("Target", [])
		target = self.global_position
		return
	
	target = parent.tracking.global_position
	target.x += randf_range(-stutter, stutter)
