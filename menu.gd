extends Control

func _ready():
	$AnimationPlayer.play("intro")

func _on_quit_pressed():
	get_tree().quit()
	
	

func _on_start_pressed():
	$AnimationPlayer.play("outro")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_options_pressed():
	$keys.visible=true


func _on_button_pressed():
	$keys.visible = false
