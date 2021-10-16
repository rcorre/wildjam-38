extends KinematicBody

const ACCEL := 20.0
const DECEL := 6.0
const MAX_SPEED := 20.0
const LOOK_SPEED := 12.0
const MOUSE_SENSITIVITY := 0.001

var rot_target := Vector3.ZERO
var velocity := Vector3.ZERO

func _enter_tree():
	add_to_group("player")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(ev: InputEvent):
	var mouse := ev as InputEventMouseMotion
	if mouse:
		rot_target.x -= mouse.relative.y * MOUSE_SENSITIVITY
		rot_target.y -= mouse.relative.x * MOUSE_SENSITIVITY

func _physics_process(delta: float):
	var dir := global_transform.basis.xform(Vector3(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("up") - Input.get_action_strength("down"),
		Input.get_action_strength("back") - Input.get_action_strength("forward")
	))

	var speed := velocity.length()
	var accel := ACCEL if speed < MAX_SPEED else DECEL
	velocity = velocity.move_toward(dir * MAX_SPEED, delta * accel)
	velocity = move_and_slide(velocity)

	var cur_quat := Quat(global_transform.basis)
	var target_quat := Quat(rot_target)
	var res_quat := cur_quat.slerp(target_quat, delta * LOOK_SPEED)
	global_transform.basis = Basis(res_quat)
