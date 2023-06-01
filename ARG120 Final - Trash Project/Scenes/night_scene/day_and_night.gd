extends StaticBody2D

@export var length_of_night = 10
var AnimationPlayed = false;

func _ready():
	$ColorRect.color.a = 200
	change_to_day()

func _on_timer_timeout():
	$ColorRect.color.a = 0
	$change_level.start()
	
#	
func _process(delta):
	pass
			
func change_to_day():
	$AnimationPlayer.play("night_to_day")


func _on_change_level_timeout():
	print('checkbeforecorrection', EnemySpawner.shopcorrector)
	if EnemySpawner.shopcorrector > 0:
		EnemySpawner.increase_difficulty(0.5)
		EnemySpawner.shopcorrector -= 1
		print('checkaftercorrection', EnemySpawner.shopcorrector)
	EnemySpawner.increase_difficulty(1)
	get_tree().change_scene_to_file("res://Scenes/day_scene/day_scene.tscn")
