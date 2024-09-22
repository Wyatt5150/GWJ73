extends Area2D
class_name SwordProjectile

var direction = 1.0 :
	set(new_val):
		if new_val < 0:
			%Sprite.flip_h = true
			direction = -1.0
		else:
			%Sprite.flip_h = false
			direction = 1.0
var speed = 600.0

var pierce = 3
var hits = 1

func _physics_process(delta: float) -> void:
	self.position.x += speed * direction * delta

func _on_area_entered(area: Area2D) -> void:
	hits += 1
	if hits > pierce:
		self.queue_free()
