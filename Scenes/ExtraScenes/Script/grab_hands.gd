extends Sprite2D

func _ready():
	animate_and_vanish()

func animate_and_vanish():
	# 1. Create the tween
	#AudioManager.play_sfx("hand")
	await get_tree().create_timer(1.0).timeout
	var tween = create_tween()
	
	# 2. Move to the target (Current X + 500) over 2.0 seconds
	var target_pos = position + Vector2(550, 0)
	tween.tween_property(self, "position", target_pos, 2.0).set_trans(Tween.TRANS_SINE)
	
	# 3. Make it disappear (fade alpha to 0) over 0.5 seconds
	tween.tween_property(self, "modulate:a", 0.0, 0.0)
	
	# 4. Remove the node from the scene tree once finished
	tween.finished.connect(queue_free)
