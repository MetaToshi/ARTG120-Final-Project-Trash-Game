extends RigidBody2D

signal current_capacity_increased(current_capacity);
signal full();

@export var starting_capacity: int = 2;
@export var max_capacity : int = 5;

@export var full_radius : float = 34;
@export var empty_radius : float = 5;

@onready var current_capacity = starting_capacity;



func get_trashcan():
	var parent = ($Area2D).get_parent();
	return parent;
	
func get_current_capacity():
	return current_capacity;
	
func get_full_radius():
	return full_radius;

func _ready():
	var a2d = $Area2D;
	a2d.add_to_group("trashcan");
	($Bar).set_max_value(max_capacity);
	($Bar).set_value_to(current_capacity);
	($Area2D/CollisionShape2D).shape.radius = full_radius;

func _set_current_capacity(val):
	var prev = current_capacity;
	current_capacity = clamp(val, 0 , max_capacity);
	($Bar).set_value_to(current_capacity);
	update_circle()
	
	if(prev != current_capacity):
		emit_signal("current_capacity_increased", current_capacity);
	if(current_capacity >= max_capacity):
		on_full();
		emit_signal("full", current_capacity);
		
func on_full():
	print("Trash is full");
	
func remove_trash(num):
	#num = 1;
	if(current_capacity == 0):
		return 0
	var prev = current_capacity;
	_set_current_capacity(current_capacity - num);
	print("trash capacity is now ", current_capacity);
	return prev - current_capacity;

func fill(val):
	_set_current_capacity(current_capacity + val);

@onready var bar  = $Bar;

func update_circle():
	if(current_capacity == 0):
		($Area2D/CollisionShape2D).shape.radius = empty_radius;
	else:
		($Area2D/CollisionShape2D).shape.radius = full_radius;

func _on_area_2d_body_entered(_body):
	pass;
	
