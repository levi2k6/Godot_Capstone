extends Button

var clickable = false
var this_item;

func _item_texture(item, naym):
	get_child(0).texture = item.texture
	this_item = item
	
	if naym == "Body_Items":
		var child_id = GameData.current_child_id;
		var color = ItemLibrary._get_pet_equip_library(child_id)[4].name
		get_child(0).self_modulate = color
		
	if naym == "Eyes_Items":
		get_child(0).hframes = 9
		get_child(0).vframes = 1
		get_child(0).frame = 2
	if naym == "Mouth_Items":
		get_child(0).hframes = 15
		get_child(0).vframes = 1
		get_child(0).frame = 2
	if naym == "Color_Items":
		get_child(0).self_modulate = item.name


func _on_pressed():
	SoundPlayer.button_sfx();
	get_parent()._get_item(this_item)
	pass # Replace with function body.
