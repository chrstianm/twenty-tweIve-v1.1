extends Control

func _ready() -> void:
	CursorManager.set_normal()
	await get_tree().create_timer(0.5).timeout
	AudioManager.play_sfx("psst")


func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				CursorManager.set_normal()
				AudioManager.play_sfx("click")
				get_tree().change_scene_to_file("res://Scenes/Game/f_012_01.tscn")
