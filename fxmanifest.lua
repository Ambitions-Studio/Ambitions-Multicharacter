fx_version 'cerulean'

game 'gta5'

use_experimental_fxv2_oal 'yes'

author 'Ambitions Studio'

description 'Ambitions Multicharacter — A complete character management system with identity creation, appearance setup, and full integration into the Ambitions framework.'

version '0.0.0'

name 'Ambitions Multicharacter'

lua54 'yes'

client_script '@Ambitions/init.lua'
server_script '@Ambitions/init.lua'

shared_scripts {
  'config/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',

    'server/modules/spawn.lua'
}

client_scripts {
  'client/modules/appearance/*.lua',
  'client/modules/clothing/*.lua',
  'client/modules/accessories/*.lua',
  'client/modules/tattoos/*.lua',
  'client/modules/**/*.lua',
}

ui_page 'web/dist/index.html'

files {
  'web/dist/index.html',
  'web/dist/assets/*.css',
  'web/dist/assets/*.js',
  'web/dist/images/**/*.png',
}

dependencies {
    'oxmysql',
    'Ambitions'
}
