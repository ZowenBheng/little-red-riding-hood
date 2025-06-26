extends CharacterBody2D
#await get_tree().create_timer(3.0).timeout  (use for later)

@onready var AS  = $AnimatedSprite2D
@onready var dashEffectTimer = $dashEffectTimer

const SPEED = 200 
const JUMP = -400

var Dash_speed = 900.0
var dashing = false
var dash_cooldown = true
var is_wall_sliding = false
var friction = 75
var start_position = Vector2(-124,572)


func _physics_process(delta : float):

	var direction: = Input.get_axis("move_left", "move_right")
	if direction:
		if dashing:
			velocity.x = direction * Dash_speed
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x , 0 , SPEED)
	
		
	if not is_on_floor(): velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP 
		
	if Input.is_action_just_pressed("hold_dash") and dash_cooldown:
		dashing = true 
		dash_cooldown = false 
		$dash_timer.start()
		$dash_cooldown.start()
		$dashEffectTimer.start()
		
	if position.y > 900:
		respawn()
		
	if (is_on_wall()):
		is_wall_sliding = true 
		velocity.y = friction
	else:
		is_wall_sliding = false
	
	handle_animation(direction)
	
	move_and_slide()
	
func handle_animation(dir):
	
	handle_sprite_flip(dir)
	
	if is_on_floor():
		if velocity:
			AS.play("run")
		else:
			AS.play("idle")
	else:
		if is_wall_sliding:
			AS.play("wall slide")
		else:
			AS.play("jump")	
	
		
func handle_sprite_flip(dir):
	
	if dir == 1:
		AS.flip_h = false
	elif dir == - 1:
		AS.flip_h = true

func create_dash_effect():
	
	var playerCopyNode = $AnimatedSprite2D.duplicate()
	get_parent().add_child(playerCopyNode)
	playerCopyNode.global_position = global_position
	
	var animationTime = dashEffectTimer.wait_time / 3
	await get_tree().create_timer(animationTime).timeout
	playerCopyNode.modulate.a = 0.4
	await get_tree().create_timer(animationTime).timeout
	playerCopyNode.modulate.a = 0.2
	await get_tree().create_timer(animationTime).timeout
	playerCopyNode.queue_free()
	
func _on_dash_effect_timer_timeout():
	create_dash_effect() 
	$dashEffectTimer.stop()

func _on_dash_timer_timeout():
	dashing = false 
	
func _on_dash_cooldown_timeout():
	dash_cooldown = true
	
func respawn():
	position = start_position
	
	
