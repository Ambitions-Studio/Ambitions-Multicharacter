local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client clothing module loaded')

--- Get available clothing variations for current ped
---@return table Table containing max values for all clothing components
local function GetClothingLimits()
  local ped = PlayerPedId()

  return {
    masks = GetNumberOfPedDrawableVariations(ped, 1) - 1,
    torsos = GetNumberOfPedDrawableVariations(ped, 11) - 1,
    legs = GetNumberOfPedDrawableVariations(ped, 4) - 1,
    bags = GetNumberOfPedDrawableVariations(ped, 5) - 1,
    shoes = GetNumberOfPedDrawableVariations(ped, 6) - 1,
    accessories = GetNumberOfPedDrawableVariations(ped, 7) - 1,
    undershirts = GetNumberOfPedDrawableVariations(ped, 8) - 1,
    armor = GetNumberOfPedDrawableVariations(ped, 9) - 1,
    decals = GetNumberOfPedDrawableVariations(ped, 10) - 1,
    tops = GetNumberOfPedDrawableVariations(ped, 3) - 1,
  }
end

--- Get texture variation limit for a specific clothing component
---@param component number The component index
---@param drawable number The drawable index
---@return number The maximum texture variation index
local function GetClothingTextureLimit(component, drawable)
  local ped = PlayerPedId()
  return GetNumberOfPedTextureVariations(ped, component, drawable) - 1
end

--- Apply mask customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyMaskCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 1, data.type, data.variant, 0)

  ambitionsPrint.info('Applied mask - Type:', data.type, 'Variant:', data.variant)
end

--- Apply torso customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyTorsoCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 11, data.type, data.variant, 0)

  ambitionsPrint.info('Applied torso - Type:', data.type, 'Variant:', data.variant)
end

--- Apply legs customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyLegsCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 4, data.type, data.variant, 0)

  ambitionsPrint.info('Applied legs - Type:', data.type, 'Variant:', data.variant)
end

--- Apply bags customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyBagsCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 5, data.type, data.variant, 0)

  ambitionsPrint.info('Applied bags - Type:', data.type, 'Variant:', data.variant)
end

--- Apply shoes customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyShoesCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 6, data.type, data.variant, 0)

  ambitionsPrint.info('Applied shoes - Type:', data.type, 'Variant:', data.variant)
end

--- Apply accessories customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyAccessoriesCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 7, data.type, data.variant, 0)

  ambitionsPrint.info('Applied accessories - Type:', data.type, 'Variant:', data.variant)
end

--- Apply undershirts customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyUndershirtsCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 8, data.type, data.variant, 0)

  ambitionsPrint.info('Applied undershirts - Type:', data.type, 'Variant:', data.variant)
end

--- Apply armor customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyArmorCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 9, data.type, data.variant, 0)

  ambitionsPrint.info('Applied armor - Type:', data.type, 'Variant:', data.variant)
end

--- Apply decals customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyDecalsCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 10, data.type, data.variant, 0)

  ambitionsPrint.info('Applied decals - Type:', data.type, 'Variant:', data.variant)
end

--- Apply tops customization to player ped
---@param data table Contains type number and variant number
---@return nil
local function ApplyTopsCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 3, data.type, data.variant, 0)

  ambitionsPrint.info('Applied tops - Type:', data.type, 'Variant:', data.variant)
end

return {
  ApplyMaskCustomization = ApplyMaskCustomization,
  ApplyTorsoCustomization = ApplyTorsoCustomization,
  ApplyLegsCustomization = ApplyLegsCustomization,
  ApplyBagsCustomization = ApplyBagsCustomization,
  ApplyShoesCustomization = ApplyShoesCustomization,
  ApplyAccessoriesCustomization = ApplyAccessoriesCustomization,
  ApplyUndershirtsCustomization = ApplyUndershirtsCustomization,
  ApplyArmorCustomization = ApplyArmorCustomization,
  ApplyDecalsCustomization = ApplyDecalsCustomization,
  ApplyTopsCustomization = ApplyTopsCustomization,
  GetClothingLimits = GetClothingLimits,
  GetClothingTextureLimit = GetClothingTextureLimit,
}
