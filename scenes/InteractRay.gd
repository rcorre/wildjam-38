extends RayCast

const HOVER_METHOD := "on_interact_hover"

var cur: Node = null

func _physics_process(_delta: float):
	var collider := get_collider()
	var has_cur := is_instance_valid(cur)
	if has_cur and not collider:
		# moved from object to no object
		cur.call(HOVER_METHOD, false)
		cur = null
	if collider and not has_cur:
		# moved from no object to new object
		cur = collider
		cur.call(HOVER_METHOD, true)
	if has_cur and collider != cur:
		# moved from one object to another
		cur.call(HOVER_METHOD, false) 
		cur = collider
		cur.call(HOVER_METHOD, true)


func _unhandled_input(ev: InputEvent):
	if ev.is_action_pressed("interact") and cur:
		if cur.has_method("on_interact"):
			cur.call("on_interact")
		elif cur.has_method("on_grab"):
			cur.call("on_grab", $GrabPoint)
