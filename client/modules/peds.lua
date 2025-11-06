local pedsConfig = require('config.peds')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client peds module loaded')

--- Format ped list for NUI
---@return table Formatted ped models with title, value and category
local function FormatPedsForNUI()
  local formattedPeds = {}

  -- Add basics first (always shown)
  for _, pedValue in ipairs(pedsConfig.pedList.basics) do
    table.insert(formattedPeds, {
      title = GetLabelText(pedValue) ~= 'NULL' and GetLabelText(pedValue) or pedValue,
      value = pedValue,
      category = 'Basics'
    })
  end

  -- Add other peds only if authorized
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

return {
  GetPedsConfig = GetPedsConfig,
  SendPedsConfigToNUI = SendPedsConfigToNUI,
  FormatPedsForNUI = FormatPedsForNUI
}
