extends BaseController
class_name PlayerController

func _physics_process(delta):
	parent.direction = Input.get_axis("Left", "Right")

	Do_Action("Movement", [delta])
	
	if Input.is_action_just_pressed("Up"):
		Do_Action("Jump", [delta])
	
	if Input.is_action_just_pressed("Down"):
		Do_Action("Fallthrough", [false])
	if Input.is_action_just_released("Down"):
		Do_Action("Fallthrough", [true])
	
	if Input.is_action_just_pressed("Dash"):
		Do_Action("Dash", [delta])
	
	parent.move_and_slide()
