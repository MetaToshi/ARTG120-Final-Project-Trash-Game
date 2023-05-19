extends Node2D

var can = load("res://Assets/Objects/trashcan/Trashcan.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("test")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("test")
	spawner(can)

func spawner(spawn_object):
	print("test")
	if Input.is_action_just_pressed("mouse_click"):
		var obj = spawn_object.instance()
		obj.position = get_global_mouse_position()
		add_child(obj)
