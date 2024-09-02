extends GridContainer
signal send_texture(texture, naym)


const CLICKABLE_ITEM_COLLECTION = preload("res://systems/collection/clickable_item_collection.tscn")

var items = []


func _ready():
	_delete_item_nodes()
	_change_items()
	_create_items()
	

func _delete_item_nodes():
	items.clear()
	for child in get_children():
		print(child)
		child.queue_free()
	

func _change_items():
	var collection = ItemLibrary._get_collection_library()
	
	if name == "Body_Items":
		for item in collection:
			if item.type == "body":
				items.append(item)
	elif name == "Eyes_Items":
		for item in collection:
			if item.type == "eye":
				items.append(item)
	elif name == "Mouth_Items":
		for item in collection:
			if item.type == "mouth":
				items.append(item)
	elif name == "Hat_Items":
		for item in collection:
			if item.type == "hat":
				items.append(item)
	elif name == "Color_Items":
		for item in collection:
			if item.type == "color":
				items.append(item)


func _create_items():
	for item in items:
		var itemins = CLICKABLE_ITEM_COLLECTION.instantiate()
		add_child(itemins)
		itemins._item_texture(item, name)


func _get_item(item):
	emit_signal("send_texture", item, name)
	



