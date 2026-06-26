extends Control

@onready var glitchy_overlay = $GlitchLayer/ColorRect2
func _ready() -> void:
	AudioManager.play_bgm("vhs_static")
	CursorManager.set_normal()
	AudioManager.play_sfx("bsod")
	glitchy_overlay.start_dynamic_glitch(10.0)
