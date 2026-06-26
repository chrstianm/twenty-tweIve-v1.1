extends Control

@onready var door: Area2D = $Forward
@onready var back: Area2D = $Back
@onready var door_text: Label = $you_need_to_unlock
@onready var picture_text: Label = $picture_piece

func _ready() -> void:
	CursorManager.set_normal()

#temporary code FOR playtesting lang

func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/f_039_001.tscn")


func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if Inventory.has_item("building key"):
				if Inventory.has_item("picture piece 1") and Inventory.has_item("picture piece 2"):
					CursorManager.set_normal()
					AudioManager.play_sfx("gate_open")
					door.hide()
					back.hide()
					await get_tree().create_timer(1.0).timeout
					SceneChanger.change_scene("res://Scenes/ExtraScenes/cut_scene_door.tscn")
				else:
					CursorManager.set_normal()
					AudioManager.play_sfx("door_knock")
					picture_text.show()
					door.hide()
					await get_tree().create_timer(3.0).timeout
					door.show()
					picture_text.hide()
			else:
				CursorManager.set_normal()
				AudioManager.play_sfx("door_knock")
				door_text.show()
				door.hide()
				await get_tree().create_timer(3.0).timeout
				door.show()
				door_text.hide()
			
