extends Control
@onready var text: Label = $TextLabel
@onready var text2: Label = $TextLabel2
@onready var cr_area: Area2D = $CR
@onready var left: TextureRect = $LeftButton
@onready var time: Label = $Label

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	AudioManager.stop_bgm("testimony")
	InventoryUi.show()
	CursorManager.set_normal()
	text.hide()
	text2.hide()
	await _show_label()
	if GlobalManager.is_code == true:
		left.hide()
	
	if GlobalManager.hallway_trigger == 2:
		time.hide()
		if GlobalManager.is_evidence_picked_up == true:
			left.show()
		else:
			left.hide()

func _show_label():
	if GlobalManager.hallway_trigger == 0:
		AudioManager.play_bgm("outside")
		cr_area.hide()
	elif GlobalManager.hallway_trigger == 1:
		left.hide()
		AudioManager.stop_all_bgm()
		AudioManager.play_bgm("ambiance_extreme")
		AudioManager.play_sfx("type")
		AudioManager.play_sfx("heavy_breath")
		text.show()
		await get_tree().create_timer(3.0).timeout
		AudioManager.play_sfx("type")
		text.hide()
		text2.show()
		await get_tree().create_timer(3.0).timeout
		text2.hide()
		GlobalManager.hallway_trigger = 2
		show_cr_area()
	elif GlobalManager.hallway_trigger == 2:
		cr_area.show()
	else:
		text.hide()
		text2.hide()

func show_cr_area():
	if GlobalManager.hallway_trigger == 2:
		cr_area.show()
	else:
		cr_area.hide()

func _on_cr_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_cr_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_cr_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			CursorManager.set_normal()
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/c_001_01.tscn")
