extends Node2D

@onready var HeartContainer = $CanvasLayer/heartscontainer
@onready var player = $player

func _ready():
	HeartContainer.setMaxHearts(player.MaxHealth)
	HeartContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(HeartContainer.updateHearts)
