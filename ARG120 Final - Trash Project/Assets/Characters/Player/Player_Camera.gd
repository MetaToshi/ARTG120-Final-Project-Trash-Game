extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_city_health_visibility(boolean):
	($Town_Health_Bar).visible = boolean;
	
func set_canUI_visibility(boolean):
	($UI_Cans).visible = boolean;
