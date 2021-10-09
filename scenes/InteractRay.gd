extends RayCast

const HOVER_METHOD := "on_interact_hover"

var cur: Node = null

func _physics_process(_delta: float):
	var collider := get_collider()
	if cur and not collider:
		# moved from object to no object
		cur.call(HOVER_METHOD, false)
		cur = null
	if collider and not cur:
		# moved from no object to new object
		cur = collider
		cur.call(HOVER_METHOD, true)
	if cur and collider != cur:
		# moved from one object to another
		cur.call(HOVER_METHOD, false) 
		cur = collider
		cur.call(HOVER_METHOD, true)
