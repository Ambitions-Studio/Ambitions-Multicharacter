local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Existing character callbacks module loaded')

--- NUI callback when player selects an existing character slot
---@param data table Contains character object with all character data
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('selectExistingCharacter', function(data, cb)
  ambitionsPrint.info('Received selectExistingCharacter callback from NUI')

  if not data.character then
    ambitionsPrint.error('No character data provided in selectExistingCharacter callback')
    cb({ success = false, error = 'No character data' })
    return
  end

  ambitionsPrint.info('Character ID:', data.character.id)
  ambitionsPrint.info('Character Name:', data.character.firstName, data.character.lastName)

  TriggerEvent('ambitions-multicharacter:client:spawnExistingCharacter', data.character)

  cb({ success = true })
end)

--- NUI callback when player deselects an existing character slot
---@param data table Empty table or contains previous character data
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('deselectExistingCharacter', function(data, cb)
  ambitionsPrint.info('Received deselectExistingCharacter callback from NUI')

  TriggerEvent('ambitions-multicharacter:client:hideExistingCharacter')

  cb({ success = true })
end)

return {}
