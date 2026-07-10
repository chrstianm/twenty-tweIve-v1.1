extends Control
@onready var redacted_label: Label = $Labeltext
@onready var area: Area2D  = $Redacted2

func _ready() -> void:
	CursorManager.set_normal()
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


func _on_redacted_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				AudioManager.play_sfx("click")
				area.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				redacted_label.show()
				await get_tree().create_timer(2.0).timeout
				AudioManager.play_sfx("hey")
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				area.show()
				redacted_label.hide()
