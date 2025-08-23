local spawnConfig = require('config.spawn')

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

--- Prepare the character for the selection screen
local function PrepareCharacter()
  local spawnCoords = spawnConfig.characterSelectionSpawn
  local spawnModel = "mp_m_freemode_01"

  RequestModel(spawnModel)
  while not HasModelLoaded(spawnModel) do
      Wait(500)
  end

  SetPlayerModel(PlayerId(), spawnModel)
  local playerPed = PlayerPedId()
  SetDefaultClothes(playerPed)


  SetEntityCoords(playerPed, spawnCoords.x,spawnCoords.y, spawnCoords.z, true, false, false, false)
  SetEntityHeading(playerPed, spawnCoords.w)

  SetPlayerControl(PlayerId(), false, 0)

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