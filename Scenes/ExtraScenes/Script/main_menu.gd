extends Control

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	AudioManager.play_bgm("ambiance_extreme")
	CursorManager.set_normal()


func _on_button_pressed() -> void:
	AudioManager.play_sfx("click")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Intoduction_Clip/game_select.tscn")

func _on_button_2_pressed() -> void:
	AudioManager.play_sfx("click")
	get_tree().quit()
