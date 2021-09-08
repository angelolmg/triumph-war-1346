extends Area2D

func _ready():
	pass # Replace with function body.

func _on_CallHelp_body_entered(body):
	queue_free()
