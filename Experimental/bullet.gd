extends CharacterBody2D
class_name Bullet

"""SPEEEEEEED"""
@export_category("Speed")
@export var initial_speed : float = 0.0
@export var target_speed : float = 0.0
@export var acceleration : float = 1.0
@onready var speed : float = initial_speed
var direction : Vector2 = Vector2.ZERO

"""STATS"""
@export_category("Stats")
@export var damage : float = 1.0
@export var lifespan : float = 3.0

"""COLLISION"""
@export_category("Collision")
@export var pierce : int = 0
@export var target_type : Array[Data.LAYERS] = [Data.LAYERS.ENEMY]
@export var hitbox : Area2D
@export var destroy_immediate : Array[Data.LAYERS] = [Data.LAYERS.IMPASSABLE]


var is_ready : bool = false

var hits = 0


func _ready() -> void:
	Data._set_masks(self, destroy_immediate)
	if hitbox:
		Data._set_masks(hitbox, target_type)
		hitbox.area_entered.connect(_area_entered)
	
	await _startup_action()
	is_ready = true
	
	await get_tree().create_timer(lifespan).timeout
	
	_handle_despawn()

func _physics_process(delta: float) -> void:
	if not is_ready:
		return
	speed = lerp(speed, target_speed, acceleration * delta)
	velocity = speed * direction * delta
	
	print(speed)
	
	var collision = move_and_collide(velocity)
	if collision:
		_area_entered(collision)

func _startup_action() -> void:
	pass

func _despawn_action() -> void:
	pass

func _handle_despawn():
	Data._set_masks(self, [])
	await _despawn_action()
	self.queue_free()

func _area_entered(collision):
	if not collision is Hurtbox:
		_handle_despawn()
		return
	
	collision.Damage(damage)
	hits += 1
	
	if pierce > -1 and hits > pierce:
		_handle_despawn()
