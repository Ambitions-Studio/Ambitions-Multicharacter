local spawnConfig = require('config.spawn')

--- Open the character selection interface
---@param data table The data containing characters and configuration
local function OpenInterface(data)
  SetNuiFocus(true, true)

  SendNUIMessage({
    action = 'showCharacterSelection',
    characters = data.characters,
    maxSlots = spawnConfig.characterSlots,
    canDelete = spawnConfig.playerCanDeleteCharacter
  })
end

--- Close the character selection interface
local function CloseInterface()
  SetNuiFocus(false, false)

  SendNUIMessage({
    action = 'hideCharacterSelection'
  })
end

RegisterNetEvent('ambitions-multicharacter:client:openInterface', function(data)
  OpenInterface(data)
end)

RegisterNUICallback('closeCharacterSelection', function(data, cb)
  CloseInterface()
  cb('ok')
end)

return {
  OpenInterface = OpenInterface,
  CloseInterface = CloseInterface
}
