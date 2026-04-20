extends CharacterBody2D


var vidas = 5 


func _physics_process(delta: float) -> void:
	pass
	
func recibir_daño(dañorecibido: int) -> void:
	vidas -= dañorecibido
	if vidas>=0:
		queue_free()
