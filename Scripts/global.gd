extends Node

var store
var playerx = 32
var playery = 544
var bossx = 104
var bossy=184
var save_store_path = 'user://save'

var jump = 1
var jval = 1
var coins = 0
var has_fireArrows =false
var fireArrows = 0
var bomb = 0
var boots = 0
var has_bombs =false
var has_key = false
var key = 0 
var has_boots = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_data(plx,ply,boot,ar,bo,coi,health):
	playerx = plx
	playery = ply
	fireArrows = ar
	bomb = bo
	boots = boot
	coins = coi
	HealthCounter.health = health
	if(boots == 1):
		has_boots = true
		jval = 2
		jump = 2
	else:
		has_boots = false
		
func gain_coins(num):
	coins += num
	
func take_coins(num):
	coins -= num
	
func fire():
	if fireArrows > 0:
		has_fireArrows = true
	else:
		has_fireArrows = false

func keys():
	if key > 0:
		has_key = true
	else:
		has_key = false

func booties():
	if(boots == 1):
		has_boots = true
		jval = 2
		jump = 2
	else:
		has_boots = false
		jval = 1
		jump = 1
func save_store():
	var file = File.new()
	file.open(save_store_path, file.WRITE_READ)
	file.store_var(store)
	file.close()
	
	
func load_store():
	var file = File.new()
	if not file.file_exists(save_store_path):
		return false
	file.open(save_store_path, file.READ)
	store = file.get_var();
	file.close()
	return true
	
	
	
	
