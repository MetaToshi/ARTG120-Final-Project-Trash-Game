extends Node


@export var default_move_speed : float = 100;
@export var default_starting_direction : Vector2 = Vector2(0,1);
@export var default_starting_money : float = 100;
@export var default_max_capacity : int = 5;
@export var default_currently_available_cans : int = 5;
@export var default_max_available_cans : int = 5;
@export var default_starting_trash : int = 0;
@export var default_trash_can_capacity : int = 5;

#City Variables
@export var default_max_city_health : int = 10;
@export var default_starting_city_health : int = 10;

@onready var current_happiness = default_starting_city_health;
@onready var current_max_happiness = default_max_city_health;

@export var default_daily_player_income : int = 80;
@onready var daily_player_income : int = default_daily_player_income;

func RESET_TO_DEFAULT_VALUES():
	move_speed = default_move_speed;
	starting_direction = default_starting_direction;
	
	starting_money = default_starting_money;
	
	current_trash = default_starting_trash;
	max_capacity = default_max_capacity;
	
	currently_available_cans = default_currently_available_cans;
	max_available_cans = default_max_available_cans;
	trash_can_capacity = default_trash_can_capacity;
	
	current_max_happiness = default_max_city_health;
	current_happiness = default_starting_city_health;
	
	daily_player_income = default_daily_player_income;
	
func load_on_night():
	currently_available_cans = max_available_cans;
	current_trash = 0;


var move_speed : float = default_move_speed
var starting_direction : Vector2 = default_starting_direction

var starting_money = default_starting_money;
#vars for trash cans available for placement

# parameters/Idle/blend_position
#@export var starting_money:int = 100;
@onready var current_money: int = default_starting_money;

func set_money(val):
	current_money = val;
	
func add_money(val):
	current_money += val;
	
func subtract_money(val):
	current_money += -val;
	
func get_money():
	return current_money;


@onready var trash_can_capacity = default_trash_can_capacity;



func get_trash_can_capacity():
	return trash_can_capacity;

func set_trash_can_capacity(val):
	trash_can_capacity = val;


	
var max_capacity : int = default_max_capacity;
@onready var current_trash : int = default_starting_trash;

func set_max_capacity(val):
	max_capacity = val;
	
func get_max_capacity():
	return max_capacity;


func update_bar():
	var bar = $Bar;
	bar.value = current_trash;
	

#Boolean is whether or not to not include empty cans, True == empty cans will not be included, false == empty cans WILL be included (Use for picking up empty cans)

@onready var currently_available_cans : int = default_currently_available_cans;
@onready var max_available_cans : int = default_max_available_cans;

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
	
func get_city_happiness():
	return current_happiness

func set_city_happiness(val):
	current_happiness = val;

func get_city_max_happiness():
	return current_max_happiness;
	
func set_city_max_happiness(val):
	current_max_happiness = val;
	
