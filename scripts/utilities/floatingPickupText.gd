@tool
extends Node

class_name MyFloatingPickupText

@export var floatingPickupTextLabelSettings: LabelSettings = null : set = setLabelSettings
@export var spawnOffset: Vector2 = Vector2(0,0) : set = setSpawnOffset
@export var floatVector: Vector2 = Vector2(0,0) : set = setFloatVector
@export var disappearTime: float = 1.2 : set = setDisappearTime

var floatingPickupTextHelpers: Array[FloatingPickupTextHelper] = []

func _process(delta: float):
	for helper in floatingPickupTextHelpers:
		var label = helper.countDownAndPopIfTimeElapsed(delta)
		if (label != null):
			if len(helper.textToSpawn) == 0:
				floatingPickupTextHelpers.erase(helper)
			triggerFloatingLabel(label)

func triggerFloatingLabel(label: Label):
	label.modulate.a = 1.0
	create_tween().tween_property(label, "modulate", Color(1.0,1.0,1.0,0.0), disappearTime)
	create_tween().tween_property(label, "position", label.position + floatVector, disappearTime)
	create_tween().tween_callback(
		func():
			label.queue_free()
	).set_delay(disappearTime)

func setLabelSettings(newSettings: LabelSettings):
	floatingPickupTextLabelSettings = newSettings
	onEditorFPTextUpdate()

func setSpawnOffset(newOffset: Vector2):
	spawnOffset = newOffset
	onEditorFPTextUpdate()

func setFloatVector(newFloatVector: Vector2):
	floatVector = newFloatVector
	onEditorFPTextUpdate()

func setDisappearTime(newDisappearTime: float):
	disappearTime = newDisappearTime
	onEditorFPTextUpdate()

func onEditorFPTextUpdate():
	if (floatingPickupTextLabelSettings != null and Engine.is_editor_hint()):
		spawnText([
			"Text1",
			"Text2",
			"Other Text 3"
		], Vector2(400, 300))

func spawnLine(line: String, spawnPosition: Vector2):
	spawnText([line], spawnPosition)

func spawnText(textLines: Array[String], spawnPosition: Vector2):
	var helper: FloatingPickupTextHelper = null
	var candidateHelpers = floatingPickupTextHelpers.filter(
		func(helper):
			return helper.spawnPosition.distance_to(spawnPosition) < 25.0
	)
	match (len(candidateHelpers)):
		0:
			helper = FloatingPickupTextHelper.new(spawnPosition)
			floatingPickupTextHelpers.append(helper)
		1:
			helper = candidateHelpers[0]
		_:
			helper = selectClosestHelper(candidateHelpers, spawnPosition)
	for line in textLines:
		var label = Label.new()
		label.label_settings = floatingPickupTextLabelSettings
		label.modulate.a = 0.0
		label.position = helper.spawnPosition + spawnOffset
		label.text = line
		self.add_child(label)
		helper.textToSpawn.append(label)

func selectClosestHelper(candidateHelpers: Array[FloatingPickupTextHelper], spawnPosition: Vector2) -> FloatingPickupTextHelper:
	var min_distance = 999999
	var candidateHelper = null
	for helper in candidateHelpers:
		var helperDistance = helper.spawnPosition.distance_to(spawnPosition)
		if min_distance > helperDistance:
			min_distance = helperDistance
			candidateHelper = helper
	return candidateHelper
