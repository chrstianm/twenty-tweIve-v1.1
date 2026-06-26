extends Control
@onready var text: Label = $Text
@onready var collision: Area2D = $TO_DIT
func _ready() -> void:
	CursorManager.set_normal()
	
	if GlobalManager.text_hazy == 0:
		collision.hide()
		text.show()
		await get_tree().create_timer(2.5).timeout
		text.hide()
		collision.show()
		GlobalManager.text_hazy = 1
	else:
		text.hide()
		collision.show()

func _on_to_dit_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_to_dit_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_to_dit_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			CursorManager.set_normal()
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/f_006_01.tscn")

#Back
func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				AudioManager.play_sfx("click")
				get_tree().change_scene_to_file("res://Scenes/Game/F004_01.tscn")
