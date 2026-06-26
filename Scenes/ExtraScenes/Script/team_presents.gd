extends Control

func _ready() -> void:
	await get_tree().create_timer(3.0).timeout
	SceneChanger.change_scene("res://Scenes/ExtraScenes/main_menu.tscn")
