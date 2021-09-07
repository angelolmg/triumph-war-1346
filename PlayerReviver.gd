extends Timer

func _ready():
	pass # Replace with function body.

func _on_PlayerReviver_timeout():
	var pl = load("res://actors/Player.tscn")
	var PlaInstance= pl.instance()
	get_tree().get_root().get_node("Main").add_child(PlaInstance)
	queue_free()
