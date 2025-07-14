extends Area2D

func _on_body_entered(body: CharacterBody2D) -> void:
	
	if body.name == "player":
		get_tree().change_scene_to_file("res://UI/respawn_button.tscn")
