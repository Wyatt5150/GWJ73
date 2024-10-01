extends Control

var fact_list : Array = [
	"There is at least 1 species of banana slugs found in the State of California.",
	"Godot is not a cult.",
	"Your name is Steven.",
	"Steven is wanted in over 64 countries.",
	"These facts are completely hardcoded.",
	"Flamingos can drink boiling water.",
	"Frogs can see stars that we can't.",
	"The game NGU Idle 2 will be released on October 15th 2024 at 5:38.28 PM.",
	"You can eat anything, once.",
	"Frogs swallow with their eyes.",
	"There are only 26 physical Wii U exclusive games.",
	"'Consciousness is a prank from within.' - AI Quotes",
	"'Bears are just XXXL dogs' - Casual Geographic",
	"The primary background color I use is #696969. Funny, right?"
]

var fact_list_dead : Array = [
	"Your computer does not need System32 to function.",
	"Your IP address is 127.0.0.1.",
	"Your home is very secure... \nOr is it?",
	"You cannot outrun a bear."
]

var fact : String
var can_continue = false

func _ready() -> void:
	if Data.current_floor == 0:
		%TitleText.text = "FUN FACT! YOU DIED EDITION!"
		fact = fact_list_dead.pick_random()
	else:
		%TitleText.text = "FUN FACT!"
		fact = fact_list.pick_random()
	%FactText.text = fact

func _unhandled_input(_event: InputEvent) -> void:
	if can_continue:
		Data.StartLevel()

func _on_timer_timeout() -> void:
	can_continue = true
