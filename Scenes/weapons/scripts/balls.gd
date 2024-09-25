extends WeaponBase
class_name Balls

@export var cumulative_damage_multiplier : float = 1.2
@export var merge_threshold : int = 5
@export var radius : float = 60.0
var rot_speed : float = 0

var tier_colors : Array[Color] = []

func _physics_process(delta: float) -> void:
	self.rotate(rot_speed * delta)

func Upgrade(level : int):
	rot_speed = 1.0 + log(level+1)
	
	for child in get_children():
		child.queue_free()
	
	var balls : Array = GenerateBalls(level)
	for i in range(0, len(balls)):
		CreateBall(balls[i], deg_to_rad(float(i) * 360.0/float(len(balls))))

func GenerateBalls(total : int) -> Array:
	var balls : Array = []
	var tier = 0
	
	while total > 0:
		var num_in_tier : int = total % merge_threshold
		for i in range(0, num_in_tier):
			balls.append(tier)
		total = int(total / merge_threshold)
		tier += 1
	
	return balls

func CreateBall(tier : int, radians : float) -> void:
	var _projectile : Projectile = projectile.instantiate()
	_projectile._SetLayers(target_type)
	self.add_child(_projectile)
	_projectile.damage = damage * ((merge_threshold * cumulative_damage_multiplier) ** tier)
	_projectile.modulate = GetTierColor(tier)
	
	var offset = Vector2(sin(radians), cos(radians)).normalized()
	_projectile.position = offset * radius
	_projectile._Fire()

func GetTierColor(tier : int) -> Color:
	while len(tier_colors) < tier+1:
		var color : float = 1.0 - (1.0 / (float(len(tier_colors)+1)))
		tier_colors.append(Color(color, color, 1.0))
	
	return tier_colors[tier]
