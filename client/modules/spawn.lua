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

  local characters = amb.callback.await('ambitions-multicharacter:getCharacters', false)

  OpenInterface({
    characters = characters or {}
  })
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

--- Spawn character into the game world with full appearance and position
---@param characterData table Complete character data from server
local function SpawnCharacter(characterData)
  if not characterData then
    return
  end

  -- Close NUI
  SetNuiFocus(false, false)

  SendNUIMessage({
    action = 'hideCharacterSelection'
  })

  -- Destroy camera
  DestroyActiveCamera(500)

  -- Fade out
  DoScreenFadeOut(500)

  Wait(500)

  -- Load ped model
  local pedModel = characterData.pedModel or 'mp_m_freemode_01'
  local modelHash = GetHashKey(pedModel)

  RequestModel(modelHash)
  while not HasModelLoaded(modelHash) do
    Wait(100)
  end

  -- Set player model
  SetPlayerModel(PlayerId(), modelHash)
  SetModelAsNoLongerNeeded(modelHash)

  local playerPed = PlayerPedId()

  -- Apply full appearance
  if characterData.appearance then
    local appearanceData = characterData.appearance
    if type(appearanceData) == 'string' then
      local success, decoded = pcall(json.decode, appearanceData)
      if success then
        appearanceData = decoded
      end
    end

    LoadFullAppearance(playerPed, appearanceData)
  end

  -- Teleport to saved position
  local position = characterData.position
  if position then
    SetEntityCoords(playerPed, position.x, position.y, position.z, false, false, false, true)
    SetEntityHeading(playerPed, position.heading or 0.0)
  end

  -- Enable character
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

  if characterData.isDead then
    SetEntityHealth(playerPed, 0)
  else
    local health = characterData.health or 100
    local armor = characterData.armor or 0
    local newHealth = math.floor(health * 100 / 100) + 100
    SetEntityHealth(playerPed, newHealth)
    SetPedArmour(playerPed, armor)
  end

  DisplayRadar(true)

  amb.ShowHud()

  DoScreenFadeIn(500)
end

RegisterNetEvent('ambitions-multicharacter:client:spawnCharacter', function(characterData)
  SpawnCharacter(characterData)
end)

CreateThread(function()
  while not NetworkIsPlayerActive(PlayerId()) do
    Wait(100)
  end

  TriggerServerEvent('ambitions-multicharacter:server:checkPlayerData')
end)