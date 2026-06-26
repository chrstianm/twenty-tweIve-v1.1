extends Control

@onready var glitchy_overlay = $GlitchLayer/ColorRect2
func _ready() -> void:
	glitchy_overlay.start_dynamic_glitch()
	CursorManager.set_normal()

func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			AudioManager.play_sfx("whispers")
			get_tree().change_scene_to_file("res://Scenes/Chase Scene/chase_14.tscn")
func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
