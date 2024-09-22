extends Node2D

@export var spawns : Array[PackedScene]
@export var targeter : TargetingComponent
@export var ignore_spawn_cap : bool = false

@onready var spawncap = Data.SPAWNCAP

@export var spawn_time : float = 3.0

func _ready() -> void:
	%SpawnTimer.wait_time = spawn_time
	%SpawnTimer.start()
	if len(spawns) < 1:
		queue_free()

func Spawn():
	if not ignore_spawn_cap and spawncap <= get_tree().get_node_count_in_group("Enemy"):
		return
	
	if targeter.FindTarget():
		return
	
	var enemy = spawns.pick_random().instantiate()
	self.add_child(enemy)
	enemy.set_deferred("visible", true)
	
