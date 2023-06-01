extends Node2D


@export var spawns: Array[spawnerinfo] = []

@onready var player = get_tree().get_first_node_in_group("city")

var time = 0
var difficulty = 0.5
var wave = 0
var shopcorrector = 0

@onready var timer = get_tree().get_first_node_in_group("spawntimer")

func _ready():
	pass

func _on_timer_timeout():
	difficulty = EnemySpawner.difficulty
	time += 1
	wave += 1
	var howmanyenemy = 1
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if time >= i.time_start and time <= i.time_end:
			if i.spawn_delay_counter < i.enemy_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_enemy = load(str(i.enemy.resource_path))
				if wave <= 10:
					while howmanyenemy > 0:
						var counter = 0
						while counter < i.enemy_num:
							var enemy_spawn = new_enemy.instantiate()
							enemy_spawn.global_position = get_random_position()
							add_child(enemy_spawn)
							counter += 1
							howmanyenemy -= 1
				elif wave > 10:
					print(difficulty)
					while wave > 0:
						var counter = 0
						while counter < i.enemy_num:
							var enemy_spawn = new_enemy.instantiate()
							enemy_spawn.global_position = get_random_position()
							add_child(enemy_spawn)
							counter += 1
						wave -= 5/difficulty
						
					

func get_random_position():
	var vpr = get_viewport_rect().size * 2.5 #determines how far away enemies spawn
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.x - vpr.y)
	var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.x - vpr.y)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.x + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.x + vpr.y/2)
	var pos_side = ["up", "down", "right", "left"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	
	match pos_side:
		"up":
			spawn_pos1 = top_left 
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)

func increase_difficulty(key):
	difficulty += key
	

func decrease_difficulty():
	#print(timer.wait_time)
	#timer.wait_time += 0.1
	#print('ok')
	#print(timer.wait_time)
	pass;
