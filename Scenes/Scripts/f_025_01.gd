extends Control
func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.is_picture5_picked_up:
		AudioManager.stop_all_bgm()
		$TextureRect2.visible = true
		AudioManager.play_bgm("parable_cutscene")
		get_tree().create_timer(5.0).timeout.connect(func():
			$TextureRect2.visible = false
			AudioManager.stop_bgm("parable_cutscene")
			Inventory.add_item("main gate key")
			get_tree().change_scene_to_file("res://Scenes/Game/d_002_023.tscn")
		)
	else:
		$TextureRect2.visible = false

func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			CursorManager.set_normal()
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/f_026_01.tscn")


func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/f_024_01.tscn")
