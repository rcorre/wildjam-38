extends MeshInstance

const INVISIBLE_MATERIAL := preload("res://assets/materials/Invisible.tres")
const SUCTION_AREA_SCENE := preload("res://scenes/SuctionArea.tscn")
const REPAIR_AREA_SCENE := preload("res://scenes/RepairArea.tscn")
const BROKEN_GROUP := "broken"

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

var max_damage_time := 40.0
var suction_area: Area
var repair_area: Area

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

	add_child(timer)
	timer.connect("timeout", self, "damage")
	timer.start(rand_range(MIN_DAMAGE_TIME, max_damage_time))

func repair(body: Node):
	set_surface_material(0, null)
	set_surface_material(1, null)
	suction_area.visible = false
	suction_area.set_deferred("monitoring", false)
	repair_area.visible = false
	repair_area.set_deferred("monitoring", false)
	body.queue_free()

	# get faster over time
	max_damage_time = max(MIN_DAMAGE_TIME, max_damage_time - 5.0)
	timer.start(rand_range(MIN_DAMAGE_TIME, max_damage_time))
	remove_from_group(BROKEN_GROUP)
	propagate_call("on_repair")

func damage():
	suction_area.visible = true
	set_surface_material(0, INVISIBLE_MATERIAL)
	set_surface_material(1, INVISIBLE_MATERIAL)

	timer.stop()
	add_to_group(BROKEN_GROUP)
	propagate_call("on_damage")
