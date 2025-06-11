extends Area2D
class_name StrikeZone

@onready var guy_1: Guy = $"../Guy1"
@onready var shape: CollisionShape2D = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position = guy_1.global_position;
	pass

var offset:
	get:
		return shape.shape.get_rect().size.x / 2;

var left:
	get:
		return global_position.x;

var right:
	get:
		return global_position.x + offset;

var width:
	get:
		return shape.shape.get_rect().size.x;
