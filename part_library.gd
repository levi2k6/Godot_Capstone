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

var collections = [
	3,4,5,7
]



func _ready():  
	
	_append_library()




func _append_library():
	print("working")
	Singleton.database.query(
		"SELECT * FROM parts;"
	)
	var parts = Singleton.database.query_result
	var n = 0
	for lib in library:
		lib.id = parts[n].id
		lib.name = parts[n].name
		lib.type = parts[n].type
		n += 1
		
	#print(library)




func _id_to_library_data(ids):
	var dictionaries = []
	
	for part in library:
		for id in ids:
			#print(collection," ", part.id)
			if id == part.id:
				dictionaries.append(part)
				
	
	return dictionaries


func _get_collection_database():
	Singleton.database.query(
		"SELECT * FROM collection;"
	)
	var result = Singleton.database.query_result
	return result
	

func _get_collection_library():
	var my_collection = []
	
	for part in library:
		
		for collection in _get_collection_database():
			#print(collection," ", part.id)
			if collection.part_id == part.id:
				my_collection.append(part)
				
		
	#print(my_collection)
	
	
	
	return my_collection

func _get_all_parts_algo():
	
	Singleton.database.query(
		"SELECT id FROM parts;"
	)
	
	return Singleton.database.query_result

func _get_shop_parts():
	
	pass
