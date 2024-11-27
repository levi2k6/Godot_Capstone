extends GridContainer
signal send_texture(texture, naym)

const CLICKABLE_ITEM_COLLECTION = preload("res://systems/collection/clickable_item_collection.tscn")

var items = []

func _ready():
	_change_items()
	_create_items()

func _change_items():
	if name == "Body_Items":
		var i = 0;
		for item in ItemLibrary.library:
			if item.type == "body":
				items.append(item);
				i+=1;
			if i == 3:
				break;
			
	elif name == "Eyes_Items":
		var i = 0;
		for item in ItemLibrary.library:
			if item.type == "eye":
				items.append(item);
				i+=1;
			if i == 3:
				break;
	elif name == "Mouth_Items":
		var i = 0;
		for item in ItemLibrary.library:
			if item.type == "mouth":
				items.append(item);
				i+=1;
			if i == 3:
				break;
			
	elif name == "Color_Items":
		var i = 0;
		for item in ItemLibrary.library:
			if item.type == "color":
				items.append(item);
				i+=1;
			if i == 3:
				break;

func _create_items():
	for item in items:
		var itemins = CLICKABLE_ITEM_COLLECTION.instantiate();
		add_child(itemins);
		itemins._item_texture(item, name);

func _get_item(item):
	emit_signal("send_texture", item, name);



