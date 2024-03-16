extends Sprite2D

var velocidad = 400
var velocidad_angular = PI


func _process(delta):
	var direccion = 0
	if Input.is_action_pressed("ui_left"):
		direccion = -1
	if Input.is_action_pressed("ui_right"):
		direccion = 1

	rotation += velocidad_angular * direccion * delta

	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * velocidad
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2.DOWN.rotated(rotation) * velocidad

	position += velocity * delta
