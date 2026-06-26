extends Control

@onready var area: Area2D = $ID2
@onready var label: Label = $Label

func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.is_id_picked_up == true:
		area.hide()

func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/c_004_06.tscn")

func _on_id_2_mouse_entered() -> void:
	pass
func _on_id_2_mouse_exited() -> void:
	pass
func _on_id_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if GlobalManager.is_id_picked_up == false:
				GlobalManager.is_evidence_picked_up = true
				AudioManager.play_sfx("click")
				CursorManager.set_normal()
				label.show()
				area.hide()
				await get_tree().create_timer(3.0).timeout
				label.hide()
				Inventory.add_item("student id?")
				GlobalManager.is_id_picked_up = true
			else:
				pass
				pass
