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
    'cfg/html/stylesheet.css',
    'cfg/html/reset.css',
    'cfg/html/config.js',
    'cfg/html/listener.js',
}