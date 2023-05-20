extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0,1);

#vars for trash cans available for placement
@export var currently_available_cans : int = 5;
@export var max_available_cans : int = 5;

# parameters/Idle/blend_position

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")


func _physics_process(_delta):
	# Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	update_animation_parameters(input_direction)
	# update Velocity
	velocity = input_direction * move_speed;
	move_and_slide()
	pick_new_state()


func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
################################################################################

func _ready():
	animation_tree.set("parameters/Idle/blend_positiona", starting_direction)
	($Bar).set_max_value(max_capacity)
	($Bar).set_value_to(current_trash)
	
@export var max_capacity : int = 5;
@onready var current_trash : int = 0;

signal trash_updated(current_trash);
signal trash_full()

func get_cans():
	return currently_available_cans;

func get_trash():
	return current_trash;

func place_can():
	currently_available_cans = currently_available_cans - 1;



func _set_trash(val):
	var prev = current_trash;
	current_trash = clamp(val, 0, max_capacity);
	($Bar).set_value_to(current_trash);
	if(current_trash != prev ):
		emit_signal("trash_updated", current_trash);
		if(current_trash == max_capacity):
			full();
			emit_signal("trash_full");

func add_trash(val):
	_set_trash(current_trash + val);
	print("Player capacity is now ", current_trash)

func full():
	pass

func pickup(value):
	add_trash(value);


func _on_area_2d_body_entered(_body):
	print("Entered player zone!");

func update_bar():
	var bar = $Bar;
	bar.value = current_trash;
	

func collides():
	print("Collision!");


@onready var closest_trashcan = null;

var total_near_trashcans = 0;
var touched_trashcans = [];
func _on_area_2d_area_entered(area):
	
	if(area.is_in_group('trashcan')):
		total_near_trashcans+=1;
		closest_trashcan = area.get_parent();
		#Adding to nearby trashcans array
		print(closest_trashcan);
		touched_trashcans.append(area.get_parent());


func _on_area_2d_area_exited(area):
	if(area.is_in_group('trashcan')):
		total_near_trashcans-=1;
		delete_value(area.get_parent())
		if(total_near_trashcans == 0):
			closest_trashcan = null;
		else: 
			closest_trashcan = touched_trashcans[0];
		print(closest_trashcan);

func delete_value(value):
	touched_trashcans.erase(value);
	
func _input(event):
	if(event.is_action_pressed("pickup_trash")):
		print("--------------------------------")
		grab_trash_from_closest_can();



func grab_trash_from_closest_can():
	if(closest_trashcan != null):
		if(closest_trashcan.is_in_group('dump')):
			#Player is closest to the dump, so dump inventory
			print("Depositing trash")
			closest_trashcan.on_empty_action();
			_set_trash(0);
			return
		
		print("removing trash from can")
		var removed = closest_trashcan.remove_trash(max_capacity - current_trash);
		add_trash(removed);
		

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
