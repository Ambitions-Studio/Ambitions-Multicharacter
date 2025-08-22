fx_version 'cerulean'

game 'gta5'

use_experimental_fxv2_oal 'yes'

author 'Ambitions Studio'

description 'Ambitions Multicharacter — A complete character management system with identity creation, appearance setup, and full integration into the Ambitions framework.'

version '0.2.0'

name 'Ambitions Multicharacter'

lua54 'yes'

shared_scripts {
  '@Ambitions/verification.lua',
  '@Ambitions/importation.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
}

client_scripts {
  'client/modules/spawn/spawnPlayer.lua'
}

ui_page 'web/dist/index.html'

files {
  'client/**/*.lua',
  'config/*.lua',
  'web/dist/index.html',
  'web/dist/assets/*.css',
  'web/dist/assets/*.js',
}

dependencies {
    'oxmysql',
    'Ambitions'
}
