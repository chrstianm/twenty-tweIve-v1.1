extends Control

@onready var text1: Label = $SubViewportContainer/SubViewport/Label
@onready var text2: Label = $SubViewportContainer/SubViewport/Label2

func _ready() -> void:
	await get_tree().create_timer(4.0).timeout
	text1.hide()
	text2.show()
	await  get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/ExtraScenes/Entity_Intro.tscn")
