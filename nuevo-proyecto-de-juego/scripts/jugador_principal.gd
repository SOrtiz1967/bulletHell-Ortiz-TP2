extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
const bullet= preload("res://escenas/bullet.tscn")
var speed = 285.0
var last_direction = "down"
signal vida_cambiada(nueva_vida)
signal actualizar_cargador(nuevo_cargador)
var vida_maxima=5
var vidas = 5 
@export var municion_cargador:int= 5
@export var tiempo_recarga =0.5
var cargador: int
var recargando=false

func _physics_process(delta: float):
	get_input()
	move_and_slide()

func _ready() -> void:
	cargador=municion_cargador
	

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
	if Input.is_action_just_pressed("recarga") and cargador<municion_cargador:
		Recargar()
	if event.is_action_pressed("shoot") and not recargando and cargador>0:
		cargador -=1
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
		actualizar_cargador.emit(cargador)
		
		
	if cargador<=0:
		Recargar()
func recibir_daño(dañorecibido: int) -> void:
	vidas-=dañorecibido
	vida_cambiada.emit(vidas)
	if vidas<=0:
		get_tree().change_scene_to_file("res://escenas/muerte.tscn")
		#queue_free()
		
func Recargar() -> void:
	recargando=true
	await get_tree().create_timer(tiempo_recarga).timeout
	cargador=municion_cargador
	recargando=false
	actualizar_cargador.emit(cargador)
func Curarse(cantidad: int) -> void:
	if vidas<vida_maxima:
		vidas+=cantidad
		if vidas>vida_maxima:
			vidas=vida_maxima
		vida_cambiada.emit(vidas)
		


	
