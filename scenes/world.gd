extends Node2D

@onready var pause_menu = $CanvasLayer/pause_menu
var paused = false
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
		
func _ready():
	$AnimationPlayer.play("intro")
	await get_tree().create_timer(1).timeout
	Global.score = 0
	Global.sleep_meter=5
	Global.player_health=3
	

	
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused



