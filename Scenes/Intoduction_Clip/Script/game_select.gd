extends Control

@onready var text: Label = $SubViewport/SubViewport/Label
var count = 0
func _on_newgame_button_pressed() -> void:
	AudioManager.play_sfx("click")
	get_tree().change_scene_to_file("res://Scenes/ExtraScenes/Intro_CutScene.tscn")

func _on_loadgame_button_pressed() -> void:
	AudioManager.play_sfx("click")
	count += 1
	text.show()
	await get_tree().create_timer(2.0).timeout
	text.hide()

	if count >= 5:
		get_tree().change_scene_to_file("res://Scenes/Intoduction_Clip/blue_Screen.tscn")
