extends HBoxContainer



func working():
	print("working");

func initialize_game_data(datas: Dictionary):
	$VBoxContainer/Label.text = datas.name;
	$VBoxContainer/TextureRect.texture = datas.texture;
	$ProgressBar.value = datas.percent;

