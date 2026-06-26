extends Area2D

func _ready() -> void:
	mouse_entered.connect(CursorManager.set_hover)
	mouse_exited.connect(CursorManager.set_normal)
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		CursorManager.set_normal()
		AudioManager.play_sfx("click")
		get_tree().change_scene_to_file("res://Scenes/Game/F003_01.tscn")
