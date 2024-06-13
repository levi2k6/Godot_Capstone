extends GridContainer
signal send_texture(texture, naym)

const CLICKABLE_ITEM_SHOP = preload("res://systems/shop/clickable_item_shop.tscn")
@onready var buy_modal = $"../../../../Buy_Modal"

var items = []

func _ready():
	
	_change_items()
	_create_items()
	#1,2,4,5,7,9

func _item_owned_filter():
	var library_ids = []
	for lib in ItemLibrary.library:
		library_ids.append(lib.id)  #adds all of the item.ids in an array
		for collection in ItemLibrary._get_collection_library():  #deletes the ids that are the same with the ids in collection
			if lib.id == collection.id:
				library_ids.erase(collection.id)
			
	return library_ids


func _change_items():
	if name == "Body_Items":
		for item in ItemLibrary._id_to_library_data(_item_owned_filter()):
			if item.type == "body":
				items.append(item)
		
	if name == "Eyes_Items":
		for item in ItemLibrary._id_to_library_data(_item_owned_filter()):
			if item.type == "eye":
				items.append(item)

	if name == "Mouth_Items":
		for item in ItemLibrary._id_to_library_data(_item_owned_filter()):
			if item.type == "mouth":
				items.append(item)
		
	if name == "Hat_Items":
		for item in ItemLibrary._id_to_library_data(_item_owned_filter()):
			if item.type == "hat":
				items.append(item)
		

func _create_items():
	for item in items:
		var itemins = CLICKABLE_ITEM_SHOP.instantiate()
		add_child(itemins)
		itemins._item_texture(item, name)

func _get_item(item):
	buy_modal._modal_func(item)


