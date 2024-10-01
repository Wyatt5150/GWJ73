extends Area2D
class_name Hurtbox

"""META OPTIONS"""
@onready var parent = get_parent()
@export var parent_override : CharacterBody2D
@export var type : Data.LAYERS = Data.LAYERS.ENEMY

"""BASE HEALTH OPTIONS"""
@export_category("HEALTH")
@export var max_health : int = 10
var current_health : int = max_health :
	set(new_val):
		if killable and new_val <= 0:
			DeathHandler()
		current_health = clampi(new_val, 0, max_health)

@export var killable : bool = true
var invincibility = 0.0
@export var iframes = 0.0

@export var soul_value : int = 1
@export var damage_flash : bool = true

func _ready() -> void:
	current_health = max_health
	
	Data._set_layers(self, [type])

func _process(delta: float) -> void:
	invincibility -= delta

func Damage(ammount : int):
	if invincibility > 0.0:
		return
	if type == Data.LAYERS.PLAYER:
		Audio.PlaySFXLocal(Audio.SFX_TRACKS.HURT, self)
		invincibility = iframes
		Data.souls -= ammount
		if Data.souls < 0:
			Data.souls = 0
			DeathHandler()
	else:
		current_health -= ammount
	if damage_flash:
		parent.modulate = Color(1.0, 0.0, 0.0)
		await get_tree().create_timer(0.2).timeout
		parent.modulate = Color(1.0, 1.0, 1.0)

func DeathHandler() -> void:
	match type:
		Data.LAYERS.ENEMY:
			Data.souls += soul_value
			parent.queue_free()
		Data.LAYERS.PLAYER:
			Data.Transition(Data.STATE.LOSE)
			Audio.StopMusic()
			Audio.PlaySFXGlobal(Audio.SFX_TRACKS.DEATH)
		_:
			parent.queue_free()
	
