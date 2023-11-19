class_name DialogueTreeOption

var dialogueLine: Variant
var nextDialogueLineIndex: int
var conditionForOptionVisibility: Callable
var selectionCallback: Callable

# use it when speaker speaks multiple paragraphs of text
static func goToLine(_nextDialogueLineIndex: int):
	var option = DialogueTreeOption.new()
	option.nextDialogueLineIndex = _nextDialogueLineIndex
	return option

# use it when you need to show an option for finishing the dialogue without the speaker speaking
static func finishOption(_dialogueLine: String):
	var option = DialogueTreeOption.new()
	option.dialogueLine = _dialogueLine
	return option	

# use it when you need to show an option for continuing the dialogue
static func standardOption(_dialogueLine: String, _nextDialogueLineIndex: int):
	var option = DialogueTreeOption.new()
	option.dialogueLine = _dialogueLine
	option.nextDialogueLineIndex = _nextDialogueLineIndex
	return option
	
# what should happen after an option gets picked
func addCallback(callback: Callable):
	self.selectionCallback = callback
	return self

# what condition needs to be fulfilled in order to show this option
func showOnCondition(condition: Callable):
	self.conditionForOptionVisibility = condition
	return self
