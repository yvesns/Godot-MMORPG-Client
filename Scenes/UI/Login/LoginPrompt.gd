extends Control

var account = ""
var password = ""
var connecting = false
var login_timeout

func _ready():
	login_timeout = Timer.new()
	login_timeout.wait_time = 255
	login_timeout.connect("timeout", self, "_on_login_timeout")
	
	Network.connect_network_connection_signal(self, "_on_connection_established")

func _on_CloseButton_button_up():
	visible = false

func _on_LoginButton_button_up():
	#get_tree().change_scene("res://Scenes/Maps/TestMap.tscn")
	
	if connecting:
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
	login_timeout.stop()
	
func _on_login_timeout():
	connecting = false