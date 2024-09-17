extends BaseController
class_name EnemyController

@export var tracking_update_interval : float = 0.5
@export var stutter : float = 50.0

@export var x_offset : float = 50
@export var y_offset : float = 30

var tracking_update_stutter : float = randf_range(0.0, 0.20)
var target : Vector2



func ready():
	$Timer.wait_time = tracking_update_interval + tracking_update_stutter
	#$Timer.start()

func _physics_process(delta: float) -> void:
	if not target:
		return
	
	if parent.global_position.x < target.x - x_offset:
		change_direction.emit(1.0)
	elif parent.global_position.x > target.x + x_offset:
		change_direction.emit(-1.0)
	else:
		change_direction.emit(0.0)
	
	if parent.global_position.y > target.y + y_offset:
		jump.emit()
	
	if parent.global_position.y < target.y - y_offset:
		fallthrough.emit(false)
	else:
		fallthrough.emit(true)
	
	parent.move_and_slide()

#func UpdateTrackingPosition():
	##if !is_instance_valid(parent.tracking):
		##Do_Action("Target", [])
		##target = parent.global_position - Vector2(0, 50)
		##return
	#
	#target = parent.tracking.global_position
	#target.x += randf_range(-stutter, stutter)
