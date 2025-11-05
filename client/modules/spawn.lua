local spawnConfig = require('config.spawn')
local cameraModule = require('client.modules.camera')

--- Prepare the character selection scene
local function PrepareCharacterSelection()
  DoScreenFadeOut(500)

  while not IsScreenFadedOut() do
    Wait(100)
  end

  local defaultPedModel <const> = spawnConfig.defaultPed
  local spawnCoords <const> = spawnConfig.characterSelectionSpawn

  local playerPed = PlayerPedId()

  if defaultPedModel ~= "none" then
    local modelHash <const> = GetHashKey(defaultPedModel)

    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
      Wait(100)
    end

    SetPlayerModel(PlayerId(), modelHash)
    SetModelAsNoLongerNeeded(modelHash)

    playerPed = PlayerPedId()

    SetEntityVisible(playerPed, true, false)
    SetEntityAlpha(playerPed, 255, false)
    SetPedAoBlobRendering(playerPed, true)
  end

  SetEntityCoords(playerPed, spawnCoords.x, spawnCoords.y, spawnCoords.z, false, false, false, true)
  SetEntityHeading(playerPed, spawnCoords.w)

  FreezeEntityPosition(playerPed, true)
  SetPlayerControl(PlayerId(), false, 0)

  Wait(500)

  cameraModule.CreateCharacterSelectionCamera(playerPed, 0.0, 2.5, 0.5, 1000)

  ShutdownLoadingScreen()
  ShutdownLoadingScreenNui()

  TriggerServerEvent('ambitions-multicharacter:server:setupCharacter')
end

RegisterNetEvent('ambitions-multicharacter:client:prepareCharacterSelection', function()
  PrepareCharacterSelection()
end)

CreateThread(function()
  while not NetworkIsPlayerActive(PlayerId()) do
    Wait(100)
  end

  TriggerServerEvent('ambitions-multicharacter:server:checkPlayerData')
end)