fx_version 'cerulean'
game 'gta5'

author 'Sub-Zero Interactive'
description 'This is a script that allows you to rob vending machines using fivem-target or bt-target.'
version '1.2'

server_scripts {
    'config.lua',
    'server/server.lua'
}

client_scripts {
    '@menuv/menuv.lua',
    'config.lua',
    'client/client.lua'
}

dependencies {
    'mythic_progbar',
}
