extends CharacterBody2D
const bescena_bala = preload("res://escenas/bulleten.tscn")
@onready var shoot_timer = $Timerdisparo
@onready var rotator = $rotator


const velocidad_rotacion= 100
const tiempo_espera_disparo=0.2
const spawn_count_point=4
const radio= 100
var vidas = 4

#todo tengo que corregir el spanglish en este script
func _ready():
	
	add_to_group("enemigos")
	var paso = 2* PI / spawn_count_point
	for i in range(spawn_count_point):
		var spawn_point = Node2D.new()
		var pos = Vector2(radio, 0).rotated(paso * i)
		spawn_point.position=pos
		spawn_point.rotation=pos.angle()
		rotator.add_child(spawn_point)
	shoot_timer.wait_time = tiempo_espera_disparo
	shoot_timer.start()
	
func _process(delta: float) -> void:
	var new_rotation = rotator.rotation_degrees + velocidad_rotacion * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)
	
func recibir_daño(dañorecibido: int) -> void:
	vidas -= dañorecibido
	if vidas<=0:
		queue_free()

func _on_timerdisparo_timeout() -> void:
	for s in rotator.get_children():
		var bullet = bescena_bala.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
		#como mi bala funciona distinto a la del tuto le paso la dir
		bullet.direction = Vector2.RIGHT.rotated(s.global_rotation)
