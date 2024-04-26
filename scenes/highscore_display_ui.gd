extends NinePatchRect

func _process(delta):
	$Label.text = str(Global.highscore)
