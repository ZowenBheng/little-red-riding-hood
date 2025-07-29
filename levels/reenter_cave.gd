extends Area2D
@onready var lights = $"../.."
@onready var player = $"../../../player/PointLight2D3"

func _on_body_entered(body: Node2D) -> void:

	if body.name == "player":
		lights.show()
		player.show()
