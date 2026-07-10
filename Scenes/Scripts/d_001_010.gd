extends Control

@onready var label: Label = $Label
@onready var area: Area2D = $Area2D

func _ready() -> void:
	CursorManager.set_normal()

func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/d_001_009.tscn")


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			area.hide()
			AudioManager.play_sfx("click")
			label.show()
			await get_tree().create_timer(2.0).timeout
			label.hide()
			area.show()
