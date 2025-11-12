
--- Callback to get all characters for the connected player
---@param source number Player server ID
---@return table characters Array of character data
amb.callback.register('ambitions-multicharacter:getCharacters', function(source)
  local PLAYER_IDENTIFIERS <const> = amb.getPlayerIdentifers(source)
  local PLAYER_LICENSE <const> = PLAYER_IDENTIFIERS.license

  if not PLAYER_LICENSE then
    return {}
  end

  if spawnConfig.instanceSpawning then
    SetPlayerRoutingBucket(source, source)
  end

  local userId = MySQL.scalar.await('SELECT id FROM users WHERE license = ?', { PLAYER_LICENSE })

  if not userId then
    return {}
  end

  local characters = MySQL.query.await('SELECT * FROM characters WHERE user_id = ? ORDER BY created_at ASC', { userId })

  if not characters or #characters == 0 then
    return {}
  end

  local characterData = {}

  for i = 1, #characters do
    local char = characters[i]
    local appearanceData = nil

    if char.appearance and char.appearance ~= '' then
      local success, decoded = pcall(json.decode, char.appearance)
      if success then
        appearanceData = decoded
      end
    end

    characterData[#characterData + 1] = {
      id = char.id,
      uniqueId = char.unique_id,
      firstName = char.firstname,
      lastName = char.lastname,
      dateOfBirth = char.dateofbirth,
      gender = char.sex,
      nationality = char.nationality,
      height = char.height,
      appearance = appearanceData,
      job = nil,
      jobGrade = nil,
      crew = nil,
      crewGrade = nil,
      cash = 0,
      bank = 0,
      dirtyMoney = 0,
      licenses = {},
      totalPlaytime = '0h 0m',
      lastPlayed = nil,
      pedModel = char.ped_model,
      position = {
        x = char.position_x,
        y = char.position_y,
        z = char.position_z,
        heading = char.heading
      },
      playtime = char.playtime or 0,
      createdAt = char.created_at
    }
  end

  return characterData
end)

--- Callback to delete a character by unique ID
---@param source number Player server ID
---@param uniqueId string The unique ID of the character to delete
---@return table result Deletion result with success status
amb.callback.register('ambitions-multicharacter:deleteCharacter', function(source, uniqueId)
  if not uniqueId or uniqueId == '' then
    return {
      success = false,
      error = 'Invalid unique ID'
    }
  end

  local result = MySQL.query.await('DELETE FROM characters WHERE unique_id = ?', { uniqueId })

  if result and result.affectedRows and result.affectedRows > 0 then
    Wait(500)
    SetupCharacter(source)

    return {
      success = true
    }
  else
    return {
      success = false,
      error = 'Character not found or already deleted'
    }
  end
end)

--- Create a new user in the database
---@param sessionId number The session id of the player
---@param identifiers table The identifiers of the player
local function CreateUser(sessionId, identifiers)
  local PLAYER_LICENSE <const> = identifiers.license
  local PLAYER_DISCORD_ID <const> = identifiers.discord
  local PLAYER_IP <const> = identifiers.ip

  if not PLAYER_LICENSE or not PLAYER_IP or not PLAYER_DISCORD_ID then
    DropPlayer(sessionId, 'Failed to get your identifiers, please contact an administrator.')
    return
  end

  local userId = MySQL.insert.await('INSERT INTO users (license, discord_id, ip) VALUES (?, ?, ?)', { PLAYER_LICENSE, PLAYER_DISCORD_ID, PLAYER_IP })

  if not userId then
    DropPlayer(sessionId, 'Failed to create your user, please contact an administrator.')
    return
  end

  TriggerClientEvent('ambitions-multicharacter:client:prepareCharacterSelection', sessionId)
end

