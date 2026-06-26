extends Area2D



func _on_mouse_entered() -> void:
	CursorManager.set_back()
func _on_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				CursorManager.set_normal()
				AudioManager.play_sfx("click")
				get_tree().change_scene_to_file("res://Scenes/Game/F001_01.tscn")
