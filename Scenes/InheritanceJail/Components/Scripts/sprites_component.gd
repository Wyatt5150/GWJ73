extends AnimatedSprite2D

@export var default : String = "Idle"
var queued : Array = []

func _ready() -> void:
	if not self.sprite_frames.has_animation(default):
		printerr("Invalid default animation set. Freeing")
		self.queue_free()
		return
	
	SetAnimation(default)

func ChangeDirection(direction : float) -> void:
	if direction > 0.0:
		flip_h = false
	elif direction < 0.0:
		flip_h = true


func SetAnimation(_animation : String) -> void:
	"""
	Updates Animation Immediately.
	"""
	
	if not self.sprite_frames.has_animation(_animation):
		return
	if _animation == animation:
		return
	
	self.play(_animation)
	

	
