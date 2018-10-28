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

signal character_deletion_success
signal character_deletion_failure(message)

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
var user
var password
var id = -1
var login_security_token
var connecting = false
var connection_timeout

func _ready():
	connection_timeout = Timer.new()
	connection_timeout.wait_time = 255
	
	get_tree().connect("connected_to_server", self, "_connection_success")
	get_tree().connect("connection_failed", self, "_connection_failure")
	
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
	rpc_id(SERVER_ID, "connect_character", id, login_security_token, character.serialize())
	
remote func network_init(security_token):
	if id > 1:
		return
	
	login_security_token = security_token
	id = get_tree().get_network_unique_id()
	
	connection_timeout.stop()
	connecting = false
	
	emit_signal("connection_established")
	
#####################
# Signal connectors #
#####################
	
func connect_network_connection(node, method_name):
	connect("connection_established", node, method_name)
	
func connect_network_connection_timout(node, method_name):
	connection_timeout.connect("timeout", node, method_name)

# Login
func connect_login_success(node, method_name):
	connect("login_success", node, method_name)
	
func connect_login_failure(node, method_name):
	connect("login_failure", node, method_name)

func connect_character_connection_success(node, method_name):
	connect("character_connection_success", node, method_name)
	
# Registration
func connect_registration_success(node, method_name):
	connect("registration_success", node, method_name)
	
func connect_registration_failure(node, method_name):
	connect("registration_failure", node, method_name)
	
# Character creation
func connect_character_creation_success(node, method_name):
	connect("character_creation_success", node, method_name)
	
func connect_character_creation_failure(node, method_name):
	connect("character_creation_failure", node, method_name)
	
# Character deletion
func connect_character_deletion_success(node, method_name):
	connect("character_deletion_success", node, method_name)
	
func connect_character_deletion_failure(node, method_name):
	connect("character_deletion_failure", node, method_name)
	
#########
# Login #
#########

func login(user, password):
	if id > 1:
		self.user = user
		self.password = password
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

func create_character(character):
	rpc_id(SERVER_ID, "create_character", id, login_security_token, character.serialize())

remote func character_creation_success(characters):
	emit_signal("character_creation_success", characters)
	
remote func character_creation_failure(message):
	emit_signal("character_creation_failure", message)
	
######################
# Character deletion #
######################

func delete_character(character):
	rpc_id(SERVER_ID, "delete_character", id, login_security_token, password.hash(), character.get_name())
	
remote func character_deletion_success():
	emit_signal("character_deletion_success")
	
remote func character_deletion_failure(message):
	emit_signal("character_deletion_failure", message)