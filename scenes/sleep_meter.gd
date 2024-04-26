extends TextureProgressBar

var sleep = 5
func _ready():
	update()

func _process(delta):
	if Global.sleep_meter != sleep:
		sleep = Global.sleep_meter
		update()


func update():
	value = Global.sleep_meter*100/5

