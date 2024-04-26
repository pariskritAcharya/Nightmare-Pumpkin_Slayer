extends Marker2D

var enemy_scene = preload("res://scenes/enemy.tscn")
var time = 5

func _ready():
	$Timer.start(time)

func _process(delta):
	if Global.score >10 and Global.score<=20:
		time = 3
	elif Global.score >20 and Global.score<=40:
		time = 2
	elif Global.score >40:
		time = 1
	else:
		time =5

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.global_position = self.global_position
	get_parent().add_child(enemy)

func _on_timer_timeout():
	spawn_enemy()
	$Timer.start(time)
