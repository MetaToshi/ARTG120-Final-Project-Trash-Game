extends Control

var num_cans_remaining = 0;
 
func set_frame(val):
	if(val > 6):
		val = 6;
	$Sprite2D.frame = val;
