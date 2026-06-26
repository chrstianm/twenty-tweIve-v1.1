extends ColorRect

@export var camera: Camera2D  # Assign your Camera2D in the Inspector

var is_glitching: bool = false
var glitch_intensity: float = 1.0 # 0.0 to 1.0

func start_dynamic_glitch(duration: float):
	if is_glitching: return
	is_glitching = true
	
	var start_time = Time.get_ticks_msec()
	var end_time = start_time + (duration * 1000.0)
	
	while Time.get_ticks_msec() < end_time:
		var current_time = Time.get_ticks_msec()
		# Calculate how far we are (0.0 at start, 1.0 at end)
		glitch_intensity = (current_time - start_time) / (duration * 1000.0)
		
		# --- Part 1: Blackout Logic ---
		# As intensity increases, blackouts become more frequent
		if randf() < (0.01 + glitch_intensity * 0.02): 
			self.color.a = 1
		else:
			self.color.a = 0
		
		# --- Part 2: Screen Shake Logic ---
		if camera:
			# Shake gets more violent as intensity increases
			var shake_amount = glitch_intensity * 1.0 # Max 15 pixels
			camera.offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
		
		# Wait for a very short frame (the "0.2ms" feel)
		await get_tree().create_timer(0.01).timeout
		
	# Reset everything
	stop_glitch()

func stop_glitch():
	is_glitching = false
	self.color.a = 0
	if camera:
		camera.offset = Vector2.ZERO
	AudioManager.stop_bgm("vhs_static")
	GlobalManager.hallway_trigger = 1
	get_tree().change_scene_to_file("res://Scenes/ExtraScenes/Entity.tscn")
