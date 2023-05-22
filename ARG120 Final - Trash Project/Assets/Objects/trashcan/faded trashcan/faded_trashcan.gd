extends Sprite2D

@export var is_visible = true;

func make_visible():
	is_visible = true;
	visible = true;
	
func make_invisible():
	is_visible = false;
	visible = false;
	
func get_visibility():
	return is_visible;

func _ready():
	modulate.a = 0.4
	visible = is_visible;

func _process(_delta):
	position = get_global_mouse_position();
