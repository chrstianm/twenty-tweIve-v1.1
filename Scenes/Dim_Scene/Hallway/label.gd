extends RichTextLabel

func start_fade_in(duration: float = 1.0) -> void:
	modulate.a = 0.0
	show() # Reveals the node
	
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
