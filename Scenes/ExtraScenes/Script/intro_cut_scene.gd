extends Control

@onready var intro: VideoStreamPlayer = $SubViewport/SubViewport/VideoStreamPlayer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	AudioManager.stop_all_bgm()
	intro.finished.connect(_on_intro_finished)
	
func _on_intro_finished():
	get_tree().change_scene_to_file("res://Scenes/ExtraScenes/transition.tscn")
