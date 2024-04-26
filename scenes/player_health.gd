extends TextureProgressBar
var health = 3
func _ready():
	update()

func _process(delta):
	if Global.player_health != health:
		health = Global.player_health
		update()


func update():
	value = Global.player_health*100/3
