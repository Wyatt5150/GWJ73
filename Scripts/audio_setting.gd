extends Panel

@export var bus : String = "Master"
@export_range(0, 100) var volume : int = 50 : 
	set(new_val):
		new_val = clampi(new_val, 0, 100)
		Audio.ChangeVolume(new_val, bus)
		if get_node_or_null("HSlider"):
			$HSlider.value = new_val
		volume = new_val

func _ready() -> void:
	volume = volume

func _on_h_slider_value_changed(value: float) -> void:
	volume = int(value)
