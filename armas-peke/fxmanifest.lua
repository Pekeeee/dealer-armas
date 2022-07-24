fx_version 'cerulean'
game 'gta5'

author 'Peke'
description 'Dealer de armas'
version '1.0.0'
link 'https://discord.gg/B5tdRE6sXv'

resource_type 'Roleplay' { name = 'Armas-peke cargado correctamente!' }
ui_page 'html/index.html'
client_script {
    
    'client.lua',
    'config.lua' 
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
    'version.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/reset.css',
    'html/listener.js',
    'html/img/mapa.png'
}

dependencies{
    'InteractSound',
    'pNotify',
    'es_extended',
    'dealer-peke'

}