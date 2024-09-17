extends Area2D

var active : bool = false

func _ready():
	Deactivate()

func _unhandled_input(event: InputEvent) -> void:
	if not active:
		return
	if event.is_action_pressed("Interact"):
		print("Works")

func Activate(_area = null) -> void:
	active = true
	%InteractPrompt.show()

func Deactivate(_area = null) -> void:
	active = false
	%InteractPrompt.hide()
