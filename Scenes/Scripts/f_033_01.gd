extends Control

@onready var text: Label = $Label
@onready var area: Area2D = $forward
@onready var back: Area2D = $backward
@onready var redact: Area2D = $telephone
@onready var text2: Label = $Label2

func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.is_vm_triggered == true:
		redact.hide()
func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			CursorManager.set_normal()
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/f_034_01.tscn")

func _on_backward_mouse_entered() -> void:
	CursorManager.set_back()
func _on_backward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_backward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/f_029_01.tscn")

func _on_telephone_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if GlobalManager.is_vm_triggered == false:
				CursorManager.set_normal()
				AudioManager.stop_all_bgm()
				AudioManager.play_sfx("click")
				area.hide()
				back.hide()
				redact.hide()
				text.show()
				await get_tree().create_timer(1.0).timeout
				AudioManager.play_sfx("telephone_convo")
				await get_tree().create_timer(38.0).timeout
				text.hide()
				text2.show()
				await get_tree().create_timer(3.0).timeout
				AudioManager.play_bgm("ambiance_extreme")
				Inventory.add_item("old phone")
				text2.hide()
				area.show()
				back.show()
				GlobalManager.is_vm_triggered = true
			elif GlobalManager.is_vm_triggered == true:
				redact.hide()
				
