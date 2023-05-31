extends Label
var countdown = false
func _ready():
	set_text(str(int($cleanup_timer.get_time_left())))

func toggle_visibility() -> void:
	visible = not visible

func _on_round_timer_timeout():
	$cleanup_timer.start()
	toggle_visibility()
	countdown = true


func _on_cleanup_timer_timeout():
	pass # Replace with function body.

func _process(_delta):
	if(countdown):
		
		set_text(str(int($cleanup_timer.get_time_left())))
