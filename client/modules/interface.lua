local spawnConfig = require('config.spawn')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client interface module loaded')

--- Open the character selection interface
---@param data table The data containing characters and configuration
local function OpenInterface(data)
  ambitionsPrint.info('OpenInterface called with', #data.characters, 'character(s)')
  ambitionsPrint.info('Setting NUI focus to true')
  SetNuiFocus(true, true)

  local nuiData = {
    action = 'showCharacterSelection',
    characters = data.characters,
    maxSlots = spawnConfig.characterSlots,
    canDelete = spawnConfig.playerCanDeleteCharacter
  }

  ambitionsPrint.info('Sending showCharacterSelection message to NUI with maxSlots:', spawnConfig.characterSlots)
  SendNUIMessage(nuiData)
  ambitionsPrint.success('NUI interface opened successfully')
end

--- Close the character selection interface
local function CloseInterface()
  ambitionsPrint.info('CloseInterface called')
  ambitionsPrint.info('Setting NUI focus to false')
  SetNuiFocus(false, false)

  SendNUIMessage({
    action = 'hideCharacterSelection'
  })
  ambitionsPrint.success('NUI interface closed successfully')
end

RegisterNetEvent('ambitions-multicharacter:client:openInterface', function(data)
  ambitionsPrint.info('Received openInterface event from server')
  OpenInterface(data)
end)

RegisterNUICallback('closeCharacterSelection', function(data, cb)
  ambitionsPrint.info('Received closeCharacterSelection callback from NUI')
  CloseInterface()
  cb('ok')
end)

return {
  OpenInterface = OpenInterface,
  CloseInterface = CloseInterface
}
