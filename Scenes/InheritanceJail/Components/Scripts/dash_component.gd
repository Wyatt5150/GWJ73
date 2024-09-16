extends BaseComponent
class_name DashComponent


var isDashing = false
var canDash = false
var dashTimer = 0.0
const dashTime : float = 0.3
const speed : float= 600.0


func _Action(_args):
	if !isDashing and parent.is_on_floor(): canDash = true
	
	if !canDash: return 0
	
	parent.velocity.x += (speed * parent.direction)
	
	dashTimer = dashTime
	isDashing = true
	canDash = false

func _physics_process(delta):
	dashTimer -= delta
	if dashTimer < 0.0: isDashing = false
