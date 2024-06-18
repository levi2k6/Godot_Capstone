extends GridContainer
signal send_texture(texture, naym)

var sprites = sprite_library.new()

const CLICKABLE_ITEM = preload("res://systems/misc/clickable/clickable_item.tscn")

var items = []



func _ready():
	_change_items()
	_create_items()

func _change_items():
	
	if name == "Body_Items":
		for i in ItemLibrary._collection_algo():
			if i.type == "body":
				items.append(i.texture)
	elif name == "Eyes_Items":
		for i in ItemLibrary._collection_algo():
			if i.type == "eye":
				items.append(i.texture)
	elif name == "Mouth_Items":
		for i in ItemLibrary._collection_algo():
			if i.type == "mouth":
				items.append(i.texture)
	elif name == "Hat_Items":
		for i in ItemLibrary._collection_algo():
			if i.type == "hat":
				items.append(i.texture)


func _create_items():
	for item in items:
		var itemins = CLICKABLE_ITEM.instantiate()
		add_child(itemins)
		itemins.get_child(0).texture = item
		if name == "Eyes_Items":
			itemins.get_child(0).hframes = 9
			itemins.get_child(0).vframes = 1
			itemins.get_child(0).frame = 2
		if name == "Mouth_Items":
			itemins.get_child(0).hframes = 15
			itemins.get_child(0).vframes = 1
			itemins.get_child(0).frame = 2


func _get_item(item):
	emit_signal("send_texture", item, name)
	


