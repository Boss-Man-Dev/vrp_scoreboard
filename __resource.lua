description "vRP Scoreboard"

ui_page 'cfg/html/index.html'

dependency "vrp"

server_script { 
	"@vrp/lib/utils.lua",
	"server.lua",
}

client_script {
	'client.lua',
}

files {
	'cfg.lua',
    'cfg/html/index.html',
    'cfg/html/css/stylesheet.css',
    'cfg/html/js/config.js',
    'cfg/html/js/listener.js',
	'cfg/html/images/discord.png',
	'cfg/html/images/exit.png',
	'cfg/html/images/logo.png',
	'cfg/html/images/white-arrow.png',
}