extends InteractionArea
class_name Portal

@export var portal_charging_text : String = "Portal Charging \nPlease Wait":
	set(new_val):
		%ChargingText.text = new_val
		portal_charging_text = new_val

@export var interact_text : String = "Press 'E'":
	set(new_val):
		%ChargingText.text = new_val
		interact_text = new_val

@export var open : bool = false : 
	set(new_val):
		if new_val == true:
			%ChargingText.hide()
			%InteractPrompt.show()
		else:
			%InteractPrompt.hide()
			%ChargingText.show()
		open = new_val

func Open(val : bool):
	open = val

func Activate_Event(_area = null):
	%TextDisplay.show()

func Deactivate_Event(_area = null):
	%TextDisplay.hide()

func Interact():
	if not open:
		return
	
	Data.Transition()
