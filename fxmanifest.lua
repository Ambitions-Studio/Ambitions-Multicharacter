fx_version 'cerulean'

game 'gta5'

use_experimental_fxv2_oal 'yes'

author 'Ambitions Studio'

description 'Ambitions Multicharacter — A complete character management system with identity creation, appearance setup, and full integration into the Ambitions framework.'

version '0.0.0'

name 'Ambitions Multicharacter'

lua54 'yes'

shared_scripts {
  '@Ambitions/verification.lua',
  '@Ambitions/importation.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/modules/spawn.lua'
}

client_scripts {
  'client/modules/spawn.lua',
  'client/modules/interface.lua',
  'client/modules/cameraControls.lua',
  'client/modules/existingCharacter/spawn.lua',
  'client/modules/existingCharacter/callbacks.lua'
}

ui_page 'web/dist/index.html'

files {
  'web/dist/index.html',
  'web/dist/assets/*.css',
  'web/dist/assets/*.js',
  'web/dist/images/**/*.png',
  'client/**/*.lua',
  'shared/**/*.lua',
  'config/*.lua'
}

dependencies {
    'oxmysql',
    'Ambitions'
}
