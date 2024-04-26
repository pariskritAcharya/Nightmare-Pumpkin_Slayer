extends Control


@onready var menu = $"../../"
@onready var main_menu = preload("res://menu.tscn")
func _on_resume_pressed():
	menu.pauseMenu()


func _on_back_pressed():
	menu.pauseMenu()
	get_tree().change_scene_to_file("res://menu.tscn")
	
