extends Area2D
class_name TargetingComponent

var targets : Array[Area2D] = [
	
]

@export var detecting_type : Array[Data.LAYERS] = []
@export var radius : int = 5

func _ready() -> void:
	Data._set_masks(self, detecting_type)
	_PulseTargets()
	scale *= radius

func GetRandomTarget() -> Area2D:
	if not TargetInArea():
		return null
	return targets.pick_random()

func GetClosest() -> Area2D:
	var location = self.global_position
	if not TargetInArea():
		return null
	
	var guess : Area2D = targets[0]
	var guess_distance : float = guess.global_position.distance_to(location)
	for target : Area2D in targets:
		var target_distance = target.global_position.distance_to(location)
		if target_distance < guess_distance:
			guess = target
			guess_distance = target_distance
	
	return guess

func GetFarthest() -> Area2D:
	var location = self.global_position
	if not TargetInArea():
		return null
	
	var guess : Area2D = targets[0]
	var guess_distance : float = guess.global_position.distance_to(location)
	for target : Area2D in targets:
		var target_distance = target.global_position.distance_to(location)
		if target_distance > guess_distance:
			guess = target
			guess_distance = target_distance
	
	return guess

func TargetInArea() -> bool:
	return len(targets) > 0

# Run get overlapping areas to confirm targeting list is still accurate
func _PulseTargets() -> void:
	targets = get_overlapping_areas()

func _TargetEntered(_area : Area2D) -> void:
	targets.append(_area)

func _TargetExited(_area : Area2D) -> void:
	targets.erase(_area)
