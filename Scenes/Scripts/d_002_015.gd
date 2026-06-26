extends Control

func _ready() -> void:
	AudioManager.stop_all_bgm()
	CursorManager.set_normal()
	
	if not AudioManager.parable_cutscene_played:
		AudioManager.parable_cutscene_played = true
		AudioManager.play_bgm("parable_cutscene")
		$TextureRect2.visible = true
		$Text.visible = true
		$Text2.visible = false
		
		get_tree().create_timer(3.5).timeout.connect(func():
			$Text2.visible = true
		)
		get_tree().create_timer(7.0).timeout.connect(func():
			AudioManager.stop_bgm("parable_cutscene")
			$TextureRect2.visible = false
			$Text.visible = false
			$Text2.visible = false
			AudioManager.play_bgm("ambiance_extreme")
		)
	else:
		$TextureRect2.visible = false
		$Text.visible = false
		$Text2.visible = false

func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			CursorManager.set_normal()
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/d_002_016.tscn")
func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/d_002_014.tscn")
