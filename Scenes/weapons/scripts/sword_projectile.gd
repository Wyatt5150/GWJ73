extends Projectile
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

func _physics_process(delta: float) -> void:
	if not active:
		return
	self.position.x += speed * direction * delta
