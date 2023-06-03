extends RigidBody2D

func _ready():
	var x = randi_range(0,10);
	if(x < 5):
		$Sprite2D.texture = load("res://Assets/Sprites/Flora/120 - NightBush1.png")
	else:
		$Sprite2D.texture = load("res://Assets/Sprites/Flora/120 - NightBush2.png")
