local accessoriesApply = require('client.modules.accessories.apply')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client accessories callbacks module loaded')

--- Register all accessories-related NUI callbacks for real-time accessories customization
---@return nil
local function RegisterAccessoriesCallbacks()
  RegisterNUICallback('applyHatCustomization', function(data, cb)
    ambitionsPrint.info('Applying hat customization in real-time')
    accessoriesApply.ApplyHatCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyGlassesCustomization', function(data, cb)
    ambitionsPrint.info('Applying glasses customization in real-time')
    accessoriesApply.ApplyGlassesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyEarringsCustomization', function(data, cb)
    ambitionsPrint.info('Applying earrings customization in real-time')
    accessoriesApply.ApplyEarringsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyWatchCustomization', function(data, cb)
    ambitionsPrint.info('Applying watch customization in real-time')
    accessoriesApply.ApplyWatchCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBraceletCustomization', function(data, cb)
    ambitionsPrint.info('Applying bracelet customization in real-time')
    accessoriesApply.ApplyBraceletCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNeckAccessoryCustomization', function(data, cb)
    ambitionsPrint.info('Applying neck accessory customization in real-time')
    accessoriesApply.ApplyNeckAccessoryCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('getAccessoriesLimits', function(_, cb)
    local limits = accessoriesApply.GetAccessoriesLimits()
    ambitionsPrint.info('Sending accessories limits to UI')
    cb(limits)
  end)

  RegisterNUICallback('getAccessoryTextureLimit', function(data, cb)
    local limit = accessoriesApply.GetAccessoryTextureLimit(data.prop, data.drawable)
    cb({ limit = limit })
  end)

  ambitionsPrint.success('Registered all accessories callbacks')
end

return {
  RegisterAccessoriesCallbacks = RegisterAccessoriesCallbacks,
}
