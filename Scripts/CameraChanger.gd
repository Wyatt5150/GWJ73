extends InteractionArea

@export var camera : PhantomCamera2D = null

func Activate_Event(_area = null):
	camera.set_priority(3)

func Deactivate_Event(_area = null):
	camera.set_priority(1)
