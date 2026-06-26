extends Control

@onready var area: Area2D = $"Door Key"
@onready var text: Label = $Label
@onready var redact: ColorRect = $ColorRect2
@onready var forward: Area2D = $forward
@onready var back: Area2D = $backward

func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.is_door_key_picked_up == true:
		redact.show()

func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/f_026_01.tscn")

func _on_backward_mouse_entered() -> void:
	CursorManager.set_back()
func _on_backward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_backward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/f_026_01.tscn")

func _on_door_key_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if GlobalManager.is_door_key_picked_up == false:
				CursorManager.set_normal()
				AudioManager.play_sfx("click")
				area.hide()
				text.show()
				forward.hide()
				back.hide()
				await get_tree().create_timer(3.0).timeout
				text.hide()
				redact.show()
				forward.show()
				back.show()
				Inventory.add_item("building key")
				GlobalManager.is_door_key_picked_up = true
			
