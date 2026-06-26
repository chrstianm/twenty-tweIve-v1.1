extends Control

func _ready() -> void:
	AudioManager.stop_all_bgm()
	AudioManager.play_bgm("bsod")
	await get_tree().create_timer(5.0).timeout
	GlobalManager.is_load_game = true
	get_tree().change_scene_to_file("res://Scenes/ExtraScenes/Entity.tscn")
