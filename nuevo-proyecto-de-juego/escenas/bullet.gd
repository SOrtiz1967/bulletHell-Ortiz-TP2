extends Area2D

var SPEED=400.0
var direction: Vector2=Vector2.ZERO
var daño=1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	position += direction * SPEED * delta 
	rotation = direction.angle()
	


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("recibir_daño"):
		body.recibir_daño(daño)
	queue_free()
