local spawnConfig = require('config.spawn')
local pedsModule = require('client.modules.peds')
local appearanceCallbacks = require('client.modules.appearance.callbacks')
local clothingCallbacks = require('client.modules.clothing.callbacks')
local accessoriesCallbacks = require('client.modules.accessories.callbacks')
local tattoosCallbacks = require('client.modules.tattoos.callbacks')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client interface module loaded')

appearanceCallbacks.RegisterAppearanceCallbacks()
clothingCallbacks.RegisterClothingCallbacks()
accessoriesCallbacks.RegisterAccessoriesCallbacks()
tattoosCallbacks.RegisterTattoosCallbacks()

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

-- Camera controls
RegisterNUICallback('cameraControlStart', function(data, cb)
  ambitionsPrint.info('Camera control started:', data.type)
  TriggerEvent('ambitions-multicharacter:client:cameraControlStart', data.type)
  cb('ok')
end)

RegisterNUICallback('cameraControlStop', function(data, cb)
  ambitionsPrint.info('Camera control stopped:', data.type)
  TriggerEvent('ambitions-multicharacter:client:cameraControlStop', data.type)
  cb('ok')
end)

RegisterNUICallback('cameraControlMove', function(data, cb)
  TriggerEvent('ambitions-multicharacter:client:cameraControlMove', data.type, data.movementX, data.movementY)
  cb('ok')
end)

RegisterNUICallback('toggleArmsUp', function(data, cb)
  ambitionsPrint.info('Toggle arms up animation')
  TriggerEvent('ambitions-multicharacter:client:toggleArmsUp')
  cb('ok')
end)

RegisterNUICallback('cameraZoom', function(data, cb)
  TriggerEvent('ambitions-multicharacter:client:cameraZoom', data.zoomIn, data.mouseX, data.mouseY)
  cb('ok')
end)

RegisterNUICallback('createCharacter', function(data, cb)
  ambitionsPrint.success('========== CHARACTER CREATION SUCCESS ==========')
  ambitionsPrint.info('Slot:', data.slot)
  ambitionsPrint.info('Identity:')
  ambitionsPrint.info('  First Name:', data.identity.firstName)
  ambitionsPrint.info('  Last Name:', data.identity.lastName)
  ambitionsPrint.info('  Date of Birth:', data.identity.dateOfBirth)
  ambitionsPrint.info('  Gender:', data.identity.gender)
  ambitionsPrint.info('  Nationality:', data.identity.nationality)
  ambitionsPrint.info('  Height:', data.identity.height)
  ambitionsPrint.info('Appearance:')
  ambitionsPrint.info('  Ped:', data.appearance.ped and data.appearance.ped.selectedPed or 'None')
  ambitionsPrint.info('  Heritage - Father:', data.appearance.heritage and data.appearance.heritage.father or 'None')
  ambitionsPrint.info('  Heritage - Mother:', data.appearance.heritage and data.appearance.heritage.mother or 'None')
  ambitionsPrint.info('  Physical - Hair Style:', data.appearance.physical and data.appearance.physical.hairStyle or 'None')
  ambitionsPrint.info('  Physical - Hair Color:', data.appearance.physical and data.appearance.physical.hairColor or 'None')
  ambitionsPrint.info('  Clothing - Torso:', data.appearance.clothing and data.appearance.clothing.torsoDrawable or 'None')
  ambitionsPrint.info('  Accessories - Hat:', data.appearance.accessories and data.appearance.accessories.hatDrawable or 'None')
  ambitionsPrint.info('  Tattoos - Head:', data.appearance.tattoos and data.appearance.tattoos.headTattooIndex or 'None')
  ambitionsPrint.info('  Tattoos - Torso:', data.appearance.tattoos and data.appearance.tattoos.torsoTattooIndex or 'None')
  ambitionsPrint.success('========== COMPLETE CHARACTER DATA ==========')
  ambitionsPrint.info(json.encode(data, { indent = true }))
  ambitionsPrint.success('========== END CHARACTER CREATION ==========')
  cb('ok')
end)

RegisterNUICallback('characterCreationError', function(data, cb)
  ambitionsPrint.error('CHARACTER CREATION ERROR')
  ambitionsPrint.error('Error Type:', data.error)
  ambitionsPrint.error('Error Message:', data.message)
  ambitionsPrint.error('END ERROR')
  cb('ok')
end)

return {
  OpenInterface = OpenInterface,
}
