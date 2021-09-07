extends AudioStreamPlayer

func _ready():
	play()
	print("Tocando inimigo morto")
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
