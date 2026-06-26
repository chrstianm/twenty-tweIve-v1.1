extends Node

signal item_picked_up(item_name)

var items = []

func add_item(item_name: String):
	items.append(item_name)
	item_picked_up.emit(item_name) 

func has_item(item_name: String) -> bool:
	return item_name in items
