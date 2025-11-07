local spawnConfig = require('config.spawn')
local cameraModule = require('client.modules.camera')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client spawn module loaded')

--- Set the default clothes for the player
---@param ped number The ped of the player
local function SetDefaultClothes(ped)
  for i = 0, 11 do
    SetPedComponentVariation(ped, i, 0, 0, 4)
  end

  for i = 0, 7 do
    ClearPedProp(ped, i)
  end
end

--- Prepare the character selection scene
local function PrepareCharacterSelection()
  ambitionsPrint.info('PrepareCharacterSelection called - starting fade out')
  DoScreenFadeOut(500)

  while not IsScreenFadedOut() do
    Wait(100)
  end

  ambitionsPrint.success('Screen faded out - setting up character selection scene')

  local defaultPedModel <const> = spawnConfig.defaultPed
  local spawnCoords <const> = spawnConfig.characterSelectionSpawn

  ambitionsPrint.info('Using ped model:', defaultPedModel, 'at coords:', spawnCoords)

  local playerPed = PlayerPedId()

  if defaultPedModel ~= "none" then
    ambitionsPrint.info('Loading ped model:', defaultPedModel)
    local modelHash <const> = GetHashKey(defaultPedModel)

    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
      Wait(100)
    end

    ambitionsPrint.success('Ped model loaded - setting player model')
    SetPlayerModel(PlayerId(), modelHash)
    SetModelAsNoLongerNeeded(modelHash)

    playerPed = PlayerPedId()

    ambitionsPrint.info('Setting default clothes on ped')
    SetDefaultClothes(playerPed)
    Wait(100)

    ambitionsPrint.info('Hiding player ped completely for character selection')
    SetEntityAlpha(playerPed, 0, false)
    SetPedAoBlobRendering(playerPed, false)
  end

  ambitionsPrint.info('Setting player position and freezing entity')
  SetEntityCoords(playerPed, spawnCoords.x, spawnCoords.y, spawnCoords.z, false, false, false, true)
  SetEntityHeading(playerPed, spawnCoords.w)

  FreezeEntityPosition(playerPed, true)
  SetPlayerControl(PlayerId(), false, 0)

  Wait(500)

  ambitionsPrint.info('Creating character selection camera')
  cameraModule.CreateCharacterSelectionCamera(playerPed, -0.35, 1.4, 0.45, 1000)

  ambitionsPrint.info('Shutting down loading screens')
  ShutdownLoadingScreen()
  ShutdownLoadingScreenNui()

  ambitionsPrint.success('Fading screen in')
  DoScreenFadeIn(500)

  while not IsScreenFadedIn() do
    Wait(100)
  end

  ambitionsPrint.success('Screen fade in complete')
  ambitionsPrint.info('Triggering server setupCharacter event')
  TriggerServerEvent('ambitions-multicharacter:server:setupCharacter')
end

RegisterNetEvent('ambitions-multicharacter:client:prepareCharacterSelection', function()
  ambitionsPrint.info('Received prepareCharacterSelection event from server')
  PrepareCharacterSelection()
end)

--- Show the default ped for character creation
local function ShowDefaultPed()
  ambitionsPrint.info('ShowDefaultPed called - making ped visible for character creation')

  local playerPed = PlayerPedId()

  ambitionsPrint.info('Enabling ped visibility and rendering with alpha 255 and blob rendering')
  FreezeEntityPosition(playerPed, true)
  SetPedAoBlobRendering(playerPed, true)
  SetEntityAlpha(playerPed, 255)

  Wait(100)

  ambitionsPrint.success('Default ped is now visible for character creation')
end

--- Hide the ped completely
local function HideDefaultPed()
  ambitionsPrint.info('HideDefaultPed called - hiding ped from view')

  local playerPed = PlayerPedId()

  ambitionsPrint.info('Hiding ped with alpha 0 and disabling blob rendering')
  SetPedAoBlobRendering(playerPed, false)
  SetEntityAlpha(playerPed, 0, false)

  Wait(100)

  ambitionsPrint.success('Ped is now hidden')
end

RegisterNetEvent('ambitions-multicharacter:client:showDefaultPed', function()
  ShowDefaultPed()
end)

RegisterNetEvent('ambitions-multicharacter:client:hideDefaultPed', function()
  HideDefaultPed()
end)

RegisterNetEvent('ambitions-multicharacter:client:offsetCameraForCreation', function()
  ambitionsPrint.info('Offsetting camera for character creation UI')
  cameraModule.OffsetCameraForCreation(1.0, 0.3, 1000) -- Shift left 1.0, zoom out 0.3
  ambitionsPrint.success('Camera offset applied - shifted left and zoomed out')
end)

CreateThread(function()
  ambitionsPrint.info('Starting player activation check thread')
  while not NetworkIsPlayerActive(PlayerId()) do
    Wait(100)
  end

  ambitionsPrint.success('Player is now active on network')
  ambitionsPrint.info('Triggering server checkPlayerData event')
  TriggerServerEvent('ambitions-multicharacter:server:checkPlayerData')
end)