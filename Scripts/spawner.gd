extends Node2D
class_name BaseSpawner

@export var spawns : Array[PackedScene]
@export var targeter : TargetingComponent
@export var ignore_spawn_cap : bool = false
@export var spawning : bool = false :
	set(new_val):
		spawning = new_val
		_SpawnLoop()

@export var ignore_player : bool = false

@onready var spawncap = Data.SPAWNCAP
@export var spawn_time : float = 3.0

func _ready() -> void:
	if len(spawns) < 1:
		queue_free()
	_SpawnLoop()

func _SpawnLoop() -> void:
	if not CanSpawn():
		return
	
	Spawn()
	await get_tree().create_timer(spawn_time).timeout
	_SpawnLoop()

func CanSpawn() -> bool:
	if not spawning:
		return false
	
	if not ignore_spawn_cap and spawncap <= get_tree().get_node_count_in_group("Enemy"):
		return false
	
	if not ignore_player and targeter.TargetInArea():
		return false
	
	return true

func Spawn():
	var enemy = spawns.pick_random().instantiate()
	self.add_child(enemy)
	enemy.set_deferred("visible", true)
	
