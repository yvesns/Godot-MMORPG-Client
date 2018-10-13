extends Node

###########
# Signals #
###########

signal connection_established

signal login_success(player_characters)
signal login_failure
signal character_connection_success

signal registration_success(message)
signal registration_failure(message)

signal character_creation_success(characters)
signal character_creation_failure(message)

#############
# Constants #
#############

const SERVER_IP = "127.0.0.1"
const SERVER_PORT = 9292
const SERVER_ID = 1

#############
# Variables #
#############

var peer
var self_info
var self_instance
var id = -1
var login_security_token
var connecting = false
var connection_timeout

func _ready():
	connection_timeout = Timer.new()
	connection_timeout.wait_time = 255
	
	get_tree().connect("connected_to_server", self, "_connection_success")
	get_tree().connect("connection_failed", self, "_connection_failure")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	
func _connection_success():
	print("Connected to server")
	
func _connection_failure():
	print("Connection failed")
	
func _player_connected(id):
	print("A player has connected")
	
func connect_to_server():
	connecting = true
	connection_timeout.start()
	
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)
	
func connect_character(character):
	rpc_id(SERVER_ID, "connect_character", id, login_security_token, character)
	
remote func network_init(security_token):
	if id > 1:
		return
	
	login_security_token = security_token
	id = get_tree().get_network_unique_id()
	
	connection_timeout.stop()
	connecting = false
	
	emit_signal("connection_established")
	
	#Load map
	#Initialize self on map
	
	#var map = "res://Scenes/Maps/" + player_info.map + ".tscn"
	#self_info = player_info
	#self_instance = preload("res://Scenes/Creatures/Player/Slayer/Sworder.tscn").instance()
	#self_instance.hide()
	#self_instance.z_index += 1
	
	#get_tree().change_scene(map)
	#get_tree().get_root().add_child(self_instance)
	
	#self_instance.position = self_info.position
	#self_instance.show()
	
#####################
# Signal connectors #
#####################
	
func connect_network_connection_signal(node, method_name):
	connect("connection_established", node, method_name)
	
func connect_network_connection_timout_signal(node, method_name):
	connection_timeout.connect("timeout", node, method_name)
	
func connect_login_success_signal(node, method_name):
	connect("login_success", node, method_name)
	
func connect_login_failure_signal(node, method_name):
	connect("login_failure", node, method_name)
	
func connect_character_connection_success(node, method_name):
	connect("character_connection_success", node, method_name)
	
func connect_registration_success_signal(node, method_name):
	connect("registration_success", node, method_name)
	
func connect_registration_failure_signal(node, method_name):
	connect("registration_failure", node, method_name)
	
func connect_character_creation_success_signal(node, method_name):
	connect("character_creation_success", node, method_name)
	
func connect_character_creation_failure_signal(node, method_name):
	connect("character_creation_failure", node, method_name)
	
#########
# Login #
#########

func login(user, password):
	if id > 1:
		rpc_id(SERVER_ID, "login", id, user, password.hash(), login_security_token)
	
remote func login_success(player_characters):
	emit_signal("login_success", player_characters)
	
remote func login_failure():
	emit_signal("login_failure")
	
remote func character_connection_success():
	emit_signal("character_connection_success")
	
################
# Registration #
################

func register(user, password, email):
	return rpc_id(SERVER_ID, "register", id, user, password.hash(), email, login_security_token)
	
remote func registration_success(message):
	emit_signal("registration_success", message)
	
remote func registration_failure(message):
	emit_signal("registration_failure", message)
	
######################
# Character creation #
######################

remote func character_creation_success(characters):
	emit_signal("character_creation_success", characters)
	
remote func character_creation_failure(message):
	emit_signal("character_creation_failure", message)