extends HBoxContainer
@onready var label = $VBoxContainer/Label;
@onready var texture_rect = $VBoxContainer/HBoxContainer/TextureRect;
@onready var type = $VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Type;
@onready var session = $VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Session;
@onready var progress_bar = $VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/ProgressBar;
@onready var number = $VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/ProgressBar/Number;
@onready var button = $VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Button

var parent;

func _ready():
	number_position();

func working():
	print("working");
	

func initialize_game_data(datas: Dictionary):
	label.text = datas.name;
	label.self_modulate = datas.color;
	texture_rect.texture = datas.texture;
	type.text = "Type: " + datas.type;
	change_info_visible_all(datas.visible_state);
	progress_bar.value = datas.percent;
	progress_bar.modulate = datas.color;
	number.text =  "%s%%" %progress_bar.value;
	number_position();
	session.text = "Session: " + str(datas.count);
	
	#for game in parent.games_library:
		#if label.text == game.name:
			#print(game.name, ": " , game.visible_state);


func number_position():
	var percent_position;
	if progress_bar.value == 100:
		percent_position = 1;
	elif progress_bar.value <= 9:
		percent_position = float("0.0%s"%progress_bar.value);
	else:
		percent_position = float("0.%s"%progress_bar.value);
	
	var number_position: float = progress_bar.custom_minimum_size.x * percent_position; 
	var add = 10;
	
	if progress_bar.value == 100:
		add = 5;
	elif progress_bar.value <= 50:
		add = 18;
	number.position.x = number_position + add;


func add_game_image(texture: Texture2D):
	$VBoxContainer/HBoxContainer/TextureRect.texture = texture;

func change_info_visible_all(visible_state):
	type.visible = visible_state;
	session.visible = visible_state;

func _on_button_button_down():
	for game in parent.games_library:
		if label.text == game.name:
			#print(game.name, " BUTTON: " , game.visible_state);
			game.visible_state = !game.visible_state;
			#print(game.name, " CHANGED: " , game.visible_state);
			type.visible = game.visible_state;
			session.visible = game.visible_state;
		
	parent.check_if_all_same_state();
	pass # Replace with function body.

func disable_button():
	button.disabled = true;
func activate_button():
	button.disabled = false;
