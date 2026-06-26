extends Control
@onready var label: Label = $plasticbottle
@onready var redact: ColorRect = $ColorRect2
@onready var area: Area2D = $water
func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.is_bottle_picked_up == true:
		redact.show()

func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/c_004_03.tscn")

func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			CursorManager.set_normal()
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/c_004_05.tscn")

func _on_water_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			CursorManager.set_normal()
			area.hide()
			label.show()
			await get_tree().create_timer(2.5).timeout
			label.hide()
			redact.show()
			Inventory.add_item("bottled water")
			GlobalManager.is_bottle_picked_up = true
