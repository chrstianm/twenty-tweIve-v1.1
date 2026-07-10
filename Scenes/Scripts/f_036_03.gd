extends Control

@onready var text: Label = $Label
@onready var area: Area2D = $interact

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
			get_tree().change_scene_to_file("res://Scenes/Game/f_036_02.tscn")

func _on_interact_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if GlobalManager.is_code == false:
				CursorManager.set_normal()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				AudioManager.play_sfx("click")
				area.hide()
				text.show()
				await get_tree().create_timer(1.3).timeout
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				text.hide()
				Inventory.add_item("code?")
				GlobalManager.is_code = true
			elif GlobalManager.is_code == true:
				return
