fx_version 'cerulean'
game 'gta5'

author 'Sub-Zero Interactive'
description 'This is a script that allows you to Interact with Vending Machines using Any of the main Target Systems As Well as either ESX Menu Default or MF-Inventory.'
version '2.0'

server_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'server/server.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'client/client.lua'
}

dependencies {
    'es_extended',
}
