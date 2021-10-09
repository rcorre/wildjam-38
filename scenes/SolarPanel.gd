extends StaticBody

const HOVER_MATERIAL := preload("res://assets/materials/GreenHighlight.tres")
const DAMAGE_MATERIAL := preload("res://assets/materials/RedHighlight.tres")

onready var piece: MeshInstance = $Piece

var damaged := false

func _ready():
	# just randomly pick damaged pieces for now
	set_damaged((randi() % 8) > 6)

func set_damaged(on: bool):
	damaged = on
	piece.material_override = DAMAGE_MATERIAL if on else null

func on_interact_hover(on: bool):
	if damaged:
		piece.material_override = HOVER_MATERIAL if on else DAMAGE_MATERIAL

func on_interact():
	set_damaged(false)
