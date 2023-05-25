extends StaticBody2D

@export var length_of_night = 10
var AnimationPlayed = false;

func _ready():
	$ColorRect.color.a = 200

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/day_scene/day_scene.tscn")
#	
func _process(delta):
	change_to_day()
			
func change_to_day():
	$AnimationPlayer.play("night_to_day")
