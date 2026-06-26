extends Control

@onready var redact: ColorRect = $redact
@onready var text: Label = $text
@onready var paper: Sprite2D = $PaperTreeScratch
@onready var jumpscare: VideoStreamPlayer = $VideoStreamPlayer
@onready var area: Area2D = $jumpscare


func _on_back_mouse_entered() -> void:
	CursorManager.set_back()
func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/c_004_01.tscn")

func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.running_jumpscare_triggered == true:
		area.hide()
	
	
func _on_jumpscare_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			AudioManager.stop_all_bgm()
			jumpscare.play()
			area.hide()
			GlobalManager.running_jumpscare_triggered = true
			jumpscare.finished.connect(_on_video_finished)
func _on_jumpscare_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_jumpscare_mouse_exited() -> void:
	CursorManager.set_normal()

func _on_video_finished():
	AudioManager.play_bgm("ambiance_extreme")
	SceneChanger.change_scene("res://Scenes/Game/c_005_01.tscn")
