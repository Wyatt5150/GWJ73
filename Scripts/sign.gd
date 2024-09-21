extends InteractionArea
class_name Sign

@export var sign_text_1 : String = "This Is A Sign" :
	set(new_val):
		%Text.text = new_val
		sign_text_1 = new_val
@export var sign_text_2 : String = "With Two Lines" :
	set(new_val):
		%Text2.text = new_val
		sign_text_2 = new_val

"""INTERFACES"""
func Activate_Event(_area = null):
	%Panel.show()

func Deactivate_Event(_area = null):
	%Panel.hide()
