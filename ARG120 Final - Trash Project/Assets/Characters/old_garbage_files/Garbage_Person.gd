extends CharacterBody2D
@export var move_speed : float = 100;
@export var garbage_capacity : int = 10;

var Garbage_Person = load("res://Assets/Characters/Garbage_Person.tscn")
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
	if Input.is_action_pressed("place"):
		#place_can()
		print(Garbage_Person.position)
		

func place_can():
	#var can = load("res://Assets/Characters/garbage_can.tscn")
	#var can_instance = can.instantiate()
	#var can_location = Garbage_Person.position
	print(Garbage_Person.position)
	#can_instance.position = can_location
	#add_child(can_instance)
