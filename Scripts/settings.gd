extends Control

func _ready() -> void:
	%SettingsBox.hide()

func _on_button_pressed() -> void:
	if %SettingsBox.visible:
		%SettingsBox.hide()
	else:
		%SettingsBox.show()
