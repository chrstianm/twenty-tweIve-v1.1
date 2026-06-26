extends CanvasLayer

signal condition_met
signal time_ran_out

@onready var label: Label = $CenterContainer/Label

# Change this in the inspector or code to set the default timer duration
@export var wait_time: float = 90.0 

var time_left: float
var is_running: bool = false
var is_condition_satisfied: bool = false

var base_label_position: Vector2
var glitch_characters: String = "0123456789!@#$%&*?X"

func _ready() -> void:
	hide()
	call_deferred("_capture_base_position")

func _capture_base_position() -> void:
	base_label_position = label.position

# --- CORE LOGIC ---

# You can now pass a specific time when starting, or leave it blank to use wait_time
func start_timer(duration: float = wait_time) -> void:
	wait_time = duration # Save the max time for the glitch math
	time_left = wait_time
	is_running = true
	is_condition_satisfied = false
	show()
	set_process(true)

func satisfy_condition() -> void:
	if is_running and not is_condition_satisfied:
		is_condition_satisfied = true
		is_running = false
		hide()
		condition_met.emit()
		set_process(false)
		print("SUCCESS: Condition met before time ran out!")

func _process(delta: float) -> void:
	if not is_running:
		return

	time_left -= delta

	if time_left <= 0.0:
		time_left = 0.0
		is_running = false
		hide()
		time_ran_out.emit()
		set_process(false)
		print("FAILURE: Time ran out!")
		AudioManager.stop_all_bgm()
		get_tree().change_scene_to_file("res://Scenes/Chase Scene/chase_1.tscn")
		return

	_update_ui()
	_apply_glitch_effect()

# --- VISUALS & EFFECTS ---

func _update_ui() -> void:
	# Calculate minutes and remaining seconds properly
	var minutes: int = int(time_left / 60.0)
	var seconds: int = int(fmod(time_left, 60.0))
	var milliseconds: int = int((time_left - int(time_left)) * 100)
	
	# Formats to MM:SS:MS
	label.text = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

func _apply_glitch_effect() -> void:
	# Urgency dynamically scales based on whatever wait_time is set to
	var urgency: float = 1.0 - (time_left / max(wait_time, 0.1))
	
	# Only start glitching when there are 15 seconds left
	if time_left <= 15.0:
		var glitch_chance: float = urgency * 0.4 
		
		if randf() < glitch_chance:
			# 1. Stutter Position
			var offset_x = randf_range(-15.0, 15.0) * urgency
			var offset_y = randf_range(-15.0, 15.0) * urgency
			label.position = base_label_position + Vector2(offset_x, offset_y)
			
			# 2. Color Glitch
			if randf() < 0.3:
				label.modulate = Color(1.0, randf_range(0, 0.5), randf_range(0, 0.5))
			else:
				label.modulate = Color.RED
				
			# 3. Text Garble
			if randf() < 0.15 * urgency:
				var garbled_text = ""
				for i in range(8):
					garbled_text += glitch_characters[randi() % glitch_characters.length()]
				label.text = garbled_text
		else:
			_reset_label_visuals()
	else:
		_reset_label_visuals()

func _reset_label_visuals() -> void:
	label.position = base_label_position
	label.modulate = Color.WHITE
