extends MeshInstance

const INVISIBLE_MATERIAL := preload("res://assets/materials/Invisible.tres")
const SUCTION_AREA_SCENE := preload("res://SuctionArea.tscn")
const REPAIR_AREA_SCENE := preload("res://RepairArea.tscn")

onready var body: StaticBody = $static_collision

var suction_area: Area
var repair_area: Area

func _ready():
	suction_area = SUCTION_AREA_SCENE.instance()
	add_child(suction_area)
	repair_area = REPAIR_AREA_SCENE.instance()
	add_child(repair_area)
	repair_area.connect("body_entered", self, "repair")
	set_surface_material(0, INVISIBLE_MATERIAL)
	set_surface_material(1, INVISIBLE_MATERIAL)

func repair(body: Node):
	set_surface_material(0, null)
	set_surface_material(1, null)
	suction_area.visible = false
	suction_area.monitoring = false
	repair_area.visible = false
	repair_area.monitoring = false
	body.queue_free()
