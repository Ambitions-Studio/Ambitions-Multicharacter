local clothingApply = require('client.modules.clothing.apply')

--- Register all clothing-related NUI callbacks for real-time clothing customization
---@return nil
local function RegisterClothingCallbacks()
  RegisterNUICallback('applyMaskCustomization', function(data, cb)
    clothingApply.ApplyMaskCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyTorsoCustomization', function(data, cb)
    clothingApply.ApplyTorsoCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLegsCustomization', function(data, cb)
    clothingApply.ApplyLegsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBagsCustomization', function(data, cb)
    clothingApply.ApplyBagsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyShoesCustomization', function(data, cb)
    clothingApply.ApplyShoesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyAccessoriesCustomization', function(data, cb)
    clothingApply.ApplyAccessoriesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyUndershirtsCustomization', function(data, cb)
    clothingApply.ApplyUndershirtsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyArmorCustomization', function(data, cb)
    clothingApply.ApplyArmorCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyDecalsCustomization', function(data, cb)
    clothingApply.ApplyDecalsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyTopsCustomization', function(data, cb)
    clothingApply.ApplyTopsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('getClothingLimits', function(_, cb)
    local limits = clothingApply.GetClothingLimits()
    cb(limits)
  end)

  RegisterNUICallback('getClothingTextureLimit', function(data, cb)
    local limit = clothingApply.GetClothingTextureLimit(data.component, data.drawable)
    cb({ limit = limit })
  end)
end

return {
  RegisterClothingCallbacks = RegisterClothingCallbacks,
}
