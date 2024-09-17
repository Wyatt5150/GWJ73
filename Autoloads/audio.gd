extends Node

@onready var music = $Music

enum MUSIC_TRACKS {}
enum SFX_TRACKS {
	VINE_BOOM
}

const _MUSIC_PATHS = {
}

const _SFX_PATHS = {
	SFX_TRACKS.VINE_BOOM : "res://NotMine/vine-boom.mp3"
}

var _currentMusic = null

func ChangeMusic(track:MUSIC_TRACKS) -> void:
	if _currentMusic == track: return
	music.stream = load(_MUSIC_PATHS[track])
	music.play()
	_currentMusic = track

func PlaySFXGlobal(track:SFX_TRACKS) -> void:
	var sfx = AudioStreamPlayer.new()
	add_child(sfx)
	_PlaySFX(sfx, track)

func PlaySFXLocal(track:SFX_TRACKS, node:Node2D) -> void:
	var sfx = AudioStreamPlayer2D.new()
	node.add_child(sfx)
	_PlaySFX(sfx, track)

func _PlaySFX(sfx, track:SFX_TRACKS) -> void:
	if sfx is not AudioStreamPlayer and sfx is not AudioStreamPlayer2D:
		return
	
	sfx.stream = load(_SFX_PATHS[track])
	sfx.set_bus("SFX")
	
	var pitch = 1.0
	pitch = pitch + randf_range(-.05, 0.05)
	sfx.pitch_scale = pitch
	sfx.finished.connect(Callable(sfx, "queue_free"))
	sfx.play()

func ChangeVolume(percent:float, bus:StringName) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear_to_db(percent/100))
