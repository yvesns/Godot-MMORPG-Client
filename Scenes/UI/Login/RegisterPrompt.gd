extends Control

var user
var password
var email
var email_regex = RegEx.new()
var is_password_valid = false
var is_email_valid = false
var password_mismatch
var invalid_email

func _ready():
	email_regex.compile("\\w.*@\\w.*\\.\\w.*")
	
	password_mismatch = preload("res://Scenes/UI/Login/ErrorMessage.tscn").instance()
	password_mismatch.find_node("Label").text = "Password mismatch"
	password_mismatch.set_name("PasswordMismatch")
	
	invalid_email = preload("res://Scenes/UI/Login/ErrorMessage.tscn").instance()
	invalid_email.find_node("Label").text = "Invalid email"
	invalid_email.set_name("InvalidEmail")
	
	Network.connect_network_connection_signal(self, "_on_connection_established")

func _on_CloseButton_button_up():
	visible = false

func _on_RegisterButton_button_up():
	if (!is_password_valid ||
		!is_email_valid):
		return
	
	var result = Network.register(user, password, email)
	
	print(result)

func _on_AccountEdit_text_changed(new_text):
	user = new_text

func _on_PasswordEdit_text_changed(new_text):
	var password_confirm = find_node("PassConfirmEdit").text
	
	password = new_text
	
	if password == password_confirm:
		is_password_valid = true
		remove_password_mismatch_message()
	else:
		show_password_mismatch_message()

func _on_PassConfirmEdit_text_changed(new_text):
	if password == new_text:
		is_password_valid = true
		remove_password_mismatch_message()
	else:
		show_password_mismatch_message()

func _on_EmailEdit_text_changed(new_text):
	if email_regex.search(new_text) != null:
		is_email_valid = true
		remove_invalid_email_message()
	else:
		show_invalid_email_message()
		
func _on_connection_established():
	pass
		
func show_password_mismatch_message():
	if find_node(password_mismatch.name) == null:
		get_node("MainContainer").add_child(password_mismatch)
		password_mismatch.set_owner(get_node("MainContainer"))
	
func show_invalid_email_message():
	if find_node(invalid_email.name) == null:
		get_node("MainContainer").add_child(invalid_email)
		invalid_email.set_owner(get_node("MainContainer"))
		
func remove_password_mismatch_message():
	var node = find_node(password_mismatch.name)
	
	if node != null:
		#node.queue_free()
		get_node("MainContainer").remove_child(password_mismatch)
		
func remove_invalid_email_message():
	var node = find_node(invalid_email.name)
	
	if node != null:
		#node.queue_free()
		get_node("MainContainer").remove_child(invalid_email)