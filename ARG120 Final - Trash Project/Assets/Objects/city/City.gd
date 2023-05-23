extends RigidBody2D

@export var max_happiness = 10;
@export var starting_happiness = 10;

@onready var current_happiness = starting_happiness;
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_max_happiness():
	return max_happiness;
	
func get_current_happiness():
	return current_happiness;

func set_max_happiness(val):
	max_happiness = val;
	
func set_current_happiness(val):
	current_happiness = clamp(val, 0, max_happiness);

func add_to_current_happiness(val):
	current_happiness = clamp(current_happiness + val, 0, max_happiness);

func subtract_from_current_happiness(val):
	current_happiness = clamp(current_happiness - val, 0, max_happiness);
