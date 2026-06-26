extends Node2D

func _ready() -> void:
	AudioManager.stop_all_bgm()
#	AudioManager.play_sfx("scream")
	await get_tree().create_timer(0.3).timeout
	
	if GlobalManager.is_load_game == true:
		GlobalManager.is_load_game = false
		get_tree().quit()
	else:
		get_tree().change_scene_to_file("res://Scenes/Game/F001_01.tscn")
