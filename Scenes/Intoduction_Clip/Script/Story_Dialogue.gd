extends Control

@onready var dialogue_label = $"."
@onready var portrait_sprite = $"../TextureRect"
@onready var audio_player = $"../AudioStreamPlayer"
@onready var button_container = $"../HBoxContainer"

# The dialogue data structure
var dialogue_data = [
	{
		"text": "Hello there, _____.You look... confused. That’s normal. I will be here to help you.",
		"image": preload("res://Assets/Pictures/man_wave.jpg"),
		"audio": preload("res://Assets/Audio/Audio_Intro/intro_line_1.MP3"),
		"buttons": null
	},
	{
		"text": "Do you know where you are?",
		"image": preload("res://Assets/Pictures/man_smiling.jpg"),
		"audio": preload("res://Assets/Audio/Audio_Intro/intro_line_2.wav"),
		"buttons": ["     No     ",]
	},
		{
		"text": "I see.  Can you tell me if you remember anything?",
		"image": preload("res://Assets/Pictures/man_smiling.jpg"),
		"audio": preload("res://Assets/Audio/Audio_Intro/intro_line_3.wav"),
		"buttons": ["     Yes     ", "     No     "]
	},
		{
		"text": "That’s a start, I suppose, but don’t let those flickering images trouble you.",
		"image": preload("res://Assets/Pictures/man_wave.jpg"),
		"audio": preload("res://Assets/Audio/Audio_Intro/intro_line_5.wav"),
		"buttons": null
	},
		{
		"text": "Memories are often just the mind's way of playing tricks when it's tired.",
		"image": preload("res://Assets/Pictures/man_smiling.jpg"),
		"audio": preload("res://Assets/Audio/Audio_Intro/intro_line_6.wav"),
		"buttons": null
	},
		{
		"text": "You’re wondering what’s beyond that gate, aren’t you? I can tell you now: \n\nit’s just more of the same noise, the same cold,the same exhausting world. ",
		"image": preload("res://Assets/Pictures/man_smiling.jpg"),
		"audio": preload("res://Assets/Audio/Audio_Intro/intro_line_8.wav"),
		"buttons": null
	},
		{
		"text": "Why would you want to go back to a place that you don’t even remember?",
		"image": preload("res://Assets/Pictures/man_smiling.jpg"),
		"audio": preload("res://Assets/Audio/Audio_Intro/intro_line_9.wav"),
		"buttons": ["  i want to go home  "]
	},
		{
		"text": "your not go   ing anywh ere, your st aying with me, do  nt you enjoy th is",
		"image": preload("res://Assets/Pictures/base2.jpg"),
		"audio": preload("res://Assets/Audio/Audio_Intro/intro_line_12.MP3"),
		"buttons": null
	}
]

var current_step = 0

func _ready():
	AudioManager.stop_all_bgm()
	AudioManager.play_bgm("waltz")
	await get_tree().create_timer(2.5).timeout
	play_next_step()

func play_next_step():
	if current_step >= dialogue_data.size():
		return

	var data = dialogue_data[current_step]

	# 1. Update UI Elements
	dialogue_label.text = data["text"]
	portrait_sprite.texture = data["image"]
	
	# 2. Clear old buttons from the previous line
	for child in button_container.get_children():
		child.queue_free()

	# 3. Play Audio and wait for it to finish
	if data["audio"]:
		audio_player.stream = data["audio"]
		audio_player.play()
		
		# THE KEY: Wait until the audio file ends
		await audio_player.finished
	
	# 4. Wait the additional 2 second buffer
	await get_tree().create_timer(1.0).timeout

	# 5. Show Buttons after the audio and buffer are done
	if data["buttons"] == null or data["buttons"].is_empty():
		# No buttons provided? Move to next line automatically
		current_step += 1
		play_next_step()
	else:
		# Buttons exist? Wait for player input
		create_buttons(data["buttons"])
		
	if current_step == 6:
		AudioManager.stop_all_bgm()
		AudioManager.play_sfx("heavy_breath")
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://Scenes/Intoduction_Clip/title.tscn")
		
func create_buttons(button_texts: Array):
	for text in button_texts:
		var btn = Button.new()
		btn.text = text
		btn.pressed.connect(_on_button_pressed.bind(text))
		button_container.add_child(btn)

func _on_button_pressed(choice_text: String):
	print("Player chose: ", choice_text)
	AudioManager.play_sfx("click")
	current_step += 1
	await get_tree().create_timer(0.5).timeout
	play_next_step()
