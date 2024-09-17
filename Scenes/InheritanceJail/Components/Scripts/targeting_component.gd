extends BaseComponent
class_name TargetingComponent

enum MODE {
	CLOSEST,
	FARTHEST,
	RANDOM
}

enum TARGET {
	PLAYER,
	ENEMY,
	TOWER
}

@export var target_type : Array[TARGET] = [TARGET.PLAYER]
@export var targeting_mode : MODE = MODE.RANDOM
@export var radius : int = 50

func ready():
	if TARGET.PLAYER in target_type:
		%TargetingArea.set_collision_mask_value(3, true)
	if TARGET.ENEMY in target_type:
		%TargetingArea.set_collision_mask_value(4, true)
	if TARGET.TOWER in target_type:
		%TargetingArea.set_collision_mask_value(5, true)
	%TargetingArea.scale *= radius

func _Action(_args):
	var areas = %TargetingArea.get_overlapping_bodies()
	var parent_location = parent.global_position
	
	if len(areas) < 1:
		parent.tracking = null
		return
	
	var target = areas[0]
	var distance = target.global_position.distance_to(parent_location)
	
	if len(areas) == 1:
		parent.tracking = target
		return
	
	match targeting_mode:
		MODE.CLOSEST:
			for area in areas:
				var predicate = area.global_position.distance_to(parent_location)
				if predicate < distance:
					distance = predicate
					target = area
		MODE.FARTHEST:
			for area in areas:
				var predicate = area.global_position.distance_to(parent_location)
				if predicate > distance:
					distance = predicate
					target = area
		MODE.RANDOM:
			target = areas[randi()%len(areas)]
	
	parent.tracking = target
