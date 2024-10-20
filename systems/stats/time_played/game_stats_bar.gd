extends HBoxContainer



func working():
	print("working");

func initialize_game_data(datas: Dictionary):
	$VBoxContainer/Label.text = datas.name;
	$VBoxContainer/HBoxContainer/TextureRect.texture = datas.texture;
	$VBoxContainer/HBoxContainer/ProgressBar.value = datas.percent;

