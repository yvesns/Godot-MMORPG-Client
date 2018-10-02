extends Control

var account = ""
var password = ""

func _ready():
	Network.connect_network_connection_signal(self, "_on_connection_established")
	Network.connect_network_connection_timout_signal(self, "_on_connection_timeout")

func _on_CloseButton_button_up():
	visible = false

func _on_LoginButton_button_up():
	#TODO: check if some client or server side validation is needed to avoid attempts
	#at logging in with the same account multiple times in case that the client is modified
	#to avoid the next verifications.
	
	if Network.connecting:
		return
	
	if Network.id > 1:
		Network.login(account, password)
		return
	
	connecting = true
	
	login_timeout.start()
	
	Network.connect_to_server()

func _on_RegisterButton_button_up():
	visible = false
	get_parent().get_node("RegisterPrompt").visible = true

func _on_AccountEdit_text_changed(new_text):
	account = new_text

func _on_PasswordEdit_text_changed(new_text):
	password = new_text

func _on_connection_established():
	Network.login(account, password)
	
func _on_connection_timeout():
	#Show a error message
	pass