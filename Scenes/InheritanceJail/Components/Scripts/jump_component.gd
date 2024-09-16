extends BaseComponent
class_name JumpComponent

@export_range(0.0, 1.0) var jumpBufferTime : float = 0.2
@export_range(0.0, 1.0) var coyoteTime : float = 0.2
@export var jumpVelocity : float = -1000.0

var timeOffFloor = 0.0
var jumpBuffer = 0.0
var jumpLock = false

func _Action(_args):
	
	if timeOffFloor > coyoteTime: 
		jumpLock = true
	
	if jumpLock:
		jumpBuffer = jumpBufferTime
		return

	parent.velocity.y = jumpVelocity
	jumpLock = true


func _process(delta):
	jumpBuffer -= delta
	
	if parent.is_on_floor():
		timeOffFloor = 0.0
		jumpLock = false
		if jumpBuffer > 0.0:
			_Action(delta)
	else:
		timeOffFloor += delta
	
