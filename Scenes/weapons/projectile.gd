extends Area2D
class_name Projectile

@export var damage : int = 1
@export var lifespan : float = 4.0
@export var pierce : int = -1
var active = false
var times_hit = 0

func Fire():
	pass

"""DONT OVERIDE UNLESS NECESSARY"""
func _ready() -> void:
	self.area_entered.connect(Callable(self, "Hit"))
	Data.clear_projectiles.connect(self.queue_free)
	self.hide()

func _SetLayers(targets) -> void:
	self.collision_layer = 0
	self.collision_mask = 0
	for target in targets:
		self.set_collision_mask_value(Data.LAYERS_MAP[target], true)

func _Fire() -> void:
	active = true
	self.show()
	Fire()
	if lifespan > 0:
		await get_tree().create_timer(lifespan).timeout
		self.queue_free()

func Hit(_area : Area2D):
	times_hit += 1
	
	if pierce != -1:
		if times_hit > pierce:
			self.queue_free()
	
	if _area is HurtboxComponent:
		_area.Damage(damage)
