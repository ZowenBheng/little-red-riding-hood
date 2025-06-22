extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().on_attack.connect(on_player_attack)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hide()

func on_player_attack():
	print("Attacked recieved from grass")
	show()
	modulate.a = 1
	var tween = get_tree().create_tween()
	tween.finished.connect(hide)
	tween.tween_property(self, "modulate:a", 0, 0.5)
