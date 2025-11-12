--- Register all accessories-related NUI callbacks for real-time accessories customization
---@return nil
function RegisterAccessoriesCallbacks()
  RegisterNUICallback('applyHatCustomization', function(data, cb)
    ApplyHatCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyGlassesCustomization', function(data, cb)
    ApplyGlassesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyEarringsCustomization', function(data, cb)
    ApplyEarringsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyWatchCustomization', function(data, cb)
    ApplyWatchCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBraceletCustomization', function(data, cb)
    ApplyBraceletCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNeckAccessoryCustomization', function(data, cb)
    ApplyNeckAccessoryCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('getAccessoriesLimits', function(_, cb)
    local limits = GetAccessoriesLimits()
    cb(limits)
  end)

  RegisterNUICallback('getAccessoryTextureLimit', function(data, cb)
    local limit = GetAccessoryTextureLimit(data.prop, data.drawable)
    cb({ limit = limit })
  end)
end
