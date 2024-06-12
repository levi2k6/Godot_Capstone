extends GridContainer
signal send_texture(texture, naym)

const CLICKABLE_PART_SHOP = preload("res://scenes/shop/clickable_part_shop.tscn")
@onready var buy_modal = $"../../../../Buy_Modal"


var parts = []



func _ready():
	parts = []
	_change_parts()
	_create_parts()
	#1,2,4,5,7,9




func _item_owned_filter():
	var library_ids = []
	for lib in PartLibrary.library:
		library_ids.append(lib.id)  #adds all of the item.ids in an array
		for collection in PartLibrary._get_collection_library():  #deletes the ids that are the same with the ids in collection
			if lib.id == collection.id:
				library_ids.erase(collection.id)
			
	return library_ids


func _change_parts():
	if name == "Body_Parts":
		for part in PartLibrary._id_to_library_data(_item_owned_filter()):
			if part.type == "body":
				parts.append(part)
		
	if name == "Eyes_Parts":
		for part in PartLibrary._id_to_library_data(_item_owned_filter()):
			if part.type == "eye":
				parts.append(part)

	if name == "Mouth_Parts":
		for part in PartLibrary._id_to_library_data(_item_owned_filter()):
			if part.type == "mouth":
				parts.append(part)
		
	if name == "Hat_Parts":
		for part in PartLibrary._id_to_library_data(_item_owned_filter()):
			if part.type == "hat":
				parts.append(part)
		
		
func _create_parts():
	for part in parts:
		pass
		#print(part)
		var partins = CLICKABLE_PART_SHOP.instantiate()
		add_child(partins)
		partins._part_texture(part, name)



func _get_part(part):
	buy_modal._modal_func(part)


