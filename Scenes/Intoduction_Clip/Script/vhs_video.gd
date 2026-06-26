extends VideoStreamPlayer

func _ready():
	# Ensure the video starts playing immediately
	if not is_playing():
		play()

func _process(_delta):
	# SAFETY CHECK: Only proceed if a ShaderMaterial is actually assigned
	if material is ShaderMaterial:
		_handle_glitch_logic()
	else:
		push_warning("Please assign a ShaderMaterial to the VideoStreamPlayer's Material slot!")

func _handle_glitch_logic():
	# 1. Random Static "Spikes" (Mandela Catalogue Style)
	if randf() > 0.75: 
		# Big sudden glitch
		material.set_shader_parameter("static_intensity", randf_range(0.15, 0.3))
		material.set_shader_parameter("chromatic_offset", 0.008)
	else:
		# Standard low-level noise
		material.set_shader_parameter("static_intensity", 0.05)
		material.set_shader_parameter("chromatic_offset", 0.002)

	# 2. Subtle Scanline "Jitter"
	# Makes the lines move slightly to look like a real CRT
	var jitter = 700.0 + randf_range(-10.0, 10.0) 
	material.set_shader_parameter("scanline_count", jitter)
