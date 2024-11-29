extends Node2D
@onready var pet = $Control/Foreground/Pet_Control/Pet;
@onready var pet_name = $Control/Foreground/Pet_Control/Pet_Name;
@onready var hunger_bar = $Control/UI/Info/Hunger/Hunger_Bar;
@onready var transition_layer = $Transition_Layer


func get_transition_layer():
	return transition_layer;


func _ready():
	SoundPlayer.play_bgm_music();
	_connections();
	_triggers();
	GameData.last_scene = get_tree().current_scene.get_scene_file_path();
	pet_name.text = DataManager._get_pet_database()[0].name;

func _connections():
	pet.connect("update_hunger", update_hunger)
	pass

func _triggers():
	pet.update_hunger_bar()

func update_hunger():
	var pet_hunger = DataManager._get_pet_database()[0].hunger
	hunger_bar.value = pet_hunger



@onready var calendar_modal = $Control/Calendar_Modal
@onready var receive_label = $Control/Receive_Label


func _on_daily_reward_pressed():
	SoundPlayer.button_sfx();
	calendar_modal.visible = true;
	receive_label.visible = false;
	pass # Replace with function body.
	

func _on_close_pressed():
	SoundPlayer.button_sfx();
	calendar_modal.visible = false;
	pass # Replace with function body.


@onready var money_count = $Control/UI/Info/Money;

func update_money(add):
	var money = DataManager._get_money_database()[0].money;
	var money_added = money + add;
	DataManager._update_money_database(money_added);
	DataManager._update_milestone_total_money_earned(add);
	print(add);
	money_count._display_money();
