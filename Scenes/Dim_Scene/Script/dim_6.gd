extends Control

@onready var area : Area2D = $Forward
func _ready() -> void:
	CursorManager.set_normal()

func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			GlobalManager.scene_count += 1
			if GlobalManager.scene_count >= 12:
				area.hide()
				AudioManager.play_sfx("flashlight")
				await get_tree().create_timer(4.5).timeout
				get_tree().change_scene_to_file("res://Scenes/Game/d_001_001.tscn")
			else:
				AudioManager.play_sfx("click")
				get_tree().change_scene_to_file("res://Scenes/Dim_Scene/dim_1.tscn")
