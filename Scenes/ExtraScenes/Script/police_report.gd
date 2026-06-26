extends Control

func _ready() -> void:
	AudioManager.play_sfx("pick_up")
	await get_tree().create_timer(0.3).timeout
	AudioManager.play_sfx("testimony")
	await get_tree().create_timer(12).timeout
	get_tree().change_scene_to_file("res://Scenes/ExtraScenes/police_report2.tscn")
