extends RigidBody2D

@export var max_happiness = 10;
@onready var starting_happiness = GlobalPlayerVariables.current_happiness;;

@onready var current_happiness = GlobalPlayerVariables.current_happiness;;

var city_health_bar = null;
# Called when the node enters the scene tree for the first time.
func _ready():
	city_health_bar = get_parent().get_node("Camera2D").get_node("Town Health Bar");
	city_health_bar.set_max_health(max_happiness);
	city_health_bar.set_current_value(starting_happiness);
	print("City is ", city_health_bar);
	#Replace with function body.
	
	
func update_values():
	max_happiness = GlobalPlayerVariables.current_max_happiness;
	current_happiness = GlobalPlayerVariables.current_happiness;
	
func _on_area_2d_body_entered(body):
	#pass;
	#Temporary collision logic because the timer above appears to not exist
	#print("Collision")
	if ('EnemyCow' in body.name && current_happiness != 0):
		body.queue_free();
		subtract_from_current_happiness(1);	
		#print(current_happiness, "/",max_happiness)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func get_max_happiness():
	return GlobalPlayerVariables.current_max_happiness;
	
func get_current_happiness():
	return GlobalPlayerVariables.current_happiness;

func set_max_happiness(val):
	GlobalPlayerVariables.current_max_happiness = val;
	update_values()
	city_health_bar.set_current_value(current_happiness);
	
func set_current_happiness(val):
	GlobalPlayerVariables.current_happiness = clamp(val, 0, max_happiness);
	update_values()
	city_health_bar.set_current_value(current_happiness);

func add_to_current_happiness(val):
	GlobalPlayerVariables.current_happiness = clamp(current_happiness + val, 0, max_happiness);
	update_values()
	city_health_bar.set_current_value(current_happiness);

func subtract_from_current_happiness(val):
	GlobalPlayerVariables.current_happiness = clamp(current_happiness - val, 0, max_happiness);
	update_values();
	city_health_bar.set_current_value(current_happiness);



