extends CharacterBody2D


var vidas = 2
var velocidad =120.0
var daño=1

func _ready() -> void:
	add_to_group("enemigos")


func _physics_process(delta: float) -> void:
	#voy a hacer que persiga al jugadorprincipal, asi tiene que estar atento de esquivar las balas y ir matawasdawdsdndo a los cactus molestos
	var jugador=get_tree().get_first_node_in_group("jugador")
	if jugador:
		var dir = (jugador.global_position - global_position).normalized()
		velocity=dir*velocidad
		move_and_slide()
func recibir_daño(dañorecibido: int) -> void:
	vidas -= dañorecibido
	if vidas<=0:
		var jugador=get_tree().get_first_node_in_group("jugador")
		if jugador and jugador.has_method("Curarse"):
			jugador.Curarse(1)
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		if body.has_method("recibir_daño"):
			body.recibir_daño(daño)
		queue_free()
