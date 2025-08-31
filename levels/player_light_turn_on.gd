extends Area2D

@onready var character = $"../../../../player/PointLight2D3"

func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "player":
		character.show()
