@tool
class_name SpeechBubble
extends NinePatchRect

const FONT = preload("res://font/HelveticaNeueMedium.otf")

@export var text: String = "":
	set(value):
		text = value
		
		if speech_text != null:
			_update_text()

@onready var speech_text: RichTextLabel = $SpeechText

func _ready():
	_update_text()

func _update_text():
	var split_text: PackedStringArray = text.split("")
	
	var text_lines: PackedStringArray = [""]
	var line = 0
	
	var is_in_bbcode = false
	
	for i in split_text.size():
		if text_lines.size() - 1 < line:
			text_lines.append("")
		
		text_lines[line] += split_text[i]
		
		if split_text[i] == "[":
			is_in_bbcode = true
		elif split_text[i] == "]":
			is_in_bbcode = false
		
		speech_text.text = text_lines[line]
		
		if _get_string_size(speech_text.get_parsed_text()).x > 240 && !is_in_bbcode:
			line += 1
	
	speech_text.text = ""
	for i in range(text_lines.size()):
		var text_line = text_lines[i]
		
		speech_text.text += text_line
		
		if i != text_lines.size() - 1:
			speech_text.text += "\n"
	
	speech_text.size = Vector2.ZERO
	size = speech_text.size + speech_text.position + Vector2(25.0, 25.0)

func _get_string_size(string_text):
	return FONT.get_multiline_string_size(string_text, HORIZONTAL_ALIGNMENT_LEFT, 180.0, 25)
