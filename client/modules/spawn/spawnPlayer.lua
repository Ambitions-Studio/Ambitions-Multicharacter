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

--- Create cinematic camera effect for character selection
---@param playerPed number The player ped
---@param spawnCoords vector4 The spawn coordinates
local function CreateCinematicCamera(playerPed, spawnCoords)
  local headingRad = math.rad(spawnCoords.w)
  local cosHeading = math.cos(headingRad)
  local sinHeading = math.sin(headingRad)

  local startX = spawnCoords.x - (8.0 * cosHeading)
  local startY = spawnCoords.y - (8.0 * sinHeading)
  local startZ = spawnCoords.z + 4.0

  local endX = spawnCoords.x + (2.5 * cosHeading)
  local endY = spawnCoords.y + (2.5 * sinHeading)
  local endZ = spawnCoords.z + 0.3

  local startCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", startX, startY, startZ, 0.0, 0.0, spawnCoords.w, 45.0, false, 0)
  local endCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", endX, endY, endZ, -2.0, 0.0, spawnCoords.w + 180.0, 45.0, false, 0)

  PointCamAtEntity(startCam, playerPed, 0.0, 0.0, 0.3, true)
  PointCamAtEntity(endCam, playerPed, 0.0, 0.0, 0.3, true)

  SetCamActive(startCam, true)
  RenderScriptCams(true, false, 0, true, true)

  SetCamActiveWithInterp(endCam, startCam, 4000, 1, 1)

  CreateThread(function()
    Wait(4500)
    DestroyCam(startCam, false)
  end)
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

  -- Start cinematic camera effect after fade in
  Wait(500)
  CreateCinematicCamera(playerPed, spawnCoords)
end

CreateThread(function()
  while not NetworkIsPlayerActive(PlayerId()) do
    Wait(100)
  end

  DoScreenFadeOut(0)
  PrepareCharacter()
end)