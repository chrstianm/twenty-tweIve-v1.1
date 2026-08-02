extends CanvasLayer

@onready var jumpscare_image: TextureRect = $jumpscare

## Duration of the pop animation (seconds)
@export var pop_duration: float = 0.4
## How long the image stays full size before disappearing
@export var hold_duration: float = 0.1

func trigger_jumpscare() -> void:
	# 1. Automatically calculate center pivot
	jumpscare_image.pivot_offset = jumpscare_image.size / 2.0

	AudioManager.play_sfx("scream")

	# 3. Reset transforms
	jumpscare_image.scale = Vector2(0.1, 0.1)
	jumpscare_image.modulate.a = 1.0
	jumpscare_image.show()

	# 4. Tween animation
	var tween = create_tween().set_parallel(false)

	tween.tween_property(jumpscare_image, "scale", Vector2(2, 2), pop_duration)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)

	tween.tween_interval(hold_duration)
	tween.tween_callback(jumpscare_image.hide)
