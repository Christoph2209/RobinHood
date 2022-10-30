extends Node


static func check_file():
	var file=File.new()
	if file.file_exists("user://save_data.dat"):
		return true
	else:
		return false
	
static func save_data(playerx,playery,boots,arrows,bombs,coins,health):
	var save_content={
		"playerx":playerx,
		"playery":playery,
		"boots":boots,
		"bombs":bombs,
		"arrows":arrows,
		"coins":coins,
		"health":health
	}
	Global.set_data(playerx,playery,boots,arrows,bombs,coins,health)
	var file = File.new()
	file.open("user://save_data.dat",File.WRITE)
	file.store_line(to_json(save_content))
	file.close()

static func load_data():
	var file = File.new()
	if file.file_exists("user://save_data.dat"):
		file.open("user://save_data.dat",File.READ)
		var content=parse_json(file.get_line())
		for i in content.keys():
			if i=="playerx":
				Global.playerx=content.get(i)
			elif i == "playery":
				Global.playery=content.get(i)
			elif i == "boots":
				Global.boots=content.get(i)
#			elif i == "bombs":
#				Global.bombs=content.get(i)
			elif i == "arrows":
				Global.fireArrows=content.get(i)
			elif i == "coins":
				Global.coins=content.get(i)
			elif i == "health":
				HealthCounter.health = content.get(i)
		file.close()
		return content
	else:
		save_data(1000,1000, 0, 0,0,0,3)
