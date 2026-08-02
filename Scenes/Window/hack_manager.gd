extends Node

@export_category("Scenes")
@export var popup_scene: PackedScene
@export var final_scene: PackedScene

@export_category("Images")
@export var standard_photo: Texture
@export var final_photo: Texture

# Drag your SpawnBounds node from the scene tree into this slot in the Inspector
@export var bounds_node: Control 

var popup_count: int = 0
const MAX_POPUPS: int = 20
const FINAL_DELAY: float = 3.0

func start_hack() -> void:
	if not bounds_node:
		print("Setup Error: Please assign the SpawnBounds node to HackManager!")
		return
	spawn_new_popup()

func spawn_new_popup() -> void:
	popup_count += 1
	
	var new_popup = popup_scene.instantiate()
	
	# CRITICAL: We add the popup inside our bounds node so it inherits its coordinate environment
	bounds_node.add_child(new_popup)
	new_popup.set_popup_image(standard_photo)
	new_popup.back_pressed.connect(_on_popup_back_pressed)
	new_popup.set_popup_text("case 89-5162\ndecedent: colt")
	
	# Get boundary size and popup size
	var bounds_size = bounds_node.size
	var popup_size = new_popup.size
	
	# Strict calculation: Stay within the box width and height
	var max_x = bounds_size.x - popup_size.x
	var max_y = bounds_size.y - popup_size.y
	
	# Safeguard against tiny boundaries
	var random_x = randf_range(0, max(0, max_x))
	var random_y = randf_range(0, max(0, max_y))
	
	# Control node local positioning
	new_popup.position = Vector2(random_x, random_y)

func spawn_final_popup() -> void:
	var final_popup = popup_scene.instantiate()
	bounds_node.add_child(final_popup)
	
	final_popup.set_popup_image(final_photo)
	final_popup.set_popup_text("you will not escape")
	
	var bounds_size = bounds_node.size
	var popup_size = final_popup.size
	
	# Center it perfectly inside your designated boundary box
	var center_x = (bounds_size.x / 2) - (popup_size.x / 2)
	var center_y = (bounds_size.y / 2) - (popup_size.y / 2)
	
	final_popup.position = Vector2(center_x, center_y)
	
	if final_popup.has_node("Button"):
		final_popup.get_node("Button").visible = false

	await get_tree().create_timer(FINAL_DELAY).timeout
	trigger_final_scene()

func _on_popup_back_pressed(triggered_popup: Control) -> void:
	if popup_count < MAX_POPUPS:
		spawn_new_popup()
		spawn_new_popup()
	else:
		spawn_final_popup()

func trigger_final_scene() -> void:
	if final_scene:
		get_tree().change_scene_to_packed(final_scene)
