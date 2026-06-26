extends Control

@onready var text1: Label = $Label
@onready var text2: Label = $Label2
@onready var area: Area2D = $Forward
@onready var dontmove: Label = $Label3
@onready var jumpscare: VideoStreamPlayer = $VideoStreamPlayer
@onready var text3: Label = $Label4
@onready var black: ColorRect = $ColorRect
var current_audio = null

func _ready() -> void:
	AudioManager.stop_all_bgm()
	CursorManager.set_normal()
	if GlobalManager.text_scene == false:
		text1.show()
		await  get_tree().create_timer(4.5).timeout
		text1.hide()
		text2.show()
		await  get_tree().create_timer(4.5).timeout
		text2.hide()
		area.show()
	else:
		area.show()
		
	if GlobalManager.scene_count >= 5:
		flickering()
		current_audio = AudioManager.play_sfx("footstep")
	else:
		pass


func _on_forward_mouse_entered() -> void:
	CursorManager.set_hover()
func _on_forward_mouse_exited() -> void:
	CursorManager.set_normal()
func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if is_instance_valid(current_audio) and current_audio.playing:
				AudioManager.play_sfx("click")
				AudioManager.stop_all_sfx()
				GlobalManager.scene_count = 0
				area.hide()
				jumpscare.play()
				jumpscare.finished.connect(_on_video_finished)
			else:
				CursorManager.set_normal()
				GlobalManager.scene_count += 1
				AudioManager.play_sfx("click")
				GlobalManager.text_scene = true
				get_tree().change_scene_to_file("res://Scenes/Dim_Scene/dim_2.tscn")

func flickering():
	dontmove.show()
	await get_tree().create_timer(0.2).timeout
	dontmove.hide()
	await get_tree().create_timer(0.2).timeout
	dontmove.show()
	await get_tree().create_timer(0.3).timeout
	dontmove.hide()
	dontmove.show()
	await get_tree().create_timer(0.2).timeout
	dontmove.hide()
	await get_tree().create_timer(0.2).timeout
	dontmove.show()
	await get_tree().create_timer(0.3).timeout
	dontmove.hide()

func _on_video_finished():
	text3.show()
	GlobalManager.text_scene = false
	await get_tree().create_timer(0.5).timeout
	text3.hide()
	black.show()
	await get_tree().create_timer(0.5).timeout
	black.hide()
	get_tree().change_scene_to_file("res://Scenes/Dim_Scene/dim_1.tscn")
