extends PathFollow2D

var speed = 0.2

func _process(delta):
	progress_ratio += delta * speed
