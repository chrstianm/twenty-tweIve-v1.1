extends Control
@onready var redacted_label: Label = $Labeltext

func _ready() -> void:
	CursorManager.set_normal()
	redacted_label.hide()
func _on_redacted_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				AudioManager.play_sfx("click")
				redacted_label.show()
				await get_tree().create_timer(2.0).timeout
				AudioManager.play_sfx("hey")
				redacted_label.hide()

# BACK
func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				AudioManager.play_sfx("click")
				get_tree().change_scene_to_file("res://Scenes/Game/f_006_01.tscn")
