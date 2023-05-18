extends CharacterBody2D
@export var move_speed : float = 100;

#func _ready():
	#update_animation_parameters(starting_direction)
func _physics_process(_delta):
	

	var input_direction = Vector2(
	Input.get_action_strength("right") - Input.get_action_strength("left"),
	Input.get_action_strength("down") - Input.get_action_strength("up"),

	)
	#update_animation_parameters(input_direction)
	
	velocity = input_direction * move_speed
	
	move_and_slide()

