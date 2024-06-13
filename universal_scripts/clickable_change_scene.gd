extends Button



func _ready():
	text = name
	pass


func _on_pressed():
	if name == "Collection_Button":
		get_tree().change_scene_to_file("res://systems/collection/collection.tscn")
	elif name == "Shop_Button":
		get_tree().change_scene_to_file("res://systems/shop/shop.tscn")
	elif name == "Main_Hub_Button":
		get_tree().change_scene_to_file("res://systems/main_hub/world.tscn")
	pass # Replace with function body.
