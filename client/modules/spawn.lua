local spawnConfig = require('config.spawn')
local cameraModule = require('client.modules.camera')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client spawn module loaded')

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

    SetEntityVisible(playerPed, true, false)
    SetEntityAlpha(playerPed, 255, false)
    SetPedAoBlobRendering(playerPed, true)
  end

  ambitionsPrint.info('Setting player position and freezing entity')
  SetEntityCoords(playerPed, spawnCoords.x, spawnCoords.y, spawnCoords.z, false, false, false, true)
  SetEntityHeading(playerPed, spawnCoords.w)

  FreezeEntityPosition(playerPed, true)
  SetPlayerControl(PlayerId(), false, 0)

  Wait(500)

  ambitionsPrint.info('Creating character selection camera')
  cameraModule.CreateCharacterSelectionCamera(playerPed, 0.0, 2.5, 0.5, 1000)

  ambitionsPrint.info('Shutting down loading screens')
  ShutdownLoadingScreen()
  ShutdownLoadingScreenNui()

  ambitionsPrint.success('Fading screen in')
  DoScreenFadeIn(500)

  ambitionsPrint.info('Triggering server setupCharacter event')
  TriggerServerEvent('ambitions-multicharacter:server:setupCharacter')
end

RegisterNetEvent('ambitions-multicharacter:client:prepareCharacterSelection', function()
  ambitionsPrint.info('Received prepareCharacterSelection event from server')
  PrepareCharacterSelection()
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