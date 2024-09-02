extends Node2D


var library = ItemLibrary.library;

func _get_pet_equip_library():
	Singleton.database.query(
		"SELECT * FROM  pet;"
	)
	var equip = Singleton.database.query_result
	var lib_result = []
	
	for item in equip:
		for lib in library:
			if lib.id == item.body_id:
				lib_result.append(lib)
				#break
			elif lib.id == item.eyes_id:
				lib_result.append(lib)
				#break
			elif lib.id == item.mouth_id:
				lib_result.append(lib)
				#break
			elif lib.id == item.hat_id:
				lib_result.append(lib)
				#break
			elif lib.id == item.color_id:
				lib_result.append(lib)
	return lib_result





func _on_button_pressed():
	print(_get_pet_equip_library())
	
