local spawnConfig = require('config.spawn')
local pedsModule = require('client.modules.peds')
local appearanceCallbacks = require('client.modules.appearance.callbacks')
local clothingCallbacks = require('client.modules.clothing.callbacks')
local accessoriesCallbacks = require('client.modules.accessories.callbacks')
local tattoosCallbacks = require('client.modules.tattoos.callbacks')
local cameraModule = require('client.modules.camera')
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

  for i, char in ipairs(data.characters) do
    ambitionsPrint.info('Character', i, '- ID:', char.id, 'Name:', char.firstName, char.lastName)
    if char.appearance then
      ambitionsPrint.success('Character', i, 'has appearance data')
    else
      ambitionsPrint.warning('Character', i, 'has NO appearance data')
    end
  end

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

--- NUI callback when player selects an empty character slot
---@param data table Contains slotIndex number
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('selectEmptySlot', function(data, cb)
  ambitionsPrint.info('Received selectEmptySlot callback from NUI for slot:', data.slotIndex)
  ambitionsPrint.info('Triggering showDefaultPed event')
  TriggerEvent('ambitions-multicharacter:client:showDefaultPed')
  cb('ok')
end)

--- NUI callback when player deselects a character slot
---@param data table Empty table
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('deselectSlot', function(data, cb)
  ambitionsPrint.info('Received deselectSlot callback from NUI')
  ambitionsPrint.info('Triggering hideDefaultPed event')
  TriggerEvent('ambitions-multicharacter:client:hideDefaultPed')
  cb('ok')
end)

--- NUI callback to request ped models and heritage configuration data
---@param data table Empty table
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('requestPedsConfig', function(data, cb)
  ambitionsPrint.info('Received requestPedsConfig callback from NUI')
  pedsModule.SendPedsConfigToNUI()
  pedsModule.SendHeritageConfigToNUI()
  cb('ok')
end)

--- NUI callback to start camera control mode
---@param data table Contains type string ('pan' or 'rotate')
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('cameraControlStart', function(data, cb)
  ambitionsPrint.info('Camera control started:', data.type)
  TriggerEvent('ambitions-multicharacter:client:cameraControlStart', data.type)
  cb('ok')
end)

--- NUI callback to stop camera control mode
---@param data table Contains type string ('pan' or 'rotate')
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('cameraControlStop', function(data, cb)
  ambitionsPrint.info('Camera control stopped:', data.type)
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
  ambitionsPrint.info('Toggle arms up animation')
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
  ambitionsPrint.success('========== CHARACTER CREATION VALIDATION ==========')

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
    ambitionsPrint.warning('Validation FAILED:')
    for i, error in ipairs(errors) do
      ambitionsPrint.warning('  ' .. i .. '. ' .. error)
    end
    ambitionsPrint.warning('========== END VALIDATION (FAILED) ==========')
    cb({ success = false, errors = errors })
    return
  end

  ambitionsPrint.success('Validation PASSED')
  ambitionsPrint.info('Slot:', data.slot)
  ambitionsPrint.info('Identity:')
  ambitionsPrint.info('  First Name:', data.identity.firstName)
  ambitionsPrint.info('  Last Name:', data.identity.lastName)
  ambitionsPrint.info('  Date of Birth:', data.identity.dateOfBirth)
  ambitionsPrint.info('  Gender:', data.identity.gender)
  ambitionsPrint.info('  Nationality:', data.identity.nationality)
  ambitionsPrint.info('  Height:', data.identity.height)
  ambitionsPrint.success('========== SENDING TO SERVER ==========')

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
  ambitionsPrint.warning('CHARACTER CREATION ERROR')
  ambitionsPrint.warning('Error Type:', data.error)
  ambitionsPrint.warning('Error Message:', data.message)
  ambitionsPrint.warning('END ERROR')
  cb('ok')
end)

--- NUI callback to delete an existing character
---@param data table Contains uniqueId string of the character to delete
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('deleteCharacter', function(data, cb)
  ambitionsPrint.warning('========== DELETE CHARACTER REQUEST ==========')

  if not data.uniqueId then
    ambitionsPrint.error('No uniqueId provided in deleteCharacter callback')
    cb({ success = false, error = 'No uniqueId provided' })
    return
  end

  ambitionsPrint.warning('Character Unique ID:', data.uniqueId)
  ambitionsPrint.warning('Sending delete request to server...')

  TriggerServerEvent('ambitions-multicharacter:server:deleteCharacter', data.uniqueId)

  cb({ success = true })
end)

RegisterNetEvent('ambitions-multicharacter:client:characterDeleteResult', function(result)
  if result.success then
    ambitionsPrint.success('========== CHARACTER DELETED SUCCESSFULLY ==========')
    ambitionsPrint.info('Interface will reload with updated character list')
  else
    ambitionsPrint.error('========== CHARACTER DELETE FAILED ==========')
    ambitionsPrint.error('Error:', result.error or 'Unknown error')

    SendNUIMessage({
      action = 'characterDeleteFailed',
      error = result.error or 'Failed to delete character'
    })
  end
end)

RegisterNetEvent('ambitions-multicharacter:client:characterCreationResult', function(result)
  if result.success then
    ambitionsPrint.success('========== CHARACTER CREATED SUCCESSFULLY ==========')
    ambitionsPrint.success('Character ID:', result.characterId)
    ambitionsPrint.success('Unique ID:', result.uniqueId)
    ambitionsPrint.success('========== SPAWNING PLAYER ==========')

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

    ambitionsPrint.success('Player spawned at:', playerSpawn.x, playerSpawn.y, playerSpawn.z)
    ambitionsPrint.success('Player controls restored')

    DoScreenFadeIn(500)
  else
    ambitionsPrint.error('CHARACTER CREATION FAILED:', result.error)

    SendNUIMessage({
      action = 'characterCreationFailed',
      error = result.error
    })
  end
end)

return {
  OpenInterface = OpenInterface,
}
