extends CharacterBody2D
const bescena_bala = preload("res://escenas/bulleten.tscn")
@onready var marker=$canon
@onready var timer=$TimerDisparo
var vidas = 60
var velocidad=33.0
var daño=1
var fase_actual=1
var turno=0
var apertura=deg_to_rad(25)
func _ready() -> void:
	add_to_group("enemigos")
	timer.wait_time=2.0
	timer.start()

func _physics_process(delta: float) -> void:
	var jugador =get_tree().get_first_node_in_group("jugador")
	if is_instance_valid(jugador):
		var dir=(jugador.global_position-global_position).normalized()
		velocity=dir * velocidad
		move_and_slide()
		
func recibir_daño(dañorecibido: int) -> void:
	vidas -=dañorecibido
	if vidas <= 17 and fase_actual ==1:
		fase_actual=2
		velocidad= 70
		timer.wait_time = 1.1
		apertura= deg_to_rad(15)
		modulate=Color(1.0, 0.5, 0.5)
	if vidas<=0:
		get_tree().change_scene_to_file("res://escenas/victoria.tscn")
		queue_free()

func anillo() -> void:
	var cantidad_balas = 12
	var paso =2*PI/cantidad_balas
	for i in range(cantidad_balas):
		var nueva_bala = bescena_bala.instantiate()
		get_tree().current_scene.add_child(nueva_bala)
		var angulo=paso* i
		var vector_direccion = Vector2.RIGHT.rotated(angulo)
		nueva_bala.global_position = marker.global_position
		nueva_bala.direction = vector_direccion
		nueva_bala.rotation = vector_direccion.angle()
		
func escopetazo() -> void:
	var jugador=get_tree().get_first_node_in_group("jugador")
	if not jugador:#no romper el juego si muere el jugador
		return
	var vector_al_jugador=(jugador.global_position - marker.global_position).normalized()
	var angulo_central= vector_al_jugador.angle()
	var cantidad_balas=5
	
	var angulo_inicio=angulo_central-(apertura*(cantidad_balas-1) /2.0)#calculo para que el centro del tiro sea elk jugador
	for i in range(cantidad_balas):
		var nueva_bala = bescena_bala.instantiate()
		get_tree().current_scene.add_child(nueva_bala)
		var angulo_actual=angulo_inicio+(apertura*i)
		var vector_direccion=Vector2.RIGHT.rotated(angulo_actual)
		nueva_bala.global_position= marker.global_position
		nueva_bala.direction= vector_direccion
		nueva_bala.rotation=vector_direccion.angle()
		
	


func _on_timer_disparo_timeout() -> void:
	if turno % 2 == 0:
		anillo()
	else:
		escopetazo()
	turno+=1
