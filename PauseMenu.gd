extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_TryAgain_pressed():
	$MenuHitSound.play()
	get_tree().change_scene("res://Main.tscn")
	get_tree().paused = false

func _on_GoToMenu_pressed():
	$MenuHitSound.play()
	get_tree().change_scene("res://MainMenu.tscn")
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("pause"):
		$MenuHitSound.play()
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
