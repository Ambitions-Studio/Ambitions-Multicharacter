local identifiers = require('Ambitions.server.lib.player.identifiers')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')
local spawnConfig = require('config.spawn')

ambitionsPrint.info('Server module loaded')

--- Setup character selection by retrieving all characters for a user
---@param sessionId number The session id of the player
local function SetupCharacter(sessionId)
  ambitionsPrint.info('SetupCharacter called for session:', sessionId)

  local PLAYER_IDENTIFIERS <const> = identifiers.get(sessionId)
  local PLAYER_LICENSE <const> = PLAYER_IDENTIFIERS.license

  if not PLAYER_LICENSE then
    ambitionsPrint.error('Failed to get player license in SetupCharacter for session:', sessionId)
    return
  end

  ambitionsPrint.success('Player license retrieved:', PLAYER_LICENSE)

  if spawnConfig.instanceSpawning then
    ambitionsPrint.info('Setting player routing bucket to:', sessionId)
    SetPlayerRoutingBucket(sessionId, sessionId)
  end

  ambitionsPrint.info('Querying database for user with license:', PLAYER_LICENSE)
  local userId = MySQL.scalar.await('SELECT id FROM users WHERE license = ?', { PLAYER_LICENSE })

  if not userId then
    ambitionsPrint.error('User not found in SetupCharacter for license:', PLAYER_LICENSE)
    return
  end

  ambitionsPrint.success('User found with ID:', userId)

  ambitionsPrint.info('Querying characters for user ID:', userId)
  local characters = MySQL.query.await('SELECT * FROM characters WHERE user_id = ? ORDER BY created_at ASC', { userId })
  local characterData = {}

  if characters and #characters > 0 then
    ambitionsPrint.success('Found', #characters, 'character(s) for user')
    for i = 1, #characters do
      local char = characters[i]
      characterData[#characterData + 1] = {
        id = char.id,
        uniqueId = char.unique_id,
        firstname = char.firstname,
        lastname = char.lastname,
        dateofbirth = char.dateofbirth,
        sex = char.sex,
        nationality = char.nationality,
        height = char.height,
        appearance = char.appearance,
        group = char.group,
        pedModel = char.ped_model,
        position = {
          x = char.position_x,
          y = char.position_y,
          z = char.position_z,
          heading = char.heading
        },
        playtime = char.playtime,
        createdAt = char.created_at,
        lastPlayed = char.last_played
      }
    end
  else
    ambitionsPrint.info('No characters found for user - empty slots')
  end

  ambitionsPrint.info('Sending openInterface event to client with', #characterData, 'character(s)')
  TriggerClientEvent('ambitions-multicharacter:client:openInterface', sessionId, {
    characters = characterData
  })
end

RegisterNetEvent('ambitions-multicharacter:server:setupCharacter', function()
  local SESSION_ID <const> = source
  ambitionsPrint.info('Received setupCharacter event from client session:', SESSION_ID)
  SetupCharacter(SESSION_ID)
end)
--- Create a new user in the database
---@param sessionId number The session id of the player
---@param identifiers table The identifiers of the player
local function CreateUser(sessionId, identifiers)
  ambitionsPrint.info('CreateUser called for new player session:', sessionId)

  local PLAYER_LICENSE <const> = identifiers.license
  local PLAYER_DISCORD_ID <const> = identifiers.discord
  local PLAYER_IP <const> = identifiers.ip

  if not PLAYER_LICENSE or not PLAYER_IP or not PLAYER_DISCORD_ID then
    ambitionsPrint.error('Failed to get mandatory identifiers for player:', sessionId)
    DropPlayer(sessionId, 'Failed to get your identifiers, please contact an administrator.')
    return
  end

  ambitionsPrint.info('Inserting new user in database with license:', PLAYER_LICENSE)
  local userId = MySQL.insert.await('INSERT INTO users (license, discord_id, ip) VALUES (?, ?, ?)', { PLAYER_LICENSE, PLAYER_DISCORD_ID, PLAYER_IP })

  if not userId then
    ambitionsPrint.error('Failed to create user with license:', PLAYER_LICENSE)
    DropPlayer(sessionId, 'Failed to create your user, please contact an administrator.')
    return
  end

  ambitionsPrint.success('User created with ID:', userId, 'for session:', sessionId)
  ambitionsPrint.info('Triggering prepareCharacterSelection for new user')
  TriggerClientEvent('ambitions-multicharacter:client:prepareCharacterSelection', sessionId)
end

--- Check if the player is a new user or not and create a new user if needed or retrieve all the user data if the user already exists
local function CheckPlayerData()
  local SESSION_ID <const> = source
  ambitionsPrint.info('CheckPlayerData called for session:', SESSION_ID)

  local PLAYER_IDENTIFIERS <const> = identifiers.get(SESSION_ID)
  local PLAYER_LICENSE <const> = PLAYER_IDENTIFIERS.license

  if not PLAYER_LICENSE then
    ambitionsPrint.error('Failed to get player license for session id:', SESSION_ID)
    DropPlayer(SESSION_ID, 'Failed to get your FiveM license, please contact an administrator.')
    return
  end

  ambitionsPrint.info('Checking if user exists with license:', PLAYER_LICENSE)
  local userId = MySQL.scalar.await('SELECT id FROM users WHERE license = ?', { PLAYER_LICENSE })

  if not userId then
    ambitionsPrint.info('User not found - creating new user')
    CreateUser(SESSION_ID, PLAYER_IDENTIFIERS)
  else
    ambitionsPrint.success('Existing user found with ID:', userId)
    ambitionsPrint.info('Triggering prepareCharacterSelection for existing user')
    TriggerClientEvent('ambitions-multicharacter:client:prepareCharacterSelection', SESSION_ID)
  end
end

RegisterNetEvent('ambitions-multicharacter:server:checkPlayerData', function()
  ambitionsPrint.info('Received checkPlayerData event from client')
  CheckPlayerData()
end)

--- Generate a unique character ID
---@return string uniqueId The unique character ID in format AMCXXXXXXXXXXXX
local function GenerateUniqueCharacterId()
  local charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  local uniqueId = 'AMC'

  for i = 1, 12 do
    local randomIndex = math.random(1, #charset)
    uniqueId = uniqueId .. charset:sub(randomIndex, randomIndex)
  end

  local exists = MySQL.scalar.await('SELECT id FROM characters WHERE unique_id = ?', { uniqueId })

  if exists then
    return GenerateUniqueCharacterId()
  end

  return uniqueId
end

--- Create a new character in the database
---@param sessionId number The session id of the player
---@param data table The character data containing identity, appearance and slot
local function CreateCharacter(sessionId, data)
  ambitionsPrint.success('========== CREATE CHARACTER START ==========')
  ambitionsPrint.info('Session ID:', sessionId)
  ambitionsPrint.info('Slot:', data.slot)

  local PLAYER_IDENTIFIERS <const> = identifiers.get(sessionId)
  local PLAYER_LICENSE <const> = PLAYER_IDENTIFIERS.license

  if not PLAYER_LICENSE then
    ambitionsPrint.error('Failed to get player license for session:', sessionId)
    TriggerClientEvent('ambitions-multicharacter:client:characterCreationResult', sessionId, {
      success = false,
      error = 'Failed to retrieve player identifiers'
    })
    return
  end

  ambitionsPrint.info('Getting user ID for license:', PLAYER_LICENSE)
  local userId = MySQL.scalar.await('SELECT id FROM users WHERE license = ?', { PLAYER_LICENSE })

  if not userId then
    ambitionsPrint.error('User not found for license:', PLAYER_LICENSE)
    TriggerClientEvent('ambitions-multicharacter:client:characterCreationResult', sessionId, {
      success = false,
      error = 'User not found in database'
    })
    return
  end

  ambitionsPrint.success('User ID found:', userId)

  local characterCount = MySQL.scalar.await('SELECT COUNT(*) FROM characters WHERE user_id = ?', { userId })

  if characterCount >= spawnConfig.characterSlots then
    ambitionsPrint.error('Character limit reached for user:', userId)
    TriggerClientEvent('ambitions-multicharacter:client:characterCreationResult', sessionId, {
      success = false,
      error = 'Character slot limit reached'
    })
    return
  end

  local uniqueId = GenerateUniqueCharacterId()
  ambitionsPrint.info('Generated unique ID:', uniqueId)

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

  ambitionsPrint.info('Inserting character into database...')
  ambitionsPrint.info('  First Name:', identity.firstName)
  ambitionsPrint.info('  Last Name:', identity.lastName)
  ambitionsPrint.info('  Date of Birth:', identity.dateOfBirth)
  ambitionsPrint.info('  Gender:', gender)
  ambitionsPrint.info('  Nationality:', identity.nationality)
  ambitionsPrint.info('  Height:', identity.height)
  ambitionsPrint.info('  Ped Model:', pedModel)
  ambitionsPrint.info('  Spawn Position:', posX, posY, posZ, heading)

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
    ambitionsPrint.error('Failed to insert character into database')
    TriggerClientEvent('ambitions-multicharacter:client:characterCreationResult', sessionId, {
      success = false,
      error = 'Database insertion failed'
    })
    return
  end

  ambitionsPrint.success('Character created successfully!')
  ambitionsPrint.success('  Database ID:', insertId)
  ambitionsPrint.success('  Unique ID:', uniqueId)
  ambitionsPrint.success('========== CREATE CHARACTER END ==========')

  TriggerClientEvent('ambitions-multicharacter:client:characterCreationResult', sessionId, {
    success = true,
    characterId = insertId,
    uniqueId = uniqueId
  })

  SetupCharacter(sessionId)
end

RegisterNetEvent('ambitions-multicharacter:server:createCharacter', function(data)
  local SESSION_ID <const> = source
  ambitionsPrint.info('Received createCharacter event from client session:', SESSION_ID)
  CreateCharacter(SESSION_ID, data)
end)