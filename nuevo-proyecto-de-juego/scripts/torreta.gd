extends CharacterBody2D

const bescena_bala = preload("res://escenas/bulleten.tscn")

@export_range(0, 360, 1) var angulo: int = 0 #para poder cambiar el angulo que dispare la torreta cando la instancio
@export var rafaga= 3
@export var cadencia= 0.20
@onready var timer = $Timer
var vidas = 4
var recarga = 2.0

func _ready() -> void:
	
	add_to_group("enemigos")
	timer.wait_time = recarga

func recibir_daño(dañorecibido: int) -> void:
	vidas -= dañorecibido
	if vidas<=0:
		queue_free()



func _on_timer_timeout() -> void:
	disparar_rafaga()
func disparar_rafaga() -> void:
	var jugador = get_tree().get_first_node_in_group("jugador")
	var vector_direccion = Vector2.RIGHT.rotated(deg_to_rad(angulo))
	if jugador:
		vector_direccion=(jugador.global_position-global_position).normalized()
	
	for i in range(rafaga):
		var nueva_bala = bescena_bala.instantiate()
		get_tree().root.add_child(nueva_bala)
		
		nueva_bala.global_position = global_position
		nueva_bala.direction = vector_direccion
		nueva_bala.rotation = vector_direccion.angle()
		
		await get_tree().create_timer(cadencia).timeout
