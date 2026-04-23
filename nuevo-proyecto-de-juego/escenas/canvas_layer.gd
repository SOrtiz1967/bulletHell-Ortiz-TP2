extends CanvasLayer

@onready var caja_corazones = $Corazones
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func actualizar_corazones(vidas: int)-> void:
	var lista= caja_corazones.get_children()
	for i in range(lista.size()):
		if i<vidas:
			lista[i].show()
		else:
			lista[i].hide()
			


func _on_jugador_principal_vida_cambiada(nueva_vida: Variant) -> void:
	actualizar_corazones(nueva_vida)
