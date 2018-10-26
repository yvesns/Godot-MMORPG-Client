extends Control

var account = ""
var password = ""
var logging_in = false

func _ready():
	Network.connect_network_connection(self, "_on_connection_established")
	Network.connect_network_connection_timout(self, "_on_connection_timeout")
	Network.connect_login_success(self, "_on_login_success")

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
		
	logging_in = true
	
	Network.connect_to_server()

func _on_RegisterButton_button_up():
	visible = false
	get_parent().get_node("RegisterPrompt").visible = true

func _on_AccountEdit_text_changed(new_text):
	account = new_text

func _on_PasswordEdit_text_changed(new_text):
	password = new_text

func _on_connection_established():
	if logging_in:
		Network.login(account, password)
		logging_in = false
	
func _on_connection_timeout():
	logging_in = false
	
func _on_login_success(player_characters):
	Global.scene_args = player_characters
	
	get_tree().change_scene(Global.paths["CharacterSelection.tscn"])