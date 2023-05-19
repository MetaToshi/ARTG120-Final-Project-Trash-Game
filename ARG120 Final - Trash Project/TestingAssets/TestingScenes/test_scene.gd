extends Node2D
#@export var Trashcan : PackedScene
var trashcan
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	trashcan = get_node("Trashcan")
	player = get_node("PlayerCat")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("place"):
		spawner()
		print(player.get_cans())
		


func spawner():
	#print("test")
	if(player.get_cans() > 0):
		var obj = preload("res://Assets/Objects/trashcan/Trashcan.tscn").instantiate()
		obj.position = get_global_mouse_position()
		add_child(obj)
	#player.place_can();
	
