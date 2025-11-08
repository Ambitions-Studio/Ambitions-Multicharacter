local accessoriesApply = require('client.modules.accessories.apply')

--- Register all accessories-related NUI callbacks for real-time accessories customization
---@return nil
local function RegisterAccessoriesCallbacks()
  RegisterNUICallback('applyHatCustomization', function(data, cb)
    accessoriesApply.ApplyHatCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyGlassesCustomization', function(data, cb)
    accessoriesApply.ApplyGlassesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyEarringsCustomization', function(data, cb)
    accessoriesApply.ApplyEarringsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyWatchCustomization', function(data, cb)
    accessoriesApply.ApplyWatchCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBraceletCustomization', function(data, cb)
    accessoriesApply.ApplyBraceletCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNeckAccessoryCustomization', function(data, cb)
    accessoriesApply.ApplyNeckAccessoryCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('getAccessoriesLimits', function(_, cb)
    local limits = accessoriesApply.GetAccessoriesLimits()
    cb(limits)
  end)

  RegisterNUICallback('getAccessoryTextureLimit', function(data, cb)
    local limit = accessoriesApply.GetAccessoryTextureLimit(data.prop, data.drawable)
    cb({ limit = limit })
  end)
end

return {
  RegisterAccessoriesCallbacks = RegisterAccessoriesCallbacks,
}
