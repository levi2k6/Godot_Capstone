extends Node2D

@onready var main_hub_button = $Control/Buttons/Main_Hub_Button;
@onready var create_child_button = $Control/Buttons/Create_Child_Button;
@onready var create_pet_button = $Control/Buttons/Create_Pet_Button;
@onready var title = $Control/Title;
@onready var buttons = $Control/Buttons;

func _ready():
	_execute()
	pass

func _execute():
	var child = DataManager._get_child_database();
	#print_debug(child);
	var pet_equip = ItemLibrary._get_pet_equip_library();
	GameData.last_scene = get_tree().current_scene.get_scene_file_path();
	animation(child, pet_equip);

func animation(child, pet_equip):
	var timer = title.get_child(4);
	var animation_player_title = title.get_child(0);
	var animation_player_button = buttons.get_child(0);
	
	timer.start(1);
	await timer.timeout;
	animation_player_title.play("back_mini_pet");
	await animation_player_title.animation_finished;
	animation_player_title.play("bit_buddy");
	await animation_player_title.animation_finished;
	
	if child.size() == 0:
		main_hub_button.visible = false
		create_child_button.visible = true
		create_pet_button.visible = false
		animation_player_button.play("create_child_button_up");
	elif pet_equip.size() < 3:
		main_hub_button.visible = false
		create_child_button.visible = false
		create_pet_button.visible = true
		animation_player_button.play("create_pet_button_up");
	else:
		main_hub_button.visible = true
		create_child_button.visible = false
		create_pet_button.visible = false
		animation_player_button.play("main_hub_button_up");
