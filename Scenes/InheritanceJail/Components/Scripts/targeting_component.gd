extends Area2D
class_name TargetingComponent

enum MODE {
	CLOSEST,
	FARTHEST,
	RANDOM
}

@export var target_type : Array[Data.LAYERS] = [Data.LAYERS.PLAYER]
@export var targeting_mode : MODE = MODE.RANDOM
@export var radius : int = 20

func _ready():
	for type in target_type:
		set_collision_mask_value(Data.LAYERS_MAP[type], true)
	scale *= radius

func FindTarget() -> Node2D:
	var areas : Array = get_overlapping_areas()
	var location = self.global_position
	
	var target = areas.pop_back()
	if !target:
		return null
	
	var distance = target.global_position.distance_to(location)
	
	match targeting_mode:
		MODE.CLOSEST:
			for area in areas:
				var predicate = area.global_position.distance_to(location)
				if predicate < distance:
					distance = predicate
					target = area
		MODE.FARTHEST:
			for area in areas:
				var predicate = area.global_position.distance_to(location)
				if predicate > distance:
					distance = predicate
					target = area
		MODE.RANDOM:
			areas.push_back(target)
			target = areas.pick_random()
	
	return target
