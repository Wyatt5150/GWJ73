extends Node2D
class_name JumpComponent

"""META OPTIONS"""
@onready var parent = get_parent()
@export var parent_override : CharacterBody2D

"""JUMPING OPTIONS"""
@export_category("JUMPING")
@export var number_of_jumps : int = 1:
	set(new_val):
		number_of_jumps = max(new_val, 0)
@export_range(0.0, 0.5) var jump_buffer_time : float = 0.2
@export_range(0.0, 0.5) var coyote_time : float = 0.2
@export_range(0.0, 3.0) var landing_lag_time : float = 0.1
@export var jump_velocity : float = -1000.0
@export_range(0.5, 3.0) var subsequent_jump_strength : float = 1.2

var time_off_floor : float = 0.0
var jump_buffer : float = 0.0
var landing_lag : float = 0.0
var coyote_used : bool = false
var jumps = 0

"""ANIMATION SIGNALS"""
signal set_animation(animation : String)

"""SIGNAL RECIEVERS"""
func Jump() -> void:
	if not _CanJump(): 
		jump_buffer = jump_buffer_time
		return
	
	var jump_strength = jump_velocity
	if jumps < number_of_jumps:
		jump_strength *= subsequent_jump_strength
		
	set_animation.emit("Jump")
	coyote_used = true
	parent.velocity.y = jump_strength
	jumps -= 1

"""PRIVATE FUNCTIONS AND PROCESS LOOP"""
func _ready() -> void:
	_Land()
	

func _process(delta: float) -> void:
	# Jumping Timers
	jump_buffer -= delta
	landing_lag -= delta
	if parent.is_on_floor():
		if time_off_floor > 0.0:
			_Land()
	else:
		if parent.velocity.y > 0.0:
			set_animation.emit("Fall")
		time_off_floor += delta
		if not coyote_used and time_off_floor > coyote_time :
			coyote_used = true
			jumps -= 1

func _physics_process(_delta: float) -> void:
	if parent.is_on_floor() and jump_buffer > 0.0: Jump()

func _Land():
	time_off_floor = 0.0
	jumps = number_of_jumps
	landing_lag = landing_lag_time
	coyote_used = false
	set_animation.emit("Land")

func _CanJump() -> bool:
	if jumps < 1:
		return false
	if landing_lag > 0.0:
		return false
	
	return true
