local spawnConfig = require('Ambitions-Multicharacter.config.spawn')

--- Prepare the character for the selection screen
local function PrepareCharacter()
  local spawnCoords = spawnConfig.characterSelectionSpawn
  local spawnModel = "mp_m_freemode_01"

  RequestModel(pedModel)
  while not HasModelLoaded(pedModel) do
      Wait(500)
  end

  SetPlayerModel(playerId(), spawnModel)
  local playerPed = PlayerPedId()


  SetEntityCoords(playerPed, spawnCoords.x,spawnCoords.y, spawnCoords.z, true, false, false, false)
  SetEntityHeading(playerPed, spawnCoords.w)

  SetPlayerControl(playerId(), false, 0)

  ShutdownLoadingScreen()
  ShutdownLoadingScreenNui()

  DoScreenFadeIn(500)
end

CreateThread(function()
  while not NetworkIsPlayerActive(PlayerId()) do
    Wait(100)
  end

  DoScreenFadeOut(0)
  PrepareCharacter()
end)