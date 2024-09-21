extends Area2D
class_name InteractionArea

@export var always_active : bool = false
@export var active : bool = true : 
	set(new_val):
		if always_active:
			active = true
		else:
			active = new_val
signal interacted

"""INTERFACES"""
func Activate_Event(_area = null):
	pass

func Deactivate_Event(_area = null):
	pass

func Interact():
	pass

func ready():
	pass

"""DO NOT OVERIDE"""
func _ready():
	self.collision_layer = 0
	self.collision_mask = 0
	self.set_collision_mask_value(Data.LAYERS_MAP[Data.LAYERS.PLAYER], true)
	self.area_entered.connect(Callable(self, "_Activate"))
	self.area_exited.connect(Callable(self, "_Deactivate"))
	
	var shape = get_node_or_null("CollisionShape2D")
	if shape == null:
		printerr(self, " Has no collission shape. Freeeeing.")
		self.queue_free()
		
	if active: _Activate()
	else: _Deactivate()
	ready()

func _input(event: InputEvent) -> void:
	if not active:
		return
	if event.is_action_pressed("Interact"):
		Interact()
		interacted.emit()

func _Activate(_area = null) -> void:
	active = true
	if not self.is_queued_for_deletion():
		Activate_Event(_area)

func _Deactivate(_area = null) -> void:
	active = false
	if not self.is_queued_for_deletion():
		Deactivate_Event(_area)
