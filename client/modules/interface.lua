local spawnConfig = require('config.spawn')
local pedsModule = require('client.modules.peds')
local appearanceCallbacks = require('client.modules.appearance.callbacks')
local clothingCallbacks = require('client.modules.clothing.callbacks')
local accessoriesCallbacks = require('client.modules.accessories.callbacks')
local tattoosCallbacks = require('client.modules.tattoos.callbacks')
local cameraModule = require('client.modules.camera')

appearanceCallbacks.RegisterAppearanceCallbacks()
clothingCallbacks.RegisterClothingCallbacks()
accessoriesCallbacks.RegisterAccessoriesCallbacks()
tattoosCallbacks.RegisterTattoosCallbacks()

--- Open the character selection interface
---@param data table The data containing characters and configuration
local function OpenInterface(data)
  SetNuiFocus(true, true)

  local nuiData = {
    action = 'showCharacterSelection',
    characters = data.characters,
    maxSlots = spawnConfig.characterSlots,
    canDelete = spawnConfig.playerCanDeleteCharacter
  }

  SendNUIMessage(nuiData)
end

RegisterNetEvent('ambitions-multicharacter:client:openInterface', function(data)
  OpenInterface(data)
end)

--- NUI callback when player selects an empty character slot
---@param data table Contains slotIndex number
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('selectEmptySlot', function(data, cb)
  TriggerEvent('ambitions-multicharacter:client:showDefaultPed')
  cb('ok')
end)

--- NUI callback when player deselects a character slot
---@param data table Empty table
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('deselectSlot', function(data, cb)
  TriggerEvent('ambitions-multicharacter:client:hideDefaultPed')
  cb('ok')
end)

--- NUI callback to request ped models and heritage configuration data
---@param data table Empty table
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('requestPedsConfig', function(data, cb)
  pedsModule.SendPedsConfigToNUI()
  pedsModule.SendHeritageConfigToNUI()
  cb('ok')
end)

--- NUI callback to start camera control mode
---@param data table Contains type string ('pan' or 'rotate')
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('cameraControlStart', function(data, cb)
  TriggerEvent('ambitions-multicharacter:client:cameraControlStart', data.type)
  cb('ok')
end)

--- NUI callback to stop camera control mode
---@param data table Contains type string ('pan' or 'rotate')
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('cameraControlStop', function(data, cb)
  TriggerEvent('ambitions-multicharacter:client:cameraControlStop', data.type)
  cb('ok')
end)

--- NUI callback to handle camera movement during pan or rotate
---@param data table Contains type string, movementX number, movementY number
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('cameraControlMove', function(data, cb)
  TriggerEvent('ambitions-multicharacter:client:cameraControlMove', data.type, data.movementX, data.movementY)
  cb('ok')
end)

--- NUI callback to toggle arms up animation for character preview
---@param data table Empty table
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('toggleArmsUp', function(data, cb)
  TriggerEvent('ambitions-multicharacter:client:toggleArmsUp')
  cb('ok')
end)

--- NUI callback to zoom camera in or out towards mouse position
---@param data table Contains zoomIn boolean, mouseX number, mouseY number
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('cameraZoom', function(data, cb)
  TriggerEvent('ambitions-multicharacter:client:cameraZoom', data.zoomIn, data.mouseX, data.mouseY)
  cb('ok')
end)

--- NUI callback to create a new character with validation
---@param data table Contains slot number, identity table, appearance table
---@param cb function Callback function with success boolean and errors table
RegisterNUICallback('createCharacter', function(data, cb)
  local isValid = true
  local errors = {}

  if not data.identity then
    isValid = false
    table.insert(errors, 'Identity data missing')
  else
    if not data.identity.firstName or data.identity.firstName == '' then
      isValid = false
      table.insert(errors, 'First name is required')
    end
    if not data.identity.lastName or data.identity.lastName == '' then
      isValid = false
      table.insert(errors, 'Last name is required')
    end
    if not data.identity.dateOfBirth or data.identity.dateOfBirth == '' then
      isValid = false
      table.insert(errors, 'Date of birth is required')
    end
    local gender = data.identity.gender and string.lower(data.identity.gender) or ''
    if gender == '' or (gender ~= 'm' and gender ~= 'f') then
      isValid = false
      table.insert(errors, 'Valid gender is required (m or f)')
    end
    if not data.identity.nationality or data.identity.nationality == '' then
      isValid = false
      table.insert(errors, 'Nationality is required')
    end
    if not data.identity.height or data.identity.height < 140 or data.identity.height > 220 then
      isValid = false
      table.insert(errors, 'Height must be between 140 and 220')
    end
  end

  if not data.appearance then
    isValid = false
    table.insert(errors, 'Appearance data missing')
  end

  if not data.slot or data.slot < 1 then
    isValid = false
    table.insert(errors, 'Invalid slot number')
  end

  if not isValid then
    cb({ success = false, errors = errors })
    return
  end

  TriggerServerEvent('ambitions-multicharacter:server:createCharacter', {
    slot = data.slot,
    identity = data.identity,
    appearance = data.appearance
  })

  cb({ success = true })
end)

--- NUI callback to log character creation errors from the UI
---@param data table Contains error string and message string
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('characterCreationError', function(data, cb)
  cb('ok')
end)

--- NUI callback to delete an existing character
---@param data table Contains uniqueId string of the character to delete
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('deleteCharacter', function(data, cb)
  if not data.uniqueId then
    cb({ success = false, error = 'No uniqueId provided' })
    return
  end

  TriggerServerEvent('ambitions-multicharacter:server:deleteCharacter', data.uniqueId)

  cb({ success = true })
end)

RegisterNetEvent('ambitions-multicharacter:client:characterDeleteResult', function(result)
  if not result.success then
    SendNUIMessage({
      action = 'characterDeleteFailed',
      error = result.error or 'Failed to delete character'
    })
  end
end)

RegisterNetEvent('ambitions-multicharacter:client:characterCreationResult', function(result)
  if result.success then
    SetNuiFocus(false, false)

    SendNUIMessage({
      action = 'hideCharacterCreator'
    })

    cameraModule.DestroyActiveCamera(500)

    DoScreenFadeOut(500)

    Wait(500)

    local playerSpawn = spawnConfig.playerSpawn
    local playerPed = PlayerPedId()

    SetEntityCoords(playerPed, playerSpawn.x, playerSpawn.y, playerSpawn.z, false, false, false, true)
    SetEntityHeading(playerPed, playerSpawn.w)

    SetEntityAlpha(playerPed, 255, false)
    SetPedAoBlobRendering(playerPed, true)

    FreezeEntityPosition(playerPed, false)

    SetEntityVisible(playerPed, true, false)

    SetEntityInvincible(playerPed, false)

    SetEntityCollision(playerPed, true, true)

    NetworkSetEntityInvisibleToNetwork(playerPed, false)

    SetEveryoneIgnorePlayer(PlayerId(), false)

    SetPoliceIgnorePlayer(PlayerId(), false)

    SetPlayerControl(PlayerId(), true, 0)

    DisplayRadar(true)

    DoScreenFadeIn(500)
  else
    SendNUIMessage({
      action = 'characterCreationFailed',
      error = result.error
    })
  end
end)

return {
  OpenInterface = OpenInterface,
}
