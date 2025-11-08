local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client accessories module loaded')

--- Get available accessory variations for current ped
---@return table Table containing max values for hats, glasses, earrings, watches, bracelets, neckAccessories
local function GetAccessoriesLimits()
  local ped = PlayerPedId()

  return {
    hats = GetNumberOfPedPropDrawableVariations(ped, 0) - 1,
    glasses = GetNumberOfPedPropDrawableVariations(ped, 1) - 1,
    earrings = GetNumberOfPedPropDrawableVariations(ped, 2) - 1,
    watches = GetNumberOfPedPropDrawableVariations(ped, 6) - 1,
    bracelets = GetNumberOfPedPropDrawableVariations(ped, 7) - 1,
    neckAccessories = GetNumberOfPedDrawableVariations(ped, 7) - 1,
  }
end

--- Get texture variation limit for a specific accessory prop
---@param prop number The prop index
---@param drawable number The drawable index
---@return number The maximum texture variation index
local function GetAccessoryTextureLimit(prop, drawable)
  local ped = PlayerPedId()
  return GetNumberOfPedPropTextureVariations(ped, prop, drawable) - 1
end

--- Apply hat customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyHatCustomization(data)
  local ped = PlayerPedId()

  if data.type == -1 or data.type == 0 then
    ClearPedProp(ped, 0)
  else
    SetPedPropIndex(ped, 0, data.type, data.variant, true)
  end

  ambitionsPrint.info('Applied hat - Type:', data.type, 'Variant:', data.variant)
end

--- Apply glasses customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyGlassesCustomization(data)
  local ped = PlayerPedId()

  if data.type == -1 or data.type == 0 then
    ClearPedProp(ped, 1)
  else
    SetPedPropIndex(ped, 1, data.type, data.variant, true)
  end

  ambitionsPrint.info('Applied glasses - Type:', data.type, 'Variant:', data.variant)
end

--- Apply earrings customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyEarringsCustomization(data)
  local ped = PlayerPedId()

  if data.type == -1 or data.type == 0 then
    ClearPedProp(ped, 2)
  else
    SetPedPropIndex(ped, 2, data.type, data.variant, true)
  end

  ambitionsPrint.info('Applied earrings - Type:', data.type, 'Variant:', data.variant)
end

--- Apply watch customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyWatchCustomization(data)
  local ped = PlayerPedId()

  if data.type == -1 or data.type == 0 then
    ClearPedProp(ped, 6)
  else
    SetPedPropIndex(ped, 6, data.type, data.variant, true)
  end

  ambitionsPrint.info('Applied watch - Type:', data.type, 'Variant:', data.variant)
end

--- Apply bracelet customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyBraceletCustomization(data)
  local ped = PlayerPedId()

  if data.type == -1 or data.type == 0 then
    ClearPedProp(ped, 7)
  else
    SetPedPropIndex(ped, 7, data.type, data.variant, true)
  end

  ambitionsPrint.info('Applied bracelet - Type:', data.type, 'Variant:', data.variant)
end

--- Apply neck accessory customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyNeckAccessoryCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 7, data.type, data.variant, 0)

  ambitionsPrint.info('Applied neck accessory - Type:', data.type, 'Variant:', data.variant)
end

return {
  ApplyHatCustomization = ApplyHatCustomization,
  ApplyGlassesCustomization = ApplyGlassesCustomization,
  ApplyEarringsCustomization = ApplyEarringsCustomization,
  ApplyWatchCustomization = ApplyWatchCustomization,
  ApplyBraceletCustomization = ApplyBraceletCustomization,
  ApplyNeckAccessoryCustomization = ApplyNeckAccessoryCustomization,
  GetAccessoriesLimits = GetAccessoriesLimits,
  GetAccessoryTextureLimit = GetAccessoryTextureLimit,
}
