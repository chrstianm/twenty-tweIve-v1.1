extends Control

@onready var redact: ColorRect = $ColorRect2
@onready var chuckie:  = $Label
@onready var area: Area2D = $forward
func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.is_chuckie_picked_up == true:
		area.hide()
		redact.show()
		
func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if GlobalManager.is_chuckie_picked_up == false:
				CursorManager.set_normal()
				AudioManager.play_sfx("click")
				chuckie.show()
				area.hide()
				await get_tree().create_timer(2.0).timeout
				chuckie.hide()
				redact.show()
				GlobalManager.is_chuckie_picked_up = true
				Inventory.add_item("chuckie")
			else:
				pass
			

func _on_backward_mouse_entered() -> void:
	CursorManager.set_back()
func _on_backward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_backward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/f_031_01.tscn")