--- Check if the player is a new user or not and create a new user if needed or retrieve all the user data if the user already exists
local function CheckPlayerData()
  local SESSION_ID <const> = source

  local PLAYER_IDENTIFIERS <const> = amb.getPlayerIdentifers(SESSION_ID)
  local PLAYER_LICENSE <const> = PLAYER_IDENTIFIERS.license

  if not PLAYER_LICENSE then
    DropPlayer(SESSION_ID, 'Failed to get your FiveM license, please contact an administrator.')
    return
  end

  local userId = MySQL.scalar.await('SELECT id FROM users WHERE license = ?', { PLAYER_LICENSE })

  if not userId then
    CreateUser(SESSION_ID, PLAYER_IDENTIFIERS)
  else
    TriggerClientEvent('ambitions-multicharacter:client:prepareCharacterSelection', SESSION_ID)
  end
end

RegisterNetEvent('ambitions-multicharacter:server:checkPlayerData', function()
  CheckPlayerData()
end)

--- Check if the unique id is already in use by a character
---@param uniqueId string The unique id to check
---@return boolean isInUse True if the unique id is in use, false otherwise
local function isUniqueIdInUse(uniqueId)
  local count = MySQL.scalar.await('SELECT COUNT(*) FROM characters WHERE unique_id = ?', { uniqueId })
  return count > 0
end

--- Get a valid unique id for the character
---@param sessionId number The session id of the player
---@return string | nil uniqueId The unique id or nil if failed to generate a valid unique id
local function GetValidUniqueId(sessionId)
  local uniqueId
  local maxAttempts = 10

  for _ = 1, maxAttempts do
    uniqueId = amb.math.randomAlphanumeric(6)
    if not isUniqueIdInUse(uniqueId) then
      return uniqueId
    end
  end

  return nil
end

--- Callback to create a new character for the player
---@param source number Player server ID
---@param data table Character creation data containing identity and appearance
---@return table result Creation result with success status
amb.callback.register('ambitions-multicharacter:createCharacter', function(source, data)
  local PLAYER_IDENTIFIERS <const> = amb.getPlayerIdentifers(source)
  local PLAYER_LICENSE <const> = PLAYER_IDENTIFIERS.license

  if not PLAYER_LICENSE then
    return {
      success = false,
      error = 'Failed to retrieve player identifiers'
    }
  end

  local userId = MySQL.scalar.await('SELECT id FROM users WHERE license = ?', { PLAYER_LICENSE })

  if not userId then
    return {
      success = false,
      error = 'User not found in database'
    }
  end

  local characterCount = MySQL.scalar.await('SELECT COUNT(*) FROM characters WHERE user_id = ?', { userId })

  if characterCount >= spawnConfig.characterSlots then
    return {
      success = false,
      error = 'Character slot limit reached'
    }
  end

  local uniqueId = GetValidUniqueId(source)

  if not uniqueId then
    return {
      success = false,
      error = 'Failed to generate unique character ID'
    }
  end

  local identity = data.identity
  local appearance = data.appearance

  local pedModel = appearance.ped and appearance.ped.selectedPed or 'mp_m_freemode_01'
  local appearanceJson = json.encode(appearance)

  local gender = identity.gender and string.lower(identity.gender) or 'm'

  local playerSpawn = spawnConfig.playerSpawn
  local posX = playerSpawn.x
  local posY = playerSpawn.y
  local posZ = playerSpawn.z
  local heading = playerSpawn.w or 0.0

  local insertId = MySQL.insert.await([[
    INSERT INTO characters
    (user_id, unique_id, firstname, lastname, dateofbirth, sex, nationality, height, appearance, `group`, ped_model, position_x, position_y, position_z, heading)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  ]], {
    userId,
    uniqueId,
    identity.firstName,
    identity.lastName,
    identity.dateOfBirth,
    gender,
    identity.nationality,
    identity.height,
    appearanceJson,
    'user',
    pedModel,
    posX,
    posY,
    posZ,
    heading
  })

  if not insertId then
    return {
      success = false,
      error = 'Database insertion failed'
    }
  end

  return {
    success = true,
    characterId = insertId,
    uniqueId = uniqueId
  }
end)