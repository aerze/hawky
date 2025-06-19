extends RigidBody2D
class_name Puck

const PUCK_BOUNCE_1 = preload("res://assets/audio/puck_bounce_1.ogg");
const PUCK_BOUNCE_2 = preload("res://assets/audio/puck_bounce_2.ogg");
const PUCK_BOUNCE_3 = preload("res://assets/audio/puck_bounce_3.ogg");
const PUCK_BOUNCE_4 = preload("res://assets/audio/puck_bounce_4.ogg");
const PUCK_BOUNCE_5 = preload("res://assets/audio/puck_bounce_5.ogg");



@onready var puck_audio: AudioStreamPlayer = $PuckAudio

const BONKS = [
	PUCK_BOUNCE_1,
	PUCK_BOUNCE_2,
	PUCK_BOUNCE_3,
	PUCK_BOUNCE_4
]

var left:
	get:
		return global_position.x - 20;

func _ready() -> void:
	body_entered.connect(handle_body_entered);
	return;

func handle_body_entered(body: Node):
	puck_audio.stop();
	puck_audio.stream = BONKS.pick_random();
	puck_audio.play();
	return;
