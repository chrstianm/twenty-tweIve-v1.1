extends Control

@onready var glitchy_overlay = $GlitchLayer/ColorRect2
@onready var text: Label = $Label
@onready var area = $Forward
func _ready() -> void:
	SuspenseTimer.start_timer()
	area.hide()
	InventoryUi.hide()
	glitchy_overlay.start_dynamic_glitch()
	AudioManager.play_bgm("runrabbit")
	CursorManager.set_normal()
	text.show()
	await get_tree().create_timer(0.3).timeout
	text.hide()
	await get_tree().create_timer(0.2).timeout
	text.show()
	await get_tree().create_timer(0.3).timeout
	text.hide()
	await get_tree().create_timer(0.15).timeout
	text.show()
	await get_tree().create_timer(0.3).timeout
	text.hide()
	area.show()

	

func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Chase Scene/chase_2.tscn")
func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
