local spawnConfig = require('config.spawn')
local cameraModule = require('client.modules.camera')
local loadAppearance = require('client.modules.existingCharacter.loadAppearance')

---@type number|nil
local existingCharacterPed = nil

--- Spawn an existing character with full appearance customization
---@param characterData table Complete character data including appearance, identity, etc.
---@return nil
local function SpawnExistingCharacter(characterData)
  if not characterData then
    return
  end

  if existingCharacterPed and DoesEntityExist(existingCharacterPed) then
    DeleteEntity(existingCharacterPed)
    existingCharacterPed = nil
  end

  local pedModel = characterData.gender == 'f' and 'mp_f_freemode_01' or 'mp_m_freemode_01'
  local modelHash = GetHashKey(pedModel)

  RequestModel(modelHash)
  while not HasModelLoaded(modelHash) do
    Wait(100)
  end

  local spawnCoords = spawnConfig.characterSelectionSpawn
  existingCharacterPed = CreatePed(4, modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w, false, true)

  if not DoesEntityExist(existingCharacterPed) then
    return
  end

  SetEntityAlpha(existingCharacterPed, 255, false)
  SetEntityInvincible(existingCharacterPed, true)
  FreezeEntityPosition(existingCharacterPed, true)
  SetBlockingOfNonTemporaryEvents(existingCharacterPed, true)
  SetEntityCollision(existingCharacterPed, false, false)

  if characterData.appearance then
    loadAppearance.LoadFullAppearance(existingCharacterPed, characterData.appearance)
  end

  local activeCam = cameraModule.GetActiveCamera()
  if activeCam then
    PointCamAtEntity(activeCam, existingCharacterPed, 0.0, 0.0, 0.0, true)
  end
end

--- Hide and delete the existing character ped
---@return nil
local function HideExistingCharacter()
  if existingCharacterPed and DoesEntityExist(existingCharacterPed) then
    DeleteEntity(existingCharacterPed)
    existingCharacterPed = nil
  end
end

--- Get the current existing character ped entity
---@return number|nil The ped entity or nil if not spawned
local function GetExistingCharacterPed()
  return existingCharacterPed
end

RegisterNetEvent('ambitions-multicharacter:client:spawnExistingCharacter', function(characterData)
  SpawnExistingCharacter(characterData)
end)

RegisterNetEvent('ambitions-multicharacter:client:hideExistingCharacter', function()
  HideExistingCharacter()
end)

return {
  SpawnExistingCharacter = SpawnExistingCharacter,
  HideExistingCharacter = HideExistingCharacter,
  GetExistingCharacterPed = GetExistingCharacterPed,
}
