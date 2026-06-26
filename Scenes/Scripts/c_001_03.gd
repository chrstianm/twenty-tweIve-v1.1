extends Control

#onready var item_pickup: TextureRect = $ITEM_PICKUP
@onready var redact: ColorRect = $ColorRect
@onready var pickup_text: Label = $Label

func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.is_key_picked_up == 1 or GlobalManager.is_key_picked_up == 2:
		redact.show()

func _on_key_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if GlobalManager.is_key_picked_up == 0:
				CursorManager.set_normal()
				AudioManager.play_sfx("click")
#				item_pickup.show()
				pickup_text.show()
				await get_tree().create_timer(2.5).timeout
#			item_pickup.hide()
				pickup_text.hide()
				redact.show()
				GlobalManager.is_key_picked_up = 1
				Inventory.add_item("rusty key")
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
			get_tree().change_scene_to_file("res://Scenes/Game/c_001_02.tscn")
