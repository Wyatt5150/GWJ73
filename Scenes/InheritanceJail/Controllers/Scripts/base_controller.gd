extends Node2D
class_name BaseController

@export var parent_override : Node2D

@onready var parent : Node2D :
	set(new_val):
		if !is_instance_valid(new_val):
			if self.get_parent() is not Node2D:
				print("No valid parent in tree. Freeing.")
				self.queue_free()
				return
			new_val = self.get_parent()
		parent = new_val
	get():
		return parent

@warning_ignore("unused_signal")
signal fallthrough(disable : bool)
@warning_ignore("unused_signal")
signal change_direction(direction : float)
@warning_ignore("unused_signal")
signal jump()

func _ready():
	parent = parent_override
	ready()

func ready():
	pass
