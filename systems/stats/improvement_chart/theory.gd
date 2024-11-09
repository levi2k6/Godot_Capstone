extends Node;

var datas = 100;
var length = 450;

func _ready():
	pass

func length_check():
	var times_amount = length / 450;
	var times_modulo =  length % 450;
	if times_modulo != 0:
		print(times_modulo);
		return;
	
	var range = 20 * times_amount;
	count_maker(range);

func count_maker(range):
	var range_times = 0;
	var b = 0;
	if datas < range:
		for i in range(1, range+1):
			print(i)
		return;
	
	for i in range(1, range+1):
		range_times += range;
		if datas <= range_times:
			print(range_times);
			for a in range(1, range+1):
				b+=i;
				print(b);
			return
		
	
	
