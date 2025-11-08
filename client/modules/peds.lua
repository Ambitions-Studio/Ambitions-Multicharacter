local pedsConfig = require('config.peds')
local heritageConfig = require('config.heritage')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client peds module loaded')

--- Format ped list for NUI
---@return table Formatted ped models with title, value and category
local function FormatPedsForNUI()
  local formattedPeds = {}

  for _, pedValue in ipairs(pedsConfig.pedList.basics) do
    table.insert(formattedPeds, {
      title = GetLabelText(pedValue) ~= 'NULL' and GetLabelText(pedValue) or pedValue,
      value = pedValue,
      category = 'Basics'
    })
  end

  if pedsConfig.authorizePedwhileInCreator then
    for _, pedValue in ipairs(pedsConfig.pedList.peds) do
      table.insert(formattedPeds, {
        title = GetLabelText(pedValue) ~= 'NULL' and GetLabelText(pedValue) or pedValue,
        value = pedValue,
        category = 'Other Models'
      })
    end
  end

  return formattedPeds
end

--- Get peds configuration for NUI
---@return table Configuration object with authorizePedwhileInCreator and pedModels
local function GetPedsConfig()
  return {
    authorizePedwhileInCreator = pedsConfig.authorizePedwhileInCreator,
    pedModels = FormatPedsForNUI()
  }
end

--- Send peds configuration to NUI
local function SendPedsConfigToNUI()
  local config = GetPedsConfig()

  ambitionsPrint.info('Sending peds config to NUI')
  ambitionsPrint.info('authorizePedwhileInCreator:', config.authorizePedwhileInCreator)
  ambitionsPrint.info('Total ped models:', #config.pedModels)

  SendNUIMessage({
    action = 'setPedsConfig',
    config = config
  })
end

--- Get texture name for heritage portraits
---@param id number The heritage ID
---@param isFemale boolean True for mothers, false for fathers
---@return string textureName The texture filename
local function GetHeritageTexture(id, isFemale)
  if isFemale then
    if id == 45 then
      return 'special_female_0'
    else
      return 'female_' .. (id - 21)
    end
  else
    if id >= 42 then
      return 'special_male_' .. (id - 42)
    else
      return 'male_' .. id
    end
  end
end

--- Format heritage config for NUI with photo paths
---@return table Heritage configuration with fathers and mothers
local function GetHeritageConfig()
  local fathers = {}
  local mothers = {}

  for _, father in ipairs(heritageConfig.fathers) do
    table.insert(fathers, {
      id = father.id,
      name = father.name,
      photo = GetHeritageTexture(father.id, false) .. '.png'
    })
  end

  for _, mother in ipairs(heritageConfig.mothers) do
    table.insert(mothers, {
      id = mother.id,
      name = mother.name,
      photo = GetHeritageTexture(mother.id, true) .. '.png'
    })
  end

  return {
    fathers = fathers,
    mothers = mothers
  }
end

--- Send heritage configuration to NUI
local function SendHeritageConfigToNUI()
  local config = GetHeritageConfig()

  ambitionsPrint.info('Sending heritage config to NUI')
  ambitionsPrint.info('Total fathers:', #config.fathers)
  ambitionsPrint.info('Total mothers:', #config.mothers)

  SendNUIMessage({
    action = 'setHeritageConfig',
    config = config
  })
end

return {
  GetPedsConfig = GetPedsConfig,
  SendPedsConfigToNUI = SendPedsConfigToNUI,
  FormatPedsForNUI = FormatPedsForNUI,
  GetHeritageConfig = GetHeritageConfig,
  SendHeritageConfigToNUI = SendHeritageConfigToNUI,
  GetHeritageTexture = GetHeritageTexture
}
