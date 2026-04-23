extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
const bullet= preload("res://escenas/bullet.tscn")
var speed = 270.0
var last_direction = "down"
signal vida_cambiada(nueva_vida)
var vidas = 5 

func _physics_process(delta: float):
	get_input()
	move_and_slide()

func update_animation(state):
	animated_sprite.play(state+"_"+last_direction)

func get_input():
	#movimiento normal de manuaaal
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if input_direction == Vector2.ZERO:
		velocity = Vector2.ZERO
		update_animation("idle")
		return
		
	if abs(input_direction.x) > abs(input_direction.y):
		#la funcion abs si da -1 lo convierte en 1 
		#tonces movimiento horizontal
		if input_direction.x > 0:
			last_direction= "right"
		else:
			last_direction= "left"
	else:
		if input_direction.y > 0:
			last_direction= "down"
		else:
			last_direction="up"
	
	update_animation("run")		
	velocity = input_direction * speed
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var bala=bullet.instantiate()
		bala.global_position=global_position
		if last_direction == "up":
			bala.direction = Vector2(0, -1)
		elif last_direction == "down":
			bala.direction = Vector2(0, 1)
		elif last_direction == "left":
			bala.direction = Vector2(-1, 0)
		elif last_direction == "right":
			bala.direction = Vector2(1, 0)
		
		get_parent().add_child(bala)
func recibir_daño(dañorecibido: int) -> void:
	vidas -= dañorecibido
	vida_cambiada.emit(vidas)
	if vidas<=0:
		queue_free()
	
