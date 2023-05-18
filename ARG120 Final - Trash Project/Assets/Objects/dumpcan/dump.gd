extends RigidBody2D

signal current_capacity_increased(current_capacity);
signal full();

@export var starting_capacity: int = 2;
@export var max_capacity : int = 5;

@export var full_radius : float = 34;
@onready var current_capacity = starting_capacity;



func get_dump():
	var parent = ($Area2D).get_parent();
	return parent;

func _ready():
	var a2d = $Area2D;
	a2d.add_to_group("trashcan");
	($Area2D/CollisionShape2D).shape.radius = full_radius;

func _set_current_capacity(_val):
	print("Setting capacity of Dump object. It has infinite capacity so this does nothing. (Or should it be changed?) - Wyatt");
	assert(false)
	pass
		
func on_full():
	print("Trash is full");
	
func remove_trash(_num):
	print("Cannot remove any trash from the dump zone. (Or should it be changed?) - Wyatt");
	assert(false)
	pass
	
	
#on_empty_action runs whenever the player dumps their trash, probably where we should put an animation
func on_empty_action():
	pass

func fill(val):
	_set_current_capacity(current_capacity + val);


func update_circle():
	#Where you can implement a change in the interactive radius
	pass

func _on_area_2d_body_entered(_body):
	pass;
	
