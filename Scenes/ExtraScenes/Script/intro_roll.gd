extends Control

func _ready() -> void:
	await get_tree().create_timer(4.0).timeout
	SceneChanger.change_scene("res://team_presents.tscn")
