extends MeshInstance

const INVISIBLE_MATERIAL := preload("res://assets/materials/Invisible.tres")
const SUCTION_AREA_SCENE := preload("res://scenes/SuctionArea.tscn")
const REPAIR_AREA_SCENE := preload("res://scenes/RepairArea.tscn")

const REPAIR_SOUNDS := [
	preload("res://assets/audio/barPlacement01.wav"),
	preload("res://assets/audio/barPlacement02.wav"),
	preload("res://assets/audio/barPlacement03.wav"),
]

const DAMAGE_SOUNDS := [
	preload("res://assets/audio/explosion01.wav"),
	preload("res://assets/audio/explosion02.wav"),
	preload("res://assets/audio/explosion03.wav"),
]

const MIN_DAMAGE_TIME := 5.0
const MAX_DAMAGE_TIME := 30.0

var suction_area: Area
var repair_area: Area

var sound := AudioStreamPlayer3D.new()
var vacuum_sound := AudioStreamPlayer3D.new()
var timer := Timer.new()

func _ready():
	suction_area = SUCTION_AREA_SCENE.instance()
	add_child(suction_area)
	suction_area.visible = false
	repair_area = REPAIR_AREA_SCENE.instance()
	suction_area.look_at(Vector3.ZERO, Vector3.FORWARD)
	add_child(repair_area)
	repair_area.connect("body_entered", self, "repair")
	repair_area.look_at(Vector3.ZERO, Vector3.UP)

	add_child(sound)
	sound.unit_size = 5
	sound.unit_db = 10

	add_child(vacuum_sound)
	vacuum_sound.stream = preload("res://assets/audio/vacuum.wav")
	vacuum_sound.unit_size = 4
	vacuum_sound.unit_db = 4

	add_child(timer)
	timer.connect("timeout", self, "damage")
	timer.start(rand_range(MIN_DAMAGE_TIME, MAX_DAMAGE_TIME))

func repair(body: Node):
	set_surface_material(0, null)
	set_surface_material(1, null)
	suction_area.visible = false
	suction_area.set_deferred("monitoring", false)
	repair_area.visible = false
	repair_area.set_deferred("monitoring", false)
	body.queue_free()

	vacuum_sound.stop()
	sound.stream = REPAIR_SOUNDS[randi() % len(REPAIR_SOUNDS)]
	sound.play()

	timer.start(rand_range(MIN_DAMAGE_TIME, MAX_DAMAGE_TIME))

func damage():
	suction_area.visible = true
	set_surface_material(0, INVISIBLE_MATERIAL)
	set_surface_material(1, INVISIBLE_MATERIAL)

	sound.stream = DAMAGE_SOUNDS[randi() % len(DAMAGE_SOUNDS)]
	sound.play()
	vacuum_sound.play()
	timer.stop()
