extends AudioStreamPlayer

func _ready():
	play()
	print("Tocando aliado morto")
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
