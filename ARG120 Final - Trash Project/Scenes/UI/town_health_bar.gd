extends Control


func set_max_health(val):
	$prog_bar.max_value = val;
	_on_progress_bar_value_changed($prog_bar.value);
	
func get_max_value():
	return $prog_bar.max_value;
	
func set_current_value(val):
	$prog_bar.value = val;
	_on_progress_bar_value_changed($prog_bar.value);
	
func get_current_value():
	return $prog_bar.value;

func add_to_current_value(val):
	set_current_value($prog_bar.value + val);
	_on_progress_bar_value_changed($prog_bar.value);
	



var full_color_breakpoint = 0.75;
var mid_break_point = .30;
@export var fullColor = Color("#1cba29");
@export var medColor = Color("#bc9400");
@export var emptyColor = Color("#d20035");
func _on_progress_bar_value_changed(value):
	#Updating the bars color
	var v = $prog_bar.value;
	var m = $prog_bar.max_value;
	var ratio = v/m;
	

	if(ratio >= 0.75):
		set_color(fullColor)
		
	elif(ratio >= mid_break_point):
		set_color(medColor)
	else:
		set_color(emptyColor)

func set_color(color):
	var sb = StyleBoxFlat.new();
	($prog_bar).add_theme_stylebox_override("fill", sb);
	sb.bg_color = Color(color);
	sb.corner_radius_top_left = 25;
	sb.corner_radius_top_right = 50;
	sb.corner_radius_bottom_left = 25;
	sb.corner_radius_bottom_right = 50;
