extends Node2D

signal _on_successful_interaction()

var flag_array = [true, true, true, true, true, true, true, true]

func _on_berry_1_input_event(_viewport, event, _shape_idx):
	handle_click(event, $stem/berry1, preload("res://sprites/cutting/flower1/herb-berry-gone.png"), 0, false)
	
func _on_berry_2_input_event(_viewport, event, _shape_idx):
	handle_click(event, $stem/berry2, preload("res://sprites/cutting/flower1/herb-berry2-gone.png"), 1, false)

func _on_berry_3_input_event(_viewport, event, _shape_idx):
	handle_click(event, $stem/berry3, preload("res://sprites/cutting/flower1/herb-berry-gone.png"), 2, false)

func _on_berry_4_input_event(_viewport, event, _shape_idx):
	handle_click(event, $stem/berry4, preload("res://sprites/cutting/flower1/herb-berry-gone.png"), 3, false)

func _on_cut_1_input_event(_viewport, event, _shape_idx):
	handle_click(event, $stem/leaf1, null, 4, true)

func _on_cut_2_input_event(_viewport, event, _shape_idx):
	handle_click(event, $stem/leaf2, null, 5, true)

func _on_cut_3_input_event(_viewport, event, _shape_idx):
	handle_click(event, $stem/leaf3, null, 6, true)

func _on_cut_4_input_event(_viewport, event, _shape_idx):
	handle_click(event, $stem/leaf4, null, 7, true)
		
func handle_click(event, node, texture, id, animate):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if(flag_array[id]):
			if(animate):
				var tween = get_tree().create_tween()
				tween.tween_property(node, "position", node.position + Vector2(10, 15), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
				tween.tween_property(node, "position", node.position + Vector2(-15, 20), 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
				tween.tween_property(node, "position", node.position + Vector2(20, 25), 2.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
				#tween.tween_callback(node.queue_free())
			else:
				node.texture = texture
			flag_array[id] = true
			_on_successful_interaction.emit()
