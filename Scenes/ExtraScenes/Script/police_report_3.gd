extends Control

func _ready() -> void:
	await get_tree().create_timer(12).timeout
	get_tree().change_scene_to_file("res://Scenes/Intoduction_Clip/title.tscn")
