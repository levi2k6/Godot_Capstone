extends Control

var rng = RandomNumberGenerator.new();
var level = 1;

func start():
	print("start working");
	var label_num = "";
	
	for i in range(level):
		var rand_int = str(rng.randi_range(0,9));
		label_num += rand_int;
		print(rand_int);
	$Label.text = label_num;
	

func compare():
	if $TextEdit.text == $Label.text:
		print("THEY ARE THE SAME NUMBER!");
		difficulty_up();
	

func difficulty_up():
	level += 1;
	start();


func _on_submit_button_up():
	compare();
	pass # Replace with function body.
