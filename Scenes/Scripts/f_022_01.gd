extends Control

@onready var redact: ColorRect = $redact
@onready var text: Label = $text

func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.is_picture_picked_up == true:
		redact.show()
	if GlobalManager.has_picture_been_collected == true:
		redact.show()
	
func _on_forward_mouse_entered() -> void:
	pass
func _on_forward_mouse_exited() -> void:
	pass
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				if GlobalManager.is_picture_picked_up == false:
					CursorManager.set_normal()
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
					AudioManager.play_sfx("click")
					text.show()
					await get_tree().create_timer(2.5).timeout 
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					text.hide()
					redact.show()
					Inventory.add_item("picture piece 1")
					AudioManager.play_sfx("door_knock")
					GlobalManager.is_picture_picked_up = true
					GlobalManager.has_picture_been_collected = true
			else:
				pass

func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				AudioManager.play_sfx("click")
				get_tree().change_scene_to_file("res://Scenes/Game/f_020_01.tscn")
