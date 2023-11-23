class_name DialogueTreeEntry

var dialogueLine = ""
var dialogueOptions = []

# dialogue tree entry for multi-paragraph lines
static func monologue(_dialogueLine: String, _nextLineIndex: int):
	var entry = DialogueTreeEntry.new()
	entry.dialogueLine = _dialogueLine
	entry.dialogueOptions.append(DialogueTreeOption.goToLine(_nextLineIndex))
	return entry	
	

# dialogue tree entry for speaker-prompted dialogue finish
static func finish(_dialogueLine: String):
	var entry = DialogueTreeEntry.new()
	entry.dialogueLine = _dialogueLine
	entry.dialogueOptions = []
	return entry

# dialogue tree entry for branching options
static func multiOption(_dialogueLine, _dialogueOptions):
	var entry = DialogueTreeEntry.new()
	entry.dialogueLine = _dialogueLine
	entry.dialogueOptions = _dialogueOptions
	entry.validate()
	return entry
	
func addDefaultCallback(callback):
	for option in dialogueOptions:
		option.addCallback(callback)
	return self
	
func validate():
	if (len(dialogueOptions) in [0,1]):
		return
	for option in dialogueOptions:
		assert( option.dialogueLine != null, "ERROR: All branching options of an entry must contain text to display!.");
	

