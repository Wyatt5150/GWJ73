extends Node2D
class_name Motion2D

"""META OPTIONS"""
@onready var parent = get_parent()
@export var parent_override : CharacterBody2D

"""GRAVITY AND GRAVITY ACCESSORIES"""
@export_category("GRAVITY")
@export var gravity_enabled : bool = true : 
	set(new_val):
		parent.velocity.y = min(parent.velocity.y, gravity)
		gravity_enabled = new_val
@export var gravity_direction : Vector2 = Vector2(0, 1) :
	set(new_val):
		gravity_direction = new_val.normalized()
@export var gravity_strength_modifier : float = 1.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


"""HORIZONTAL MOVEMENT OPTIONS"""
@export_category("MOVEMENT")
@export var horizontal_motion_enabled : bool = true
@export var speed : float = 300.0
@export_range(0.0, 0.99) var variance_strength : float = 0.0

var horizontal_direction : float = 0.0
var variance : float = 1.0


"""ANIMATION SIGNALS"""
signal set_animation(animation : String)


"""SIGNAL RECIEVERS"""
func ChangeHorizontalDirection(_direction : float) -> void:
	horizontal_direction = _direction

func Fallthrough(disable : bool) -> void:
	parent.set_collision_mask_value(Data.LAYERS.FALLTHROUGH, disable)

"""PRIVATE FUNCTIONS AND PROCESS LOOP"""
func _ready():
	if parent_override:
		parent = parent_override
	speed = speed * randf_range(1.0-variance_strength, 1.0+variance_strength)
	
	set_animation.emit("Idle")

func _process(_delta: float) -> void:
	if parent.is_on_floor():
		if horizontal_direction:
			set_animation.emit("Moving")
		else:
			set_animation.emit("Idle")

func _physics_process(delta: float) -> void:
	if not is_instance_valid(parent): return
	if gravity_enabled: _ApplyGravity(delta)
	if horizontal_motion_enabled: _ApplyHorizontalMotion(delta)
	
	parent.move_and_slide()

func _ApplyGravity(delta : float) -> void:
	if parent.is_on_floor():
		parent.velocity.y = min(parent.velocity.y, gravity)
	else:
		parent.velocity += gravity_direction * gravity * delta * gravity_strength_modifier

func _ApplyHorizontalMotion(_delta : float) -> void:
	if horizontal_direction:
		parent.velocity.x = horizontal_direction * speed
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, speed)
