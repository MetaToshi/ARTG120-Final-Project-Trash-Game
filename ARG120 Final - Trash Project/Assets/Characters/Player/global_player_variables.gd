extends Node

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0,1);

#vars for trash cans available for placement

# parameters/Idle/blend_position
@export var starting_money:int = 100;
@onready var current_money: int = starting_money;

func set_money(val):
	current_money = val;
	
func add_money(val):
	current_money += val;
	
func subtract_money(val):
	current_money += -val;
	
func get_money():
	return current_money;



	
@export var max_capacity : int = 5;
@onready var current_trash : int = 0;

func set_max_capacity(val):
	max_capacity = val;
	
func get_max_capacity():
	return max_capacity;


func update_bar():
	var bar = $Bar;
	bar.value = current_trash;
	

#Boolean is whether or not to not include empty cans, True == empty cans will not be included, false == empty cans WILL be included (Use for picking up empty cans)

@export var currently_available_cans : int = 5;
@export var max_available_cans : int = 5;

func subtract_from_current_cans(val):
	currently_available_cans -= val;

func set_current_cans(val):
	currently_available_cans = val;
	
func get_current_cans():
	return currently_available_cans
	
func set_max_cans(val):
	max_available_cans = val;
	
func get_max_cans():
	return max_available_cans;
	
