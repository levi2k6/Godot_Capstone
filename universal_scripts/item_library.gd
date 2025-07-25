extends Node
var library = [
	{"texture":preload("res://assets/body/body1.png"), "id":0, "name":	"", "type": ""},
	{"texture":preload("res://assets/body/body2.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body3.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body4.png"), "id":0, "name":	"", "type": ""},
	{"texture":preload("res://assets/body/body5.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body6.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body7.png"), "id":0, "name":	"", "type": ""},
	{"texture":preload("res://assets/body/body8.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body9.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body10.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/face/eyes/eyes1-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/eyes/eyes2-Sheet.png"), "id":0, "name": "", "type": ""  },
	{"texture":preload("res://assets/face/eyes/eyes3-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/eyes/eyes4-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/eyes/eyes5-Sheet.png"), "id":0, "name": "", "type": ""  },
	{"texture":preload("res://assets/face/eyes/eyes6-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/eyes/eyes7-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/eyes/eyes8-Sheet.png"), "id":0, "name": "", "type": ""  },
	{"texture":preload("res://assets/face/eyes/eyes9-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/eyes/eyes10-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/mouth/mouth1-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/mouth/mouth2-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/mouth/mouth3-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/mouth/mouth4-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/mouth/mouth5-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/mouth/mouth6-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/mouth/mouth7-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/mouth/mouth8-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/mouth/mouth9-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/face/mouth/mouth10-Sheet.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/hat/hat1.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/hat/hat2.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/hat/hat3.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/hat/hat4.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/hat/hat5.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/hat/hat6.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/hat/hat7.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/hat/hat8.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/hat/hat9.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/hat/hat10.png"), "id":0, "name": "", "type": "" },
	{"texture":preload("res://assets/body/body3.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body3.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body3.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body3.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body3.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body3.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body3.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body3.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body3.png"), "id":0, "name": "", "type": ""},
	{"texture":preload("res://assets/body/body3.png"), "id":0, "name": "", "type": ""},
	]

func _ready():
	_append_library()

func _append_library():
	#print("working")
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


func _get_pet_equip_library(id):
	Singleton.database.query(
		"SELECT * FROM  pet WHERE id = %s;"%id
	);
	var equip = Singleton.database.query_result
	var lib_result = [null, null, null, null, null];
	
	for item in equip:
		for lib in library:
			if lib.id == item.body_id:
				lib_result[0] = lib;
				#break
			elif lib.id == item.eyes_id:
				lib_result[1] = lib;
				#break
			elif lib.id == item.mouth_id:
				lib_result[2] = lib;
				#break
			elif lib.id == item.hat_id:
				lib_result[3] = lib;
				#break
			elif lib.id == item.color_id:
				lib_result[4] = lib;
	return lib_result

func _get_collection_library():
	var collection_database = DataManager._get_collection_database(GameData.current_child_id);
	var my_collection = []
	for item in library:
		for collection in collection_database:
			if collection.item_id == item.id:
				my_collection.append(item)
				break
			#print(collection)
	
	return my_collection




