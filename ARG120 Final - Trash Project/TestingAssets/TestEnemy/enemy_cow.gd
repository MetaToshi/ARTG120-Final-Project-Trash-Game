extends CharacterBody2D

@export var move_speed : float = 20

@export var movement_target: Node2D
@export var navigation_agent: NavigationAgent2D

func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")
	
func actor_setup():
	await get_tree().physics_frame
	navigation_agent.target_position = Vector2(get_tree().get_first_node_in_group("dump").position.x,get_tree().get_first_node_in_group("dump").position.y)
	
@onready var animation_tree = $AnimationTree
@onready var sprite = $Sprite2D


func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * move_speed
	
	velocity = new_velocity
	
	if (velocity.x < 0):
		sprite.flip_h = true
	elif(velocity.x > 0):
		sprite.flip_h = false
		
	move_and_slide()
