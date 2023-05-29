extends Control

func set_text(new_text):
	$TextEdit.text = "$ "+ new_text

func get_text():
	return $TextEdit.text
