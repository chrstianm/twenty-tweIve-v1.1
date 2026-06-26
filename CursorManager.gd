extends Node

var hover_cursor = preload("res://Assets/Cursor/Cursor_Hover.png")
var normal_cursor = preload("res://Assets/Cursor/Cursor_Normal.png")
var back_cursor = preload("res://Assets/Cursor/Back_Button.png")

func set_hover() -> void:
	Input.set_custom_mouse_cursor(hover_cursor, Input.CURSOR_ARROW, Vector2(0, 0))

func set_normal() -> void:
	Input.set_custom_mouse_cursor(normal_cursor, Input.CURSOR_ARROW, Vector2(0, 0))

func set_back()-> void:
	Input.set_custom_mouse_cursor(back_cursor, Input.CURSOR_ARROW, Vector2(0, 0))
