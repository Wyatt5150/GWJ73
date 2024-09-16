extends CharacterBody2D

var commands : Dictionary = {
}

var direction : float = 0.0
var tracking : Node2D

func _ready():
	for node in get_children():
		if node is BaseComponent:
			commands[node.action_name] = Callable(node, "_Action")
