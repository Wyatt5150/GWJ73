extends BaseComponent

func _Action(_args):
	parent.set_collision_mask_value(2, _args[0])
