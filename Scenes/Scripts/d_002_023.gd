extends Control

func _ready() -> void:
	CursorManager.set_normal()
	get_tree().create_timer(10.0).timeout.connect(func():
		get_tree().change_scene_to_file("res://Scenes/Chase Scene/chase_1.tscn")
	
		)
	
