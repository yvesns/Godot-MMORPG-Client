extends Control

var user
var password
var email
var email_regex = Regex.new()
var is_password_valid = false
var is_email_valid = false

func _ready():
	email_regex.compile(".*@.*\\..*")

func _on_CloseButton_button_up():
	visible = false

func _on_LoginButton_button_up():
	#get_tree().change_scene("res://Scenes/Maps/TestMap.tscn")
	Main.connect_to_server()

func _on_RegisterButton_button_up():
	if (!is_password_valid ||
		!is_email_valid):
		return
	pass

func _on_AccountEdit_text_changed(new_text):
	user = new_text

func _on_PasswordEdit_text_changed(new_text):
	password = new_text

func _on_PassConfirmEdit_text_changed(new_text):
	if password == new_text:
		is_password_valid = true
	else:
		show_password_mismatch_message()

func _on_EmailEdit_text_changed(new_text):
	if email_regex.search(new_text) != null:
		is_email_valid = true
	else:
		show_invalid_email_message()
		
func show_password_mismatch_message():
	pass
	
func show_invalid_email_message():
	pass
