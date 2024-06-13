extends Node


var library = [
	{"texture":preload("res://sprite/body/body1.png"), "id":0, "name":	"", "type": ""},
	{"texture":preload("res://sprite/body/body2.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://sprite/body/body3.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://sprite/face/eyes/eye1-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://sprite/face/eyes/eyes2-Sheet.png"), "id":0, "name": "", "type": ""  },
	{"texture":preload("res://sprite/face/eyes/eyes3-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://sprite/face/mouth/mouth1-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://sprite/face/mouth/mouth2-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://sprite/hat/hat1.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://sprite/hat/hat2.png"), "id":0, "name": "", "type": "" }
	]


func _ready():  
	
	_append_library()
	_get_pet_equip_library()



func _append_library():
	print("working")
	Singleton.database.query(
		"SELECT * FROM items;"
	)
	var items = Singleton.database.query_result
	var n = 0
	for lib in library:
		lib.id = items[n].id
		lib.name = items[n].name
		lib.type = items[n].type
		n += 1
		
	#print(library)



func _id_to_library_data(ids):
	var dictionaries = []
	
	for item in library:
		for id in ids:
			#print(collection," ", item.id)
			if id == item.id:
				dictionaries.append(item)
				
	
	return dictionaries

func _get_pet_equip_library():
	Singleton.database.query(
		"SELECT * FROM  pet;"
	)
	var result = Singleton.database.query_result
	var lib_result = []
	
	for item in result:
		for lib in library:
			if lib.id == item.body_id:
				lib_result.append(lib)
			if lib.id == item.eyes_id:
				lib_result.append(lib)
			if lib.id == item.mouth_id:
				lib_result.append(lib)
			if lib.id == item.hat_id:
				lib_result.append(lib)
	return lib_result

func _get_collection_database():
	Singleton.database.query(
		"SELECT * FROM collection;"
	)
	var result = Singleton.database.query_result
	
	return result
	

func _get_collection_library():
	var my_collection = []
	var n = 0
	for item in library:
		for collection in _get_collection_database():
			if collection.item_id == item.id:
				my_collection.append(item)
	
	return my_collection

func _get_all_items_algo():
	
	Singleton.database.query(
		"SELECT id FROM items;"
	)
	
	return Singleton.database.query_result


