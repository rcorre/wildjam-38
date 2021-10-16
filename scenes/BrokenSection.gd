extends MeshInstance

const INVISIBLE_MATERIAL := preload("res://assets/materials/Invisible.tres")
const SUCTION_AREA_SCENE := preload("res://SuctionArea.tscn")

onready var body: StaticBody = $static_collision

func _ready():
	var suction := SUCTION_AREA_SCENE.instance()
	add_child(suction)
	set_surface_material(0, INVISIBLE_MATERIAL)
	set_surface_material(1, INVISIBLE_MATERIAL)
