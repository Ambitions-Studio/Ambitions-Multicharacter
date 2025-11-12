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

    SetDefaultClothes(playerPed)
    Wait(100)

    SetEntityAlpha(playerPed, 0, false)
    SetPedAoBlobRendering(playerPed, false)
  end

  SetEntityCoords(playerPed, spawnCoords.x, spawnCoords.y, spawnCoords.z, false, false, false, true)
  SetEntityHeading(playerPed, spawnCoords.w)

  FreezeEntityPosition(playerPed, true)
  SetPlayerControl(PlayerId(), false, 0)

  Wait(500)

  CreateCharacterSelectionCamera(playerPed, -0.35, 1.4, 0.45, 1000)

  ShutdownLoadingScreen()
  ShutdownLoadingScreenNui()

  DoScreenFadeIn(500)

  while not IsScreenFadedIn() do
    Wait(100)
  end

  amb.triggerServerCallback('ambitions-multicharacter:server:getCharacters', false, function(characters)
    if characters then
      OpenInterface({
        characters = characters
      })
    else
      return
    end
  end)
end

RegisterNetEvent('ambitions-multicharacter:client:prepareCharacterSelection', function()
  PrepareCharacterSelection()
end)

--- Show the default ped for character creation
local function ShowDefaultPed()
  local playerPed = PlayerPedId()

  FreezeEntityPosition(playerPed, true)
  SetPedAoBlobRendering(playerPed, true)
  SetEntityAlpha(playerPed, 255)

  Wait(100)
end

--- Hide the ped completely
local function HideDefaultPed()
  local playerPed = PlayerPedId()

  SetPedAoBlobRendering(playerPed, false)
  SetEntityAlpha(playerPed, 0, false)

  Wait(100)
end

RegisterNetEvent('ambitions-multicharacter:client:showDefaultPed', function()
  ShowDefaultPed()
end)

RegisterNetEvent('ambitions-multicharacter:client:hideDefaultPed', function()
  HideDefaultPed()
end)

CreateThread(function()
  while not NetworkIsPlayerActive(PlayerId()) do
    Wait(100)
  end

  TriggerServerEvent('ambitions-multicharacter:server:checkPlayerData')
end)