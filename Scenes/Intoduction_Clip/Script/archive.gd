extends Control

func _ready() -> void:
	AudioManager.stop_bgm("ambiance_extreme")
	AudioManager.play_bgm("static")
#	AudioManager.play_bgm("vhs_static")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	CursorManager.set_normal()
