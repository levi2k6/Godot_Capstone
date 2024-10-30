extends HBoxContainer
@onready var label = $VBoxContainer/Label;
@onready var texture_rect = $VBoxContainer/HBoxContainer/TextureRect;
@onready var type = $VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Type;
@onready var progress_bar = $VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/ProgressBar;
@onready var number = $VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/ProgressBar/Number


func working():
	print("working");

func initialize_game_data(datas: Dictionary):
	label.text = datas.name;
	texture_rect.texture = datas.texture;
	type.text = datas.type;
	progress_bar.value = datas.percent;
	number.text = str(datas.count);


func add_game_image(texture: Texture2D):
	$VBoxContainer/HBoxContainer/TextureRect.texture = texture;
