extends Node2D
const cactus = preload("res://escenas/enemigogen.tscn")
const torreta = preload("res://escenas/torreta.tscn")
const spammer = preload("res://escenas/spammer.tscn")
const jefe = preload("res://escenas/jefe.tscn")




var tiempo_jugado: float = 0.0
var reloj_cactus: float = 0.0
var reloj_torreta: float = 0.0
var reloj_spammer: float = 0.0
var margenin=100




@export var limite_derecho: int = 1152
@export var limite_down: int = 648

var fase_actual: int=1
var tiempo_en_fase: float=0.0
var jefe_spawneado:bool=false
var spammers_creados:int=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tiempo_en_fase+=delta
	tiempo_jugado += delta
	reloj_cactus += delta
	reloj_torreta+= delta
	reloj_spammer+=delta
	var enemigos_vivos = get_tree().get_nodes_in_group("enemigos").size()
	var spammers_vivos = get_tree().get_nodes_in_group("spammers").size()
	var torretas_vivas = get_tree().get_nodes_in_group("torretas").size()

	match fase_actual:
		1:
			#oleada 1 solo cactus
			if tiempo_en_fase < 20.0:
				if reloj_cactus >= 1.0:
					#hay q acer algo con la posiccion
					spawn_cactus()
					reloj_cactus=0.0
			else:
				avanzar_fase(2)
		2:#torretas y caactys
			if tiempo_en_fase < 25.0:
				if reloj_torreta>=5.5:
					spawn_torreta()
					reloj_torreta = 0.0
				if reloj_cactus >= 10.0:
					spawn_cactus()
					reloj_cactus = 0.0
			else:
				avanzar_fase(3)
		3:
			if tiempo_en_fase < 40.0:
				if spammers_vivos==0 and reloj_spammer>=12.0:
					spawn_spammer()
					reloj_spammer=0.0
					reloj_torreta=0.0
				if torretas_vivas==0 and reloj_torreta>=9.0:
					spawn_torreta()
					reloj_torreta=0.0
				
				if spammers_vivos==0 and reloj_cactus>= 5.0:
					spawn_cactus()
					reloj_cactus = 0.0
				
			else:
				if enemigos_vivos == 0:
					print("nivel 1 completado preparate")
					avanzar_fase(4)
				elif tiempo_en_fase > 50.0:
					for enemigo in get_tree().get_nodes_in_group("enemigos"):
						enemigo.queue_free()
					avanzar_fase(4)
		#arrana el nivel 2 con muchos cactus
		4:
			if tiempo_en_fase < 20.0:
				if reloj_cactus>=0.6:
					spawn_cactus()
					reloj_cactus = 0.0
			else:
				if enemigos_vivos==0:
					avanzar_fase(5)
				elif tiempo_en_fase > 35.0:
					for enemigo in get_tree().get_nodes_in_group("enemigos"):
						enemigo.queue_free()
					avanzar_fase(5)
		#matar spamers a lo loco
		5:
			if spammers_creados<7:
				if spammers_vivos==0:
					spawn_spammer()
					spammers_creados+=1
					
			else:
				if spammers_vivos == 0:
					avanzar_fase(6)
		6:
			if tiempo_en_fase < 30.0:
				if reloj_cactus>=4.0:
					spawn_cactus()
					reloj_cactus=0.0
				if torretas_vivas<2 and reloj_torreta>=8.0:
					spawn_torreta()
					reloj_torreta =0.0
				if spammers_vivos ==0 and reloj_spammer >=15.0:
					spawn_spammer()
					reloj_spammer= 0.0
			else:
				if enemigos_vivos == 0:
					avanzar_fase(7)
				elif tiempo_en_fase > 40.0: 
					for enemigo in get_tree().get_nodes_in_group("enemigos"):
						enemigo.queue_free()
					avanzar_fase(7)
		7:#jefe final
			var jugador=get_tree().get_first_node_in_group("jugador")
			#Es muy dificil el nivel final, habria que soltar un par de cactus 
			if not jefe_spawneado:
				spawn_jefe()
				if jugador and jugador.has_method("Curarse"):
					jugador.Curarse(4)
				jefe_spawneado = true

func avanzar_fase(nueva_fase: int) -> void:
	fase_actual=nueva_fase
	tiempo_en_fase = 0.0
	reloj_cactus=0.0
	reloj_torreta=0.0
	reloj_spammer=0.0
	print("avanzo a fase ", nueva_fase)#chequeo por que no avanza fase

func spawn_torreta() -> void:
	var nueva_torreta = torreta.instantiate()
	nueva_torreta.z_index = 1
	
	var spawnx= randf_range(margenin, limite_derecho-margenin)
	var spawny= randf_range(margenin, limite_down-margenin)
	nueva_torreta.global_position = Vector2(spawnx, spawny)
	nueva_torreta.add_to_group("torretas")
	nueva_torreta.add_to_group("enemigos")
	add_child(nueva_torreta)

func spawn_cactus() -> void:
	
	var nuevo_cactus=cactus.instantiate()
	nuevo_cactus.z_index = 1
	var borde=randi() % 4
	var pos=Vector2.ZERO
	var offset=30
	match borde:
		0:
			pos = Vector2(randf_range(0, limite_derecho), -offset)
		1:
			pos = Vector2(randf_range(0, limite_derecho), limite_down + offset)
		2:
			pos = Vector2(-offset, randf_range(0, limite_down))
		3:
			pos = Vector2(limite_derecho + offset, randf_range(0, limite_down))
	nuevo_cactus.global_position = pos
	nuevo_cactus.add_to_group("enemigos")
	add_child(nuevo_cactus)
	
func spawn_spammer() -> void:
	var nuevo_spammer = spammer.instantiate()
	nuevo_spammer.z_index=1
	var esquinas=[Vector2(margenin, margenin), Vector2(limite_derecho - margenin, margenin), Vector2(margenin, limite_down - margenin), Vector2(limite_derecho - margenin, limite_down - margenin)]
	var spawnx=randf_range(margenin,limite_derecho-margenin)
	var spawny=randf_range(margenin, limite_down-margenin)
	nuevo_spammer.global_position= esquinas.pick_random()
	nuevo_spammer.add_to_group("spammers")
	nuevo_spammer.add_to_group("enemigos")
	add_child(nuevo_spammer)
	
func spawn_jefe() -> void:
	var nuevo_jefe=jefe.instantiate()
	nuevo_jefe.z_index=1
	nuevo_jefe.global_position=Vector2(limite_derecho / 2.0, limite_down / 2.0)
	nuevo_jefe.add_to_group("enemigos")
	add_child(nuevo_jefe)
