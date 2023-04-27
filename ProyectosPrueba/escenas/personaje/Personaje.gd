extends CharacterBody2D


var SPEED = 300
const JUMP_VELOCITY = -400.0
var doble_salto: bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(_delta):
	
	if Input.is_action_pressed("ui_right") and is_on_floor() and not is_on_wall() :
		$AnimatedSprite2D.play("correr")
	if Input.is_action_pressed("ui_left")and is_on_floor() and not is_on_wall() :
		$AnimatedSprite2D.play("correr")
	if velocity.y < 0 and doble_salto == true and not is_on_wall():
		$AnimatedSprite2D.play("salto")
	if velocity.y < 0 and doble_salto == false and not is_on_wall():
		$AnimatedSprite2D.play("doble_salto")
	if velocity.y < 0 and is_on_wall():
		$AnimatedSprite2D.play("trepar")
	
	if not is_on_floor():
		velocity.y += gravity * _delta
	
	if is_on_wall():
		if Input.is_action_pressed("E"):
			velocity.x = 0
			velocity.y = 0
			if Input.is_action_pressed("ui_up"):
				velocity.y = -200
		else:
			$AnimatedSprite2D.play("sostenido")
	
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		doble_salto = true
		
	if Input.is_action_just_pressed("ui_accept") and doble_salto == true and not is_on_floor():
		velocity.y = JUMP_VELOCITY
		doble_salto = false
		
		
	var direction = Input.get_axis("ui_left", "ui_right")
	$AnimatedSprite2D.flip_h = direction < 0 if direction != 0 else $AnimatedSprite2D.flip_h
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
		$AnimatedSprite2D.play("idle")

	move_and_slide()

	pass

