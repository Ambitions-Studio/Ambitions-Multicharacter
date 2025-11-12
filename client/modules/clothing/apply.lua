--- Get available clothing variations for current ped
---@return table Table containing max values for all clothing components
function GetClothingLimits()
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
function GetClothingTextureLimit(component, drawable)
  local ped = PlayerPedId()
  return GetNumberOfPedTextureVariations(ped, component, drawable) - 1
end

--- Apply mask customization to player ped
---@param data table Contains type number and variant number
---@return nil
function ApplyMaskCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 1, data.type, data.variant, 0)
end

--- Apply torso customization to player ped
---@param data table Contains type number and variant number
---@return nil
function ApplyTorsoCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 11, data.type, data.variant, 0)
end

--- Apply legs customization to player ped
---@param data table Contains type number and variant number
---@return nil
function ApplyLegsCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 4, data.type, data.variant, 0)
end

--- Apply bags customization to player ped
---@param data table Contains type number and variant number
---@return nil
function ApplyBagsCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 5, data.type, data.variant, 0)
end

--- Apply shoes customization to player ped
---@param data table Contains type number and variant number
---@return nil
function ApplyShoesCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 6, data.type, data.variant, 0)
end

--- Apply accessories customization to player ped
---@param data table Contains type number and variant number
---@return nil
function ApplyAccessoriesCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 7, data.type, data.variant, 0)
end

--- Apply undershirts customization to player ped
---@param data table Contains type number and variant number
---@return nil
function ApplyUndershirtsCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 8, data.type, data.variant, 0)
end

--- Apply armor customization to player ped
---@param data table Contains type number and variant number
---@return nil
function ApplyArmorCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 9, data.type, data.variant, 0)
end

--- Apply decals customization to player ped
---@param data table Contains type number and variant number
---@return nil
function ApplyDecalsCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 10, data.type, data.variant, 0)
end

--- Apply tops customization to player ped
---@param data table Contains type number and variant number
---@return nil
function ApplyTopsCustomization(data)
  local ped = PlayerPedId()

  SetPedComponentVariation(ped, 3, data.type, data.variant, 0)
end
