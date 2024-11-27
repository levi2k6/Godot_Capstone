extends Control
@onready var main_hub = $"../..";
@onready var calendar = $Calendar;
@onready var close = $Calendar/Close;
@onready var grid_container = $Calendar/GridContainer;
@onready var receive_label = $"../Receive_Label";
@onready var timer = $"../../Timer";

var library = [
	{"day": "1", "reward": "20"},
	{"day": "2", "reward": "20"},
	{"day": "3", "reward": "20"},
	{"day": "4", "reward": "20"},
	{"day": "5", "reward": "20"},
	{"day": "6", "reward": "20"},
	{"day": "7", "reward": "40"},
	{"day": "8", "reward": "30"},
	{"day": "9", "reward": "30"},
	{"day": "10", "reward": "30"},
	{"day": "11", "reward": "30"},
	{"day": "12", "reward": "30"},
	{"day": "13", "reward": "30"},
	{"day": "14", "reward": "50"},
	{"day": "15", "reward": "40"},
	{"day": "16", "reward": "40"},
	{"day": "17", "reward": "40"},
	{"day": "18", "reward": "40"},
	{"day": "19", "reward": "40"},
	{"day": "20", "reward": "40"},
	{"day": "21", "reward": "60"},
	{"day": "22", "reward": "50"},
	{"day": "23", "reward": "50"},
	{"day": "24", "reward": "50"},
	{"day": "25", "reward": "50"},
	{"day": "26", "reward": "50"},
	{"day": "27", "reward": "50"},
	{"day": "28", "reward": "99"},
	
	
]


func populate_day_datas(days, redeem_status):
	var i = 0;
	for child in grid_container.get_children():
		child.get_child(0).text = child.name;
		if library[i].day == child.name:
			child.get_child(1).text = library[i].reward;
		i += 1;
	
	if redeem_status == 1:
		for child in grid_container.get_children():
			if child.name == str(days):
				child.self_modulate = "69ff4d";
				break;
			elif child.name.to_int() < days:
				child.self_modulate = "69ff4d";
	elif redeem_status == 0:
		for child in grid_container.get_children():
			if child.name == str(days):
				await animate(child);
				break;
			elif child.name.to_int() < days:
				child.self_modulate = "69ff4d";

func _ready():
	var milestone_data = DataManager._get_milestone_datas();
	var days = milestone_data[0].total_days_played;
	print(days);
	var redeem_status = DataManager._get_status()[0].redeem_status;
	
	if redeem_status == 0:
		visible = true;
		populate_day_datas(days, redeem_status);
		DataManager._update_redeem_status(1);
	elif redeem_status == 1:
		populate_day_datas(days, redeem_status);


func animate(child):
	close.visible = false;
	receive_label.visible = false;
	await animate_calendar();
	await animate_day(child);
	close.visible = true;
	await animate_receive_label(child);
	receive_label.visible = false;


func animate_calendar():
	var first_position = Vector2(calendar.position.x, calendar.position.y + 100);
	var destination = calendar.position;
	calendar.position = first_position;
	calendar.modulate = "ffffff00";
	timer.start(1);
	await timer.timeout;
	var tween = get_tree().create_tween();
	tween.set_trans(Tween.TRANS_CUBIC);
	tween.set_ease(Tween.EASE_OUT);
	tween.tween_property(calendar, "modulate", Color("ffffff"), 1);
	tween.tween_property(calendar, "position", destination, 1.5);
	await tween.finished;
	pass

func animate_day(child):
	var tween = get_tree().create_tween();
	tween.set_trans(Tween.TRANS_LINEAR);
	tween.tween_property(child, "self_modulate", Color("69ff4d"), 2);
	await tween.finished;

func animate_receive_label(child):
	var reward = child.get_child(1).text;
	receive_label.text = "+%s" %reward;
	receive_label.visible = true;
	var tween = get_tree().create_tween();
	tween.set_trans(Tween.TRANS_LINEAR);
	tween.tween_property(receive_label, "position", Vector2(receive_label.position.x, receive_label.position.y - 150), 3.5);
	main_hub.update_money(int(reward));
	await tween.finished;

