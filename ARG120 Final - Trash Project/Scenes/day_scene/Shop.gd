extends Control
var player;

func _ready():
	player = get_node("PlayerCat")

func _on_playercanupgrade_pressed():
	var cur = 10
	player.set_max_cans(cur)



func _on_playerheldupgrade_pressed():
	pass # Replace with function body.
