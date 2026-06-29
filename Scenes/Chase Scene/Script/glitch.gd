extends ColorRect

@export var camera: Camera2D  # Assign your Camera2D in the Inspector

var is_glitching: bool = false

func start_dynamic_glitch():
	if is_glitching: return
	is_glitching = true
	
	# Loop indefinitely until stop_dynamic_glitch() changes is_glitching to false
	while is_glitching:
		
		# --- Part 1: Blackout Logic ---
		# Uses a flat, consistent 3% chance per frame for random dropouts
		if randf() < 0.03: 
			self.color.a = 1
		else:
			self.color.a = 0
		
		# --- Part 2: Screen Shake Logic ---
		if camera:
			# Stays perfectly consistent at 15.0 pixels forever
			var shake_amount = 4.5 
			camera.offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
		
		# Wait for a very short frame (the "0.2ms" feel)
		await get_tree().create_timer(0.01).timeout
		
		if SuspenseTimer.TIMER == true:
			stop_dynamic_glitch()

func stop_dynamic_glitch():
	is_glitching = false
	self.color.a = 0
	if camera:
		camera.offset = Vector2.ZERO
	AudioManager.stop_bgm("vhs_static")
