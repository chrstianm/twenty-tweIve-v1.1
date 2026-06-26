extends Control
@onready var area: Area2D = $Forward
@onready var text: Label = $Label
func _ready() -> void:
	CursorManager.set_normal()


func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if GlobalManager.is_key_picked_up == 0:
				CursorManager.set_normal()
				AudioManager.play_sfx("click")
				area.hide()
				text.show()
				await get_tree().create_timer(2.0).timeout
				area.show()
				text.hide()
			elif GlobalManager.is_key_picked_up == 1:
				CursorManager.set_normal()
				AudioManager.play_sfx("gate_open")
				SceneChanger.change_scene("res://Scenes/Game/c_004_01.tscn")
				GlobalManager.is_key_picked_up = 2
			elif GlobalManager.is_key_picked_up == 2:
				CursorManager.set_normal()
				AudioManager.play_sfx("click")
				get_tree().change_scene_to_file("res://Scenes/Game/c_004_01.tscn")

func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/c_002_01.tscn")
