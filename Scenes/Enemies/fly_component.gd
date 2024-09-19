extends Node2D
class_name FlyComponent

"""META OPTIONS"""
@onready var parent = get_parent()
@export var parent_override : CharacterBody2D

"""HORIZONTAL MOVEMENT OPTIONS"""
@export_category("MOVEMENT")
@export var speed : float = 300.0
@export_range(0.0, 0.99) var variance_strength : float = 0.0

var vertical_direction : float = 0.0
var variance : float = 1.0


"""ANIMATION SIGNALS"""
signal set_animation(animation : String)


"""SIGNAL RECIEVERS"""
func ChangeDirection(_direction : float) -> void:
	vertical_direction = _direction

func Fallthrough(disable : bool) -> void:
	parent.set_collision_mask_value(Data.LAYERS_MAP[Data.LAYERS.FALLTHROUGH], disable)

"""PRIVATE FUNCTIONS AND PROCESS LOOP"""
func _ready():
	if parent_override:
		parent = parent_override
	speed = speed * randf_range(1.0-variance_strength, 1.0+variance_strength)

func _physics_process(delta: float) -> void:
	if not is_instance_valid(parent): return
	_ApplyVerticalMotion(delta)
	
	parent.move_and_slide()

func _ApplyVerticalMotion(_delta : float) -> void:
	if vertical_direction:
		parent.velocity.x = vertical_direction * speed
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, speed)
