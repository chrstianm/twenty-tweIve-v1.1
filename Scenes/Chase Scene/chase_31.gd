extends Control
@onready var glitchy_overlay = $GlitchLayer/ColorRect2
@onready var text: Label = $Label

func _ready() -> void:
	glitchy_overlay.start_dynamic_glitch()
	CursorManager.set_normal()

func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			glitchy_overlay.stop_dynamic_glitch()
			AudioManager.play_sfx("click")
			AudioManager.stop_all_bgm()
			text.show()
			await get_tree().create_timer(3.0).timeout
			AudioManager.stop_all_bgm()
			get_tree().change_scene_to_file("res://Scenes/ExtraScenes/police_report4.tscn")
func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
