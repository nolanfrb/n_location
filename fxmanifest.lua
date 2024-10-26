fx_version 'adamant'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    'system/console.lua',
    'system/class.lua',
    'shared/***',
}

client_scripts {
    'RageUI/RageUI.lua',
    'RageUI/Menu.lua',
    'RageUI/MenuController.lua',
    'RageUI/components/*.lua',
    'RageUI/elements/*.lua',
    'RageUI/items/*.lua',
    'client/***'
}

server_scripts {
    'server/***',
}

escrow_ignore {
    'shared/config.lua',
    'sql.sql',
}