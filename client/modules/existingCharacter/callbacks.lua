--- NUI callback when player selects an existing character slot
---@param data table Contains character object with all character data
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('selectExistingCharacter', function(data, cb)
  if not data.character then
    cb({ success = false, error = 'No character data' })
    return
  end

  TriggerEvent('ambitions-multicharacter:client:spawnExistingCharacter', data.character)

  cb({ success = true })
end)

--- NUI callback when player deselects an existing character slot
---@param data table Empty table or contains previous character data
---@param cb function Callback function to acknowledge the request
RegisterNUICallback('deselectExistingCharacter', function(data, cb)
  TriggerEvent('ambitions-multicharacter:client:hideExistingCharacter')

  cb({ success = true })
end)