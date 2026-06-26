extends Control

@onready var text: Label = $Wallet
@onready var redact: ColorRect = $redact
@onready var area: Area2D = $Wallet2

func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.is_wallet_picked_up == true:
		redact.show()

func _on_wallet_2_mouse_entered() -> void:
	pass
func _on_wallet_2_mouse_exited() -> void:
	pass
func _on_wallet_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if GlobalManager.is_wallet_picked_up == false:
				CursorManager.set_normal()
				area.hide()
				AudioManager.play_sfx("click")
				text.show()
				await get_tree().create_timer(2.5).timeout
				text.hide()
				redact.show()
				GlobalManager.is_wallet_picked_up = true
				Inventory.add_item("colt's wallet")
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
			get_tree().change_scene_to_file("res://Scenes/Game/c_004_01.tscn")
