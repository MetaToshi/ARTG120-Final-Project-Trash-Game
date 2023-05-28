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
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		#The timer is crashing because it seems to not exist, It may have not been commited
		if $Timer.is_stopped():
			if 'EnemyCow' in collision.get_collider().name:
				$Timer.start()
				print('yeowch!')
				current_trash += 1
				($Bar).set_value_to(current_trash)
	pick_new_state()

func _on_area_2d_body_entered(body):
	pass;
	#None of this will run but it is another trash->player collision logic if the above one never works
	print(body)
	if ('EnemyCow' in body.name && current_trash != max_capacity):
		body.queue_free();
		add_trash(1);	


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
	set_can_frame()
	
@export var max_capacity : int = 5;
@onready var current_trash : int = 0;

func set_max_capacity(val):
	max_capacity = val;
	($Bar).set_max_value(val);
	($Bar).set_value_to(current_trash)
	
func get_max_capacity():
	return max_capacity;

signal trash_updated(current_trash);
signal trash_full()

func get_cans():
	return currently_available_cans;

func get_trash():
	return current_trash;

func place_can():
	currently_available_cans = currently_available_cans - 1;
	set_can_frame()

func set_can_frame():
	($Remaining_Cans_Number).set_frame(currently_available_cans)

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


func update_bar():
	var bar = $Bar;
	bar.value = current_trash;
	

func collides():
	print("Collision!");


@onready var closest_trashcan = null;
func set_closest_trashcan(val):
	closest_trashcan = val;

func get_closest_trashcan():
	return closest_trashcan

var total_near_trashcans = 0;
var touched_trashcans = [];
#func _on_area_2d_area_entered(area):
#	
#	if(area.is_in_group('trashcan')):
#		total_near_trashcans+=1;
#		closest_trashcan = area.get_parent();
#		#Adding to nearby trashcans array
#		print(closest_trashcan);
#		touched_trashcans.append(area.get_parent());


#func _on_area_2d_area_exited(area):
#	if(area.is_in_group('trashcan')):
#		total_near_trashcans-=1;
#		delete_value(area.get_parent())
#		if(total_near_trashcans == 0):
#			closest_trashcan = null;
#		else: 
#			closest_trashcan = touched_trashcans[0];
#		print(closest_trashcan);

@export var pickup_range = 36;

#Boolean is whether or not to not include empty cans, True == empty cans will not be included, false == empty cans WILL be included (Use for picking up empty cans)
func find_closest_can(boolean):
	var cans = get_parent().get_tree().get_nodes_in_group("trashcan");
	if(cans.size() == 0):
		print("none")
		return;
	var changed = false;
	var player = get_parent().get_node("PlayerCat");
	for can in cans:
		
		#Checking if boolean option is enabled, if it is, then dont count the cans with 0 capacity (or the dump)
		if(boolean && (can.get_parent().current_capacity == 0)):
			continue;
		
		#Check if the can is within the pickup range of the player
		if(can.get_parent().global_position.distance_to(player.global_position) < pickup_range):
			#If there is no closest trashcan, then this must be the closest trashcan in range
			if(player.get_closest_trashcan() == null):
				changed = true;
				
				player.set_closest_trashcan(can.get_parent())
			#If there is another trashcan, only overwrite the closest trashcan if it is closer than the other one
			elif(can.get_parent().global_position.distance_to(player.global_position) <= player.get_closest_trashcan().global_position.distance_to(player.global_position)):
				changed = true;
				player.set_closest_trashcan(can.get_parent())
				#print("new close override:", can.get_parent())
		
		if(can.get_parent().is_in_group("dump") && my_distance_to(can.get_parent().global_position, player.global_position) < pickup_range * 1.8):
			if(player.get_closest_trashcan() == null):
				changed = true;
				
				player.set_closest_trashcan(can.get_parent())
			#If there is another trashcan, only overwrite the closest trashcan if it is closer than the other one
			elif(can.get_parent().global_position.distance_to(player.global_position) <= player.get_closest_trashcan().global_position.distance_to(player.global_position)):
				changed = true;
				player.set_closest_trashcan(can.get_parent())
	
	#If no valuse are changed, there must be no nearby trashcan so set it to null
	if(changed == false):
		player.set_closest_trashcan(null)
		#print("No nearby trashcans");

#modified distance_to to reduce the weight of y values in hopes of getting a more "rectangular" shape
func my_distance_to(a, b):
	return sqrt(((b.x - a.x) * (b.x - a.x)) + ( (3 * ((b.y - a.y) * (b.y - a.y)))))


func delete_value(value):
	touched_trashcans.erase(value);
	
func _input(event):
	if(event.is_action_pressed("pickup_trash")):
		find_closest_can(true)
		print("--------------------------------")
		grab_trash_from_closest_can();
	if(event.is_action_pressed("pickup_can")): 
		pickup_empty_can();
		
		
		
	if Input.is_action_just_pressed("place"):
		show_hidden_trashcan();
	if Input.is_action_just_released("place"):
		hide_hidden_trashcan()
		spawner()
		
		#print(player.get_cans())



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
		if(closest_trashcan.get_current_capacity() == 0):
			closest_trashcan = null;
		
		
func pickup_empty_can():
	find_closest_can(false);
	if(closest_trashcan != null && closest_trashcan.is_in_group("dump") == false && closest_trashcan.current_capacity == 0):
		get_parent().remove_child(closest_trashcan);
		closest_trashcan = null;
		set_current_cans(currently_available_cans+1);

func spawner():
	#print("test")
	if(currently_available_cans > 0):
		var obj = preload("res://Assets/Objects/trashcan/Trashcan.tscn").instantiate()
		obj.position = get_global_mouse_position()
		get_parent().add_child(obj)
		subtract_from_current_cans(1);
		


var current_hidden_trashcan = null;
func show_hidden_trashcan():
	if(current_hidden_trashcan != null):
		hide_hidden_trashcan();

	current_hidden_trashcan = preload("res://Assets/Objects/trashcan/faded trashcan/faded_trashcan.tscn").instantiate();
	current_hidden_trashcan.position = get_global_mouse_position();
	get_parent().add_child(current_hidden_trashcan);

func hide_hidden_trashcan():
	get_parent().remove_child(current_hidden_trashcan);
	current_hidden_trashcan = null;
	pass



func subtract_from_current_cans(val):
	currently_available_cans -= val;
	set_can_frame()

func set_current_cans(val):
	currently_available_cans = val;
	set_can_frame()
	
func get_current_cans():
	return currently_available_cans
	
func set_max_cans(val):
	max_available_cans = val;
	
func get_max_cans():
	return max_available_cans;
	
