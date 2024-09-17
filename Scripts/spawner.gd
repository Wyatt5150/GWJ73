extends Node2D

@export var spawns : Array[PackedScene]
@export var targeter : TargetingComponent

@onready var spawncap = Data.SPAWNCAP

func _ready() -> void:
	if len(spawns) < 1:
		queue_free()

func Spawn():
	if spawncap <= get_tree().get_node_count_in_group("Enemy"):
		return
	
	if targeter.FindTarget():
		return
	var enemy = spawns.pick_random().instantiate()
	get_tree().root.add_child(enemy)
	enemy.global_position = self.global_position
	enemy.set_deferred("visible", true)
	
