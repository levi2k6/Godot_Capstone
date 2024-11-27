extends Node2D

@onready var timer = $Timer

@onready var animator = $Animator
@onready var animator_title = $Control/Title/Animator_Title;
@onready var animator_buttons = $Control/Buttons/Animator_Buttons;

@onready var title = $Control/Title;
@onready var buttons = $Control/Buttons;
@onready var transition_layer = $Transition_Layer


@onready var main_hub_button = $Control/Buttons/Main_Hub_Button;
@onready var create_child_button = $Control/Buttons/Create_Child_Button;
@onready var create_pet_button = $Control/Buttons/Create_Pet_Button;




func get_transition_layer():
	return transition_layer;

func _ready():
	_execute()
	pass

func _execute():
	var child = DataManager._get_child_database();
	#print_debug(child);
	var pet = DataManager._get_pet_database();
	GameData.last_scene = get_tree().current_scene.get_scene_file_path();
	animation(child, pet);

func animation(child, pet):
	await animator.title_animation()
	
	print(child);
	print(pet);
	
	
	if child.size() == 0:
		print_debug("child does not exist");
		show_button("child");
		return;
	
	if pet.size() == 0:
		print_debug("pet does not exist");
		show_button("pet");
		return;
	
	if child[0].fname == "" || child[0].lname == "":
		print_debug("child is nameless");
		show_button("child");
		return;
	
	if pet[0].name == "":
		print_debug("pet is nameless")
		show_button("pet");
		return;
	
	show_button("else");


func show_button(button_state):
	if button_state == "child":
		main_hub_button.visible = false
		create_child_button.visible = true
		create_pet_button.visible = false
		animator_buttons.play("create_child_button_up");
	elif button_state == "pet":
		main_hub_button.visible = false
		create_child_button.visible = false
		create_pet_button.visible = true
		animator_buttons.play("create_pet_button_up");
	else:
		main_hub_button.visible = true
		create_child_button.visible = false
		create_pet_button.visible = false
		animator_buttons.play("main_hub_button_up");
