--- Register all clothing-related NUI callbacks for real-time clothing customization
---@return nil
function RegisterClothingCallbacks()
  RegisterNUICallback('applyMaskCustomization', function(data, cb)
    ApplyMaskCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyTorsoCustomization', function(data, cb)
    ApplyTorsoCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLegsCustomization', function(data, cb)
    ApplyLegsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBagsCustomization', function(data, cb)
    ApplyBagsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyShoesCustomization', function(data, cb)
    ApplyShoesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyAccessoriesCustomization', function(data, cb)
    ApplyAccessoriesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyUndershirtsCustomization', function(data, cb)
    ApplyUndershirtsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyArmorCustomization', function(data, cb)
    ApplyArmorCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyDecalsCustomization', function(data, cb)
    ApplyDecalsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyTopsCustomization', function(data, cb)
    ApplyTopsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('getClothingLimits', function(_, cb)
    local limits = GetClothingLimits()
    cb(limits)
  end)

  RegisterNUICallback('getClothingTextureLimit', function(data, cb)
    local limit = GetClothingTextureLimit(data.component, data.drawable)
    cb({ limit = limit })
  end)
end
