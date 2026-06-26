extends Control

# The sequence the player must hit
const CORRECT_PATTERN = [2, 2, 2, 1, 6] 
var current_input = []

func _ready():
	CursorManager.set_normal()
	for btn in $GridContainer.get_children():
		btn.pressed.connect(_on_number_pressed.bind(int(btn.name.right(1))))

func _on_number_pressed(num: int):
	current_input.append(num)
	AudioManager.play_sfx("click")
	print("Pattern so far: ", current_input)
	
	check_pattern()

func check_pattern():
	# Check if the sequence matches so far
	for i in range(current_input.size()):
		if current_input[i] != CORRECT_PATTERN[i]:
			print("Wrong sequence! Resetting...")
			reset_puzzle()
			return

	if current_input.size() == CORRECT_PATTERN.size():
		unlock_area()

func reset_puzzle():
	current_input.clear()
	# Optional: Shake the UI or play an "error" buzzer

func unlock_area():
	SceneChanger.change_scene("res://Scenes/Dim_Scene/dim_1.tscn")

func _on_button_pressed() -> void:
	AudioManager.play_sfx("click")
	get_tree().change_scene_to_file("res://Scenes/Game/c_002_01.tscn")
