extends Control

signal back_pressed(current_popup)
@onready var label = $Label
@onready var texture_rect: TextureRect = $TextureRect

var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO

func set_popup_image(image_texture: Texture) -> void:
	if texture_rect and image_texture:
		texture_rect.texture = image_texture

# Detects when the player clicks and drags the popup window
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_offset = get_local_mouse_position()
				# Bring this window to the top of the pile when clicked
				get_parent().move_child(self, -1)
			else:
				dragging = false
				
	if event is InputEventMouseMotion and dragging:
		# Update position based on mouse movement relative to the parent bounds
		var new_pos = get_parent().get_local_mouse_position() - drag_offset
		
		# Clamp the movement so the player can't drag it outside the safe boundary box
		var max_x = get_parent().size.x - size.x
		var max_y = get_parent().size.y - size.y
		position.x = clamp(new_pos.x, 0, max(0, max_x))
		position.y = clamp(new_pos.y, 0, max(0, max_y))

func set_popup_text(new_text: String) -> void:
	if label:
		label.text = new_text
		
func _on_back_pressed() -> void:
	back_pressed.emit(self)
