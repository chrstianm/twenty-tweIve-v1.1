extends Label

# Reference to the TextureRect node
@onready var entity_display = $"../VictimImage"
@onready var sub_viewport_container: SubViewportContainer = $"../.."
@onready var DMS: Label = $"../DMSText"
@onready var CASE: Label = $"../CaseText"
@onready var LOGO: Sprite2D = $"../DmsLogo"
@onready var BG: ColorRect = $"../ColorRect"

# The Library: Text and optional image path
var archive_data = [
	{
		"text": "Entry 1: Confirmed Victims\n\nSeveral students reportedly missing.",
		"image": null 
	},
	{
		"text": "\n\nCause of disappearance still unknown.",
		"image": null 
	},
	{
		"text": "ArchIve confirmed 3 new cases of ███\ninside a local university.\nOrigin: ████████\nCase No.: F-███-12",
		"image": null 
	},
	{
		"text": "\n\nCase F001-12-001",
		"image": "res://Assets/Pictures/Victim1.jpg"
	},
		{
		"text": "Name: Colt\nAddress: █████████\nLast Found: CEIT Building\n\n - Confirmed victim have been\nfound suspended from the ceiling\nin the Lobby.\nThey are alive, but 'reconfigured.'\n" ,
		"image": "res://Assets/Pictures/Victim1.jpg"
	},
		{
		"text": "\n\nCase F001-12-002",
		"image": "res://Assets/Pictures/Victim2.jpg"
	},
		{
		"text": "Name: J███o\nLast Found: Library\n\n- A black, mucus-like substance\nis leaking from the place of origin.\nArchIve scientists have identified\nthe corrosion pattern.",
		"image": "res://Assets/Pictures/Victim2.jpg"
	},
		{
		"text": "\n\nCase F001-12-003",
		"image": "res://Assets/Pictures/Victim3.jpg"
	},
		{
		"text": "1ZfB5zd10qPv2_65CBEwrHLU-GJqCqmP0\n█████████d ███\n████████i████████████████\n███e█████████████\n███████████████████\n███6████████████",
		"image": "res://Assets/Pictures/Victim3.jpg"
	},
			{
		"text": "diediediediedeidiediediedidieideieidieiedidie\nediediediedeidiediediedidieideieidieiedidie\ndiediediediedeidiediediedidieideieidieiedidie\nediediededeidiedidiedidieideieidieididie\ndiediediediedeidiediediedidieideieidieiedidie\nduedudeidediediedidediediediedie\nyoumusthidehidehidehidehideknadjsiejasncs",
		"image": "res://Assets/Pictures/Victim3(2).jpg"
	},
			{
		"text": "",
		"image": "res://Assets/Pictures/Victim3(3).jpg"
	},
		{
		"text": "\n                                   Я тебя найду\n    Я тебя найду\n      Я тебя найду\n           Я тебя найду\n                Я тебя найду\n              Я тебя найду",
		"image": "res://Assets/Pictures/Victim3(3).jpg"
	},
			{
		"text": "\n\n\n\n\n\n                       i'll find you.",
		"image": "res://Assets/Pictures/Victim3(3).jpg"
	},
			{
		"text": "\n\n\n\n\n i know where you are",
		"image": "res://Assets/Pictures/Victim3(3).jpg"
	},
]

var current_index = 0
@onready var timer = Timer.new()

func _ready():
	await get_tree().create_timer(2.5).timeout
	# Start with a clean slate
	text = ""
	visible_ratio = 1.0 # Ensure text is always fully visible
	entity_display.texture = null
	
	# Setup the loop timer
	add_child(timer)
	timer.wait_time = 5.0
	timer.timeout.connect(display_next_entry)
	
	# Show the first entry immediately on start
	display_next_entry()
	timer.start()

func display_next_entry():
	# 1. Peek at the data for the current index
	if current_index < archive_data.size():
		var data = archive_data[current_index]
		
		# --- IMAGE LOGIC (Instant) ---
		if data["image"] != null:
			await get_tree().create_timer(1.0).timeout
			entity_display.texture = load(data["image"])
			entity_display.modulate.a = 1.0
		else:
			# If the data has NO image, clear the display
			entity_display.texture = null
		
		# --- TEXT LOGIC (With Pause) ---
		# Clear the old text first
		text = ""
		
		# Wait for the 0.5s "Data Processing" delay
		await get_tree().create_timer(1.0).timeout
		
		# Now show the new text
		text = data["text"]
		AudioManager.play_sfx("type")
		
		current_index += 1
	else:
		# Reset the index to loop the archive from the start
		current_index = 0 
		display_next_entry()
	
	var container_material = get_node("../../").material
	if current_index == 9: # When it hits the "diediedie" part
		AudioManager.play_bgm("glitch")
		AudioManager.play_sfx("whispers")
		timer.wait_time = 5.0 # Make the text flash by rapidly
		if container_material is ShaderMaterial:
			container_material.set_shader_parameter("shake_power", 0.05)
			container_material.set_shader_parameter("color_drift", 0.0005)
			
	elif current_index == 12: # The final "i'll find you"
		AudioManager.stop_all_bgm()
		if container_material is ShaderMaterial:
			container_material.set_shader_parameter("shake_power", 0.0) # Everything goes dead silent
			container_material.set_shader_parameter("color_drift", 0.0)
	
	elif current_index == 13:
		AudioManager.play_sfx("ill_find_you")
		var container_material_1 = get_node("../Grain").material
		if container_material_1 is ShaderMaterial:
			container_material_1.set_shader_parameter("vignette_intensity", 0.0) # Everything goes dead silent
			container_material_1.set_shader_parameter("noise_opacity", 0.0)
		DMS.hide()
		CASE.hide()
		LOGO.hide()
		BG.hide()
		await get_tree().create_timer(8.5).timeout
		get_tree().change_scene_to_file("res://Scenes/Intoduction_Clip/title.tscn")
