extends Control

@onready var text: Label = $Label
@onready var area: Area2D = $picture
@onready var redact: ColorRect = $ColorRect2

func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.is_picture2_picked_up == true:
		redact.show()

func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			CursorManager.set_normal()
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/f_035_01.tscn")


func _on_backward_mouse_entered() -> void:
	CursorManager.set_back()
func _on_backward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_backward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/f_033_01.tscn")


func _on_picture_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if GlobalManager.is_picture2_picked_up == false:
				AudioManager.play_sfx("click")
				text.show()
				area.hide()
				await get_tree().create_timer(3.0).timeout
				text.hide()
				redact.show()
				Inventory.add_item("picture piece 2")
				GlobalManager.is_picture2_picked_up = true
