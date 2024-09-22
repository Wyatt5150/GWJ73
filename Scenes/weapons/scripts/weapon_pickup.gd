extends InteractionArea
class_name WeaponPickup

@export var type : WeaponData.WEAPONS
@export var pick_random : bool = true
@export var base_cost : int = 5
@export var cost_override : int = -1

var cost : int = 0 :
	set(new_val):
		%Cost.text = str(new_val) + " Souls"
		cost = new_val
var weapon_data : WeaponData.Weapon

func ready() -> void:
	if pick_random:
		type = WeaponData.Get_Random()
	if cost_override >= 0:
		cost = cost_override
	else:
		cost = base_cost * (1.5 ** (Data.current_floor))
	
	weapon_data = WeaponData.Get_Weapon(type)
	
	%WeaponIcon.texture = weapon_data.Get_Icon()


func Activate_Event(_area = null):
	%CostPanel.show()

func Deactivate_Event(_area = null):
	%CostPanel.hide()

func Interact():
	if Data.souls < cost:
		# TODO Play some sound when poor
		return
	Data.souls -= cost
	weapon_data.Upgrade()
	interacted.emit()
	self.queue_free()
