local spawnConfig = require('config.spawn')
local pedsModule = require('client.modules.peds')
local appearanceCallbacks = require('client.modules.appearance.callbacks')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client interface module loaded')

appearanceCallbacks.RegisterAppearanceCallbacks()

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

RegisterNetEvent('ambitions-multicharacter:client:openInterface', function(data)
  ambitionsPrint.info('Received openInterface event from server')
  OpenInterface(data)
end)

RegisterNUICallback('selectEmptySlot', function(data, cb)
  ambitionsPrint.info('Received selectEmptySlot callback from NUI for slot:', data.slotIndex)
  ambitionsPrint.info('Triggering showDefaultPed event')
  TriggerEvent('ambitions-multicharacter:client:showDefaultPed')
  cb('ok')
end)

RegisterNUICallback('deselectSlot', function(data, cb)
  ambitionsPrint.info('Received deselectSlot callback from NUI')
  ambitionsPrint.info('Triggering hideDefaultPed event')
  TriggerEvent('ambitions-multicharacter:client:hideDefaultPed')
  cb('ok')
end)

RegisterNUICallback('requestPedsConfig', function(data, cb)
  ambitionsPrint.info('Received requestPedsConfig callback from NUI')
  pedsModule.SendPedsConfigToNUI()
  pedsModule.SendHeritageConfigToNUI()
  cb('ok')
end)

RegisterNUICallback('startCharacterCreation', function(data, cb)
  ambitionsPrint.info('Starting character creation - offsetting camera for UI')
  TriggerEvent('ambitions-multicharacter:client:offsetCameraForCreation')
  cb('ok')
end)

return {
  OpenInterface = OpenInterface,
}
