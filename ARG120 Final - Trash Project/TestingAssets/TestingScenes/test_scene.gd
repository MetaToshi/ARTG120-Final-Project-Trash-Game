extends Node2D
#@export var Trashcan : PackedScene
var trashcan


# Called when the node enters the scene tree for the first time.
func _ready():
	trashcan = get_node("Trashcan")
	#add_child(trashcan)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("place"):
		spawner()
		


func spawner():
	#print("test")
	var obj = preload("res://Assets/Objects/trashcan/Trashcan.tscn").instantiate()
	obj.position = get_global_mouse_position()
	add_child(obj)
