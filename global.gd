extends Node

var sleep_meter = 5
var score = 0
var player_health = 3
var highscore = 0
func _process(delta):
	if score > highscore:
		highscore = score
