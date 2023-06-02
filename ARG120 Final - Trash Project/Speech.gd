extends Node2D

var bubble_text 
var bubble_text_length = 0;
var bubble_text_index = 0
var current_text = ""

@onready var lbltext = get_node("VBoxContainer/Label")
@onready var ninerect = get_node("VBoxContainer/Label/NinePatchRect")
@onready var timer = get_node("Timer")
@onready var trashtalker = get_node("day_scene/ParallaxBackground/ParallaxLayer2")

var do_close = false
var rng = RandomNumberGenerator.new()
var pos


func _ready():
	lbltext.get_parent().hide()
	bubble_text = setRandomDialogue()
	bubble_text_length = bubble_text.length()
	timer.start(5.5)
	pass

func _on_timer_timeout():
	if(!do_close):
		lbltext.get_parent().show()
		current_text += bubble_text[bubble_text_index]
		lbltext.text = current_text
		
		if(bubble_text_index < bubble_text_length -1):
			timer.start(.01)
			bubble_text_index += 1
		else:
			if(!do_close):
				do_close = true
				timer.start(3.5)
	else:
		do_close = false
		timer.start(6.5)
		bubble_text = setRandomDialogue()
		bubble_text_length = bubble_text.length()
		bubble_text_index = 0
		current_text = ""
		#lbltext.get_parent().hide()
#		queue_free()

func setRandomDialogue():
	var dialogue_num = rng.randi_range(1,11)
	var chosen_string = ""
	match dialogue_num:
		1:
			chosen_string = "Don’t wanna end up like that trash man"
		2:
			chosen_string = "You should have stayed in school."
		3:
			chosen_string = "Eww, you stink"
		4:
			chosen_string = "You're not worth my time."
		5:
			chosen_string = "Nice mustache you scab."
		6:
			chosen_string = "My life could be worse, it could be as bad as yours..."	
		7:
			chosen_string = "Gross"
		8:
			chosen_string = "Get a real job"
		9:
			chosen_string = "Support Workers Rights!"
		10:
			chosen_string = "UNIONIZE!"
		11:
			chosen_string = "Utilities should be publicly owned!"
	return chosen_string

func _update():
	pass

