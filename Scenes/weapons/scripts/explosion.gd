extends CharacterBody2D
class_name Explosion

"""ExplosionOptions"""
@export var explosion_time : float = 1.0
@export var flash_time : float = 0.5

var damaging = false

signal hit(victim : Area2D)

func _ready() -> void:
	%Flash.hide()
	%SplodeyTimer.start(explosion_time)

func Explode():
	var victims = %Explosion.get_overlapping_areas()
	
	damaging = true
	
	for victim in victims:
		hit.emit(victim)
	
	%Flash.show()
	
	await get_tree().create_timer(flash_time).timeout
	
	self.queue_free()

func _on_explosion_area_entered(area: Area2D) -> void:
	if damaging:
		hit.emit(area)
