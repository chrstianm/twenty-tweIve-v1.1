extends Control

@onready var start_game = $SubViewport/SubViewport/Button
@onready var window = $SubViewport/SubViewport/HackManager

func _ready() -> void:
	window.hide()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	AudioManager.play_bgm("ambiance_extreme")
	CursorManager.set_normal()
	if GlobalManager.is_ending_triggered == false:
		start_game.show()
	elif GlobalManager.is_ending_triggered == true:
		start_game.hide()


func _on_button_pressed() -> void:
	AudioManager.play_sfx("click")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Intoduction_Clip/game_select.tscn")

func _on_button_2_pressed() -> void:
	window.start_hack()
	AudioManager.play_sfx("click")
#	get_tree().quit()
