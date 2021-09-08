extends Area2D

const EnemyTransformed = preload("res://actors/EnemyTransformed.tscn")

func _ready():
	pass # Replace with function body.

func _on_EnemyTransf_body_entered(body):
	if body.is_in_group("Enemy"):
		var GrabedInstance= EnemyTransformed.instance() #Adiciona um gerador de inimigos, desde que ele gera inimigos
		get_tree().get_root().get_node("Main").add_child(GrabedInstance)
		var x_pos = self.global_position.x
		var y_pos = self.global_position.y
		GrabedInstance.global_transform.origin = Vector2(x_pos, y_pos)
		body.queue_free() #tira o corpo original
	queue_free()
