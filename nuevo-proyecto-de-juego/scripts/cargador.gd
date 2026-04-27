extends CanvasLayer
@onready var caja_balas= $cargador

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func actualizar_balas(cargador: int) -> void:
	var lista= caja_balas.get_children()
	for i in range(lista.size()):
		if i< cargador:
			lista[i].show()
		else:
			lista[i].hide()


func _on_jugador_principal_actualizar_cargador(nuevo_cargador: Variant) -> void:
	actualizar_balas(nuevo_cargador)
	
