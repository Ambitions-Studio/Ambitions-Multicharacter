local identifiers = require('Ambitions.server.lib.player.identifiers')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')
local spawnConfig = require('config.spawn')

--- Setup character selection by retrieving all characters for a user
---@param sessionId number The session id of the player
local function SetupCharacter(sessionId)
  local PLAYER_IDENTIFIERS <const> = identifiers.get(sessionId)
  local PLAYER_LICENSE <const> = PLAYER_IDENTIFIERS.license

  if not PLAYER_LICENSE then
    ambitionsPrint.error('Failed to get player license in SetupCharacter for session: ', sessionId)
    return
  end

  if spawnConfig.instanceSpawning then
    SetPlayerRoutingBucket(sessionId, sessionId)
  end

  local userId = MySQL.scalar.await('SELECT id FROM users WHERE license = ?', { PLAYER_LICENSE })

  if not userId then
    ambitionsPrint.error('User not found in SetupCharacter for license: ', PLAYER_LICENSE)
    return
  end

  local characters = MySQL.query.await('SELECT * FROM characters WHERE user_id = ? ORDER BY created_at ASC', { userId })
  local characterData = {}

  if characters and #characters > 0 then
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
  end

  TriggerClientEvent('ambitions-multicharacter:client:openInterface', sessionId, {
    characters = characterData
  })
end

RegisterNetEvent('ambitions-multicharacter:server:setupCharacter', function()
  local SESSION_ID <const> = source
  SetupCharacter(SESSION_ID)
end)
--- Create a new user in the database
---@param sessionId number The session id of the player
---@param identifiers table The identifiers of the player
local function CreateUser(sessionId, identifiers)
  local PLAYER_LICENSE <const> = identifiers.license
  local PLAYER_DISCORD_ID <const> = identifiers.discord
  local PLAYER_IP <const> = identifiers.ip

  if not PLAYER_LICENSE or not PLAYER_IP or not PLAYER_DISCORD_ID then
    ambitionsPrint.error('failed to get mandatory identifiers for player: ', sessionId)
    DropPlayer(sessionId, 'Failed to get your identifiers, please contact an administrator.')

    return
  end

  local userId = MySQL.insert.await('INSERT INTO users (license, discord_id, ip) VALUES (?, ?, ?)', { PLAYER_LICENSE, PLAYER_DISCORD_ID, PLAYER_IP })

  if not userId then
    ambitionsPrint.error('Failed to create user with license: ', PLAYER_LICENSE)
    DropPlayer(sessionId, 'Failed to create your user, please contact an administrator.')

    return
  end

  TriggerClientEvent('ambitions-multicharacter:client:prepareCharacterSelection', sessionId)
end

--- Check if the player is a new user or not and create a new user if needed or retrieve all the user data if the user already exists
local function CheckPlayerData()
  local SESSION_ID <const> = source
  local PLAYER_IDENTIFIERS <const> = identifiers.get(SESSION_ID)
  local PLAYER_LICENSE <const> = PLAYER_IDENTIFIERS.license

  if not PLAYER_LICENSE then
    ambitionsPrint.error('Failed to get player license for session id : ', SESSION_ID)
    DropPlayer(SESSION_ID, 'Failed to get your FiveM license, please contact an administrator.')

    return
  end

  MySQL.Async.fetchScalar('SELECT id FROM users WHERE license = ?', { PLAYER_LICENSE }, function(result)
    if not result then
      CreateUser(SESSION_ID, PLAYER_IDENTIFIERS)
    else
      TriggerClientEvent('ambitions-multicharacter:client:prepareCharacterSelection', SESSION_ID)
    end
  end)
end

RegisterNetEvent('ambitions-multicharacter:server:checkPlayerData', function()
  CheckPlayerData()
end)