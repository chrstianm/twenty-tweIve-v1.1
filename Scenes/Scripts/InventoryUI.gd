extends VBoxContainer

func _ready():
	# Listen for the signal from the Global Manager
	Inventory.item_picked_up.connect(_on_item_added)

func _on_item_added(item_name: String):
	# Create a new Label on the fly
	var new_label = Label.new()
	new_label.text = item_name
	
	# Optional: Set the font color or size here
	# new_label.add_theme_color_override("font_color", Color.WHITE)
	
	add_child(new_label)

func hide_inventory():
	$InventoryUI.hide()

func show_inventory():
	$InventoryUI.show()
