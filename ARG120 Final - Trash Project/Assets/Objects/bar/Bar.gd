extends Control

@onready var bar_over = $BarOver;
@onready var bar_under = $BarUnder;

@export var near_empty_color = Color.GREEN;
@export var mid_color = Color.YELLOW;
@export var full_color = Color.RED;

@export var pulse_color = Color.DARK_RED;
@export var will_pulse = false;

@export var mid_breakpoint = 0.75;
@export var empty_breakpoint = 0.41;

#@onready var update_tween = bar_under.create_tween();
#@onready var pulse_tween = bar_over.create_tween().set_loops(-1);

func set_value_to(value):
	bar_over.value = value;
	bar_under.value = value;
	_assign_color(value);
	#update_tween.interpolate_value(bar_under, "value", bar_under.value, value, 0.4, Tween.TRANS_SINE, 0.4);
	#update_tween.start();
	
	#temporary until the animation works
	
func _assign_color(value):
	
	#bar_under.value(value)
	if(value < bar_over.max_value * empty_breakpoint):
		bar_over.tint_progress = near_empty_color;
		
	elif(value < bar_over.max_value * mid_breakpoint):
		bar_over.tint_progress = mid_color;
		#pass
	else:
		#pass
		bar_over.tint_progress = full_color;
		#if(will_pulse):
			#pulse_tween.interpolate_property(bar_over, "tint_progress", pulse_color, full_color, 1.2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			#pulse_tween.start();
		#bar_under.value(value)
	
	
#func _on_max_value_updated(maximum):
#	bar_over.max_value = maximum;

func set_max_value(val):
	bar_over.max_value = val;
	bar_under.max_value = val;
	

