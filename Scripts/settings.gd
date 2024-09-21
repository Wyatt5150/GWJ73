extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%SettingsBox.hide()


func _on_button_pressed() -> void:
	if %SettingsBox.visible:
		%SettingsBox.hide()
	else:
		%SettingsBox.show()
