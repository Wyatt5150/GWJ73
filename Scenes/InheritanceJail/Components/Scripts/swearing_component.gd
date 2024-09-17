extends BaseComponent
class_name SwearingComponent

@export var sound_effects : Array[Audio.SFX_TRACKS]

func _Action(_args):
	if len(sound_effects) < 1:
		return
	Audio.PlaySFXLocal(sound_effects.pick_random(), parent)
