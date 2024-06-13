extends Control



const ASSET_1 = preload("res://scenes/Games/Number_Memory/asset1.tscn")


func _ready():
	_create_num()



func _create_num():
	var create_asset1 = ASSET_1.instantiate()
	get_child(0).add_child(create_asset1)
	
