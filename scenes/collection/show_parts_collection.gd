extends GridContainer
signal send_texture(texture, naym)

var sprites = sprite_library.new()

const CLICKABLE_PART = preload("res://scenes/misc/clickable/clickable_part.tscn")

var parts = []



func _ready():
	_change_parts()
	_create_parts()

func _change_parts():
	
	if name == "Body_Parts":
		for i in PartLibrary._collection_algo():
			if i.type == "body":
				parts.append(i.texture)
	elif name == "Eyes_Parts":
		for i in PartLibrary._collection_algo():
			if i.type == "eye":
				parts.append(i.texture)
	elif name == "Mouth_Parts":
		for i in PartLibrary._collection_algo():
			if i.type == "mouth":
				parts.append(i.texture)
	elif name == "Hat_Parts":
		for i in PartLibrary._collection_algo():
			if i.type == "hat":
				parts.append(i.texture)


func _create_parts():
	for part in parts:
		var partins = CLICKABLE_PART.instantiate()
		add_child(partins)
		partins.get_child(0).texture = part
		if name == "Eyes_Parts":
			partins.get_child(0).hframes = 9
			partins.get_child(0).vframes = 1
			partins.get_child(0).frame = 2
		if name == "Mouth_Parts":
			partins.get_child(0).hframes = 15
			partins.get_child(0).vframes = 1
			partins.get_child(0).frame = 2

#func _create_parts():
	#for part in parts:
		#var partins = CLICKABLE_PART.instantiate()
		#add_child(partins)
		#partins.get_child(0).texture = part
		#if name == "Eyes_Parts":
			#partins.get_child(0).hframes = 9
			#partins.get_child(0).vframes = 1
			#partins.get_child(0).frame = 2
		#if name == "Mouth_Parts":
			#partins.get_child(0).hframes = 15
			#partins.get_child(0).vframes = 1
			#partins.get_child(0).frame = 2


func _get_part(part):
	emit_signal("send_texture", part, name)
	


