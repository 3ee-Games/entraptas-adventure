extends KinematicBody

export var speed = 14
export var move_speed = 20;
export var jump_power = 50;
export var fall_acceleration = 75
export var jump_impulse = 20

var moving_anim_name = "walking";
var idle_anim_name = "idle";
var velocity = Vector3(0, 0, 0);
var moving = false
var camera

func _ready():
	$Pivot/Character.play(idle_anim_name)

func _physics_process(delta):
	camera = get_node("Target/Camera").get_global_transform()
	if (Input.is_action_pressed("move_right")):
		velocity.x = move_speed;
		moving = true
	elif (Input.is_action_pressed("move_left")):
		velocity.x = -move_speed;
		moving = true
	else:
		velocity.x = 0;
	
	if (Input.is_action_pressed("move_down")):
		velocity.z = move_speed;
		moving = true
	elif (Input.is_action_pressed("move_up")):
		velocity.z = -move_speed;
		moving = true
	else:
		velocity.z = 0;
		
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
		moving = true
		
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)

	global_translate(velocity * delta)
	if (moving && is_on_floor()):
		$Pivot/Character.play(moving_anim_name);
	elif(!moving && is_on_floor()):
		$Pivot/Character.play(idle_anim_name);
		
	moving = false

