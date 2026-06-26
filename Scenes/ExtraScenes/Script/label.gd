extends Label

@onready var parable: VideoStreamPlayer = $"../VideoStreamPlayer"
var dialogue_map = {
	"scene_one": [
		"",
		"i saved you",
		"you were alone on that area",
		"i gave you this shelter",
		"i welcomed you to my world",
		"don't worry my child",
		"you don't need to escape",
		"you are safe here",
		"i am your angel",
		"i am you r ang el אני המלאך שלך, סגד לי"
	]
}

func _ready() -> void:
	AudioManager.stop_all_bgm()
	AudioManager.play_bgm("parable_cutscene")
	InventoryUi.hide()
	play_dialogue("scene_one")

func play_dialogue(key: String) -> void:
	if not dialogue_map.has(key):
		return
		
	var sequence = dialogue_map[key]
	
	# This loop handles the lines one by one
	for i in range(sequence.size()):
		text = sequence[i]
		if i == 9:
			AudioManager.play_sfx("scream")
			await get_tree().create_timer(0.7).timeout
			AudioManager.stop_all_bgm()
			parable.play()
			await get_tree().create_timer(23.0).timeout
		await get_tree().create_timer(3.0).timeout
	
	# Once the loop is empty (null/no more lines), this runs:
	text = ""
	on_dialogue_finished()

func on_dialogue_finished():
	get_tree().change_scene_to_file("res://Scenes/Game/F001_01.tscn")
