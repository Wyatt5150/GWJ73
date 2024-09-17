extends BaseController
class_name PlayerController



func _physics_process(_delta):
	change_direction.emit(Input.get_axis("Left", "Right"))
	
	if Input.is_action_just_pressed("Up"):
		jump.emit()
	
	if Input.is_action_just_pressed("Down"):
		fallthrough.emit(false)
	if Input.is_action_just_released("Down"):
		fallthrough.emit(true)
	
