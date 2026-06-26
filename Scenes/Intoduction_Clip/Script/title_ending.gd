extends Control

func _ready() -> void:
	InventoryUi.hide()
	await get_tree().create_timer(14).timeout
	AudioManager.stop_all_bgm()
	get_tree().change_scene_to_file("res://Scenes/ExtraScenes/main_menu.tscn")
