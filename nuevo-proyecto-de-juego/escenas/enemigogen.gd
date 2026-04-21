extends CharacterBody2D


var vidas = 5
var velocidad =140.0
var daño=1


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
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		if body.has_method("recibir_daño"):
			body.recibir_daño(daño)
		queue_free()
