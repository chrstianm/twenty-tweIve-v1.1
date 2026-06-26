extends TextureRect

@export var fade_duration: float = 18.0  # Time in seconds to reach full visibility
@export var delay_before_fade: float = 0.5 # Wait time before the fade starts

func _ready():
	# 1. Start completely invisible
	modulate.a = 0.0
	
	# 2. Create a timer for the initial delay
	await get_tree().create_timer(delay_before_fade).timeout
	
	# 3. Create the Fade Tween
	var fade_tween = get_tree().create_tween()
	
	# We animate the 'a' (alpha) channel of the 'modulate' color to 1.0
	fade_tween.tween_property(self, "modulate:a", 0.5, fade_duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	
	# 4. Optional: Do something once the fade is finished
	fade_tween.finished.connect(_on_fade_finished)

func _on_fade_finished():
	print("Fade-in complete.")
