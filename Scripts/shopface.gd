extends Area2D
class_name InteractionArea

@export var prompt = "E"
var active : bool = false
signal interacted

func _ready():
	var shape = get_node_or_null("CollisionShape2D")
	if shape == null:
		printerr(self, " Has no collission shape. Freeeing.")
		self.queue_free()
	Deactivate()

func _unhandled_input(event: InputEvent) -> void:
	if not active:
		return
	if event.is_action_pressed("Interact"):
		interacted.emit()

func Activate(_area = null) -> void:
	active = true
	%InteractPrompt.show()

func Deactivate(_area = null) -> void:
	active = false
	%InteractPrompt.hide()
