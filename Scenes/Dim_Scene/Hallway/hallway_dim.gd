extends Control

@onready var text : RichTextLabel = $Label

func _ready() -> void:
	AudioManager.play_sfx("door-hallway")
	await get_tree().create_timer(1.3).timeout
	AudioManager.play_sfx("heavy_breath")
	text.start_fade_in(2)
