local ambitionsPrint = require('Ambitions.shared.lib.log.print')
local spawnConfig = require('config.spawn')
local cameraModule = require('client.modules.camera')
local loadAppearance = require('client.modules.existingCharacter.loadAppearance')

ambitionsPrint.info('Existing character spawn module loaded')

---@type number|nil
local existingCharacterPed = nil

--- Spawn an existing character with full appearance customization
---@param characterData table Complete character data including appearance, identity, etc.
---@return nil
local function SpawnExistingCharacter(characterData)
  if not characterData then
    ambitionsPrint.error('No character data provided to SpawnExistingCharacter')
    return
  end

  ambitionsPrint.info('========== SPAWNING EXISTING CHARACTER ==========')
  ambitionsPrint.info('Character ID:', characterData.id)
  ambitionsPrint.info('Name:', characterData.firstName, characterData.lastName)
  ambitionsPrint.info('Gender:', characterData.gender)

  if existingCharacterPed and DoesEntityExist(existingCharacterPed) then
    ambitionsPrint.info('Deleting previous existing character ped')
    DeleteEntity(existingCharacterPed)
    existingCharacterPed = nil
  end

  local pedModel = characterData.gender == 'f' and 'mp_f_freemode_01' or 'mp_m_freemode_01'
  local modelHash = GetHashKey(pedModel)

  ambitionsPrint.info('Loading ped model:', pedModel)
  RequestModel(modelHash)
  while not HasModelLoaded(modelHash) do
    Wait(100)
  end

  local spawnCoords = spawnConfig.characterSelectionSpawn
  existingCharacterPed = CreatePed(4, modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w, false, true)

  if not DoesEntityExist(existingCharacterPed) then
    ambitionsPrint.error('Failed to create existing character ped')
    return
  end

  ambitionsPrint.success('Existing character ped created:', existingCharacterPed)

  SetEntityAlpha(existingCharacterPed, 255, false)
  SetEntityInvincible(existingCharacterPed, true)
  FreezeEntityPosition(existingCharacterPed, true)
  SetBlockingOfNonTemporaryEvents(existingCharacterPed, true)
  SetEntityCollision(existingCharacterPed, false, false)

  ambitionsPrint.info('Ped settings applied (freeze, invincible, no collision)')

  if characterData.appearance then
    ambitionsPrint.info('Loading character appearance...')
    loadAppearance.LoadFullAppearance(existingCharacterPed, characterData.appearance)
  else
    ambitionsPrint.warning('No appearance data found for character')
  end

  local activeCam = cameraModule.GetActiveCamera()
  if activeCam then
    ambitionsPrint.info('Pointing camera at existing character')
    PointCamAtEntity(activeCam, existingCharacterPed, 0.0, 0.0, 0.0, true)
  else
    ambitionsPrint.warning('No active camera found to point at existing character')
  end

  ambitionsPrint.success('========== EXISTING CHARACTER SPAWNED ==========')
end

--- Hide and delete the existing character ped
---@return nil
local function HideExistingCharacter()
  if existingCharacterPed and DoesEntityExist(existingCharacterPed) then
    ambitionsPrint.info('Hiding existing character ped:', existingCharacterPed)
    DeleteEntity(existingCharacterPed)
    existingCharacterPed = nil
    ambitionsPrint.success('Existing character ped deleted')
  else
    ambitionsPrint.info('No existing character ped to hide')
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
