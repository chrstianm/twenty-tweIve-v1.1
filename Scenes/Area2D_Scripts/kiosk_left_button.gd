extends TextureRect

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		AudioManager.play_sfx("click")
		get_tree().change_scene_to_file("res://Scenes/Game/F_002_01.tscn")
