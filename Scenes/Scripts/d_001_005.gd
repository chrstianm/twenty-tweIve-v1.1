extends Control
@onready var note:Area2D = $Note2
@onready var redact: ColorRect = $Redact
@onready var label: Label = $Label

func _ready() -> void:
	if GlobalManager.is_picture3_picked_up == true:
		redact.show()
		note.hide()
	CursorManager.set_normal()

func _on_note_2_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_note_2_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_note_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if GlobalManager.is_picture3_picked_up == false:
				CursorManager.set_normal()
				note.hide()
				AudioManager.play_sfx("click") 
				label.show()
				await get_tree().create_timer(2.0).timeout
				label.hide()
				redact.show()
				Inventory.add_item("picture piece 3")
				GlobalManager.is_picture3_picked_up = true
			elif GlobalManager.is_picture3_picked_up == true:
				note.hide()
				redact.show()

func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/d_001_004.tscn")
