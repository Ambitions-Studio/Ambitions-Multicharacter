local appearanceApply = require('client.modules.appearance.apply')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client appearance callbacks module loaded')

--- Register all appearance-related NUI callbacks for real-time character customization
---@return nil
local function RegisterAppearanceCallbacks()
  RegisterNUICallback('applyPedModel', function(data, cb)
    ambitionsPrint.info('Applying ped model in real-time:', data.pedModel)
    appearanceApply.ApplyPedModel(data.pedModel)
    cb('ok')
  end)

  RegisterNUICallback('applyHeritage', function(data, cb)
    ambitionsPrint.info('Applying heritage in real-time')
    appearanceApply.ApplyHeritage(data)
    cb('ok')
  end)

  RegisterNUICallback('applyHairStyle', function(data, cb)
    ambitionsPrint.info('Applying hair style in real-time')
    appearanceApply.ApplyHairStyle(data)
    cb('ok')
  end)

  RegisterNUICallback('applyFaceFeature', function(data, cb)
    appearanceApply.ApplyFaceFeature(data.index, data.value)
    cb('ok')
  end)

  RegisterNUICallback('applyEyesCustomization', function(data, cb)
    ambitionsPrint.info('Applying eyes customization in real-time')
    appearanceApply.ApplyEyesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyEyebrowsCustomization', function(data, cb)
    ambitionsPrint.info('Applying eyebrows customization in real-time')
    appearanceApply.ApplyEyebrowsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNoseCustomization', function(data, cb)
    ambitionsPrint.info('Applying nose customization in real-time')
    appearanceApply.ApplyNoseCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyCheeksCustomization', function(data, cb)
    ambitionsPrint.info('Applying cheeks customization in real-time')
    appearanceApply.ApplyCheeksCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBeardCustomization', function(data, cb)
    ambitionsPrint.info('Applying beard customization in real-time')
    appearanceApply.ApplyBeardCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyJawCustomization', function(data, cb)
    ambitionsPrint.info('Applying jaw customization in real-time')
    appearanceApply.ApplyJawCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLipsCustomization', function(data, cb)
    ambitionsPrint.info('Applying lips customization in real-time')
    appearanceApply.ApplyLipsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyChinCustomization', function(data, cb)
    ambitionsPrint.info('Applying chin customization in real-time')
    appearanceApply.ApplyChinCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNeckCustomization', function(data, cb)
    ambitionsPrint.info('Applying neck customization in real-time')
    appearanceApply.ApplyNeckCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyAgeingCustomization', function(data, cb)
    ambitionsPrint.info('Applying ageing customization in real-time')
    appearanceApply.ApplyAgeingCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyMakeupCustomization', function(data, cb)
    ambitionsPrint.info('Applying makeup customization in real-time')
    appearanceApply.ApplyMakeupCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBlushCustomization', function(data, cb)
    ambitionsPrint.info('Applying blush customization in real-time')
    appearanceApply.ApplyBlushCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyComplexionCustomization', function(data, cb)
    ambitionsPrint.info('Applying complexion customization in real-time')
    appearanceApply.ApplyComplexionCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applySunDamageCustomization', function(data, cb)
    ambitionsPrint.info('Applying sun damage customization in real-time')
    appearanceApply.ApplySunDamageCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyMolesFrecklesCustomization', function(data, cb)
    ambitionsPrint.info('Applying moles/freckles customization in real-time')
    appearanceApply.ApplyMolesFrecklesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyChestHairCustomization', function(data, cb)
    ambitionsPrint.info('Applying chest hair customization in real-time')
    appearanceApply.ApplyChestHairCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBodyBlemishesCustomization', function(data, cb)
    ambitionsPrint.info('Applying body blemishes customization in real-time')
    appearanceApply.ApplyBodyBlemishesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyHeadOverlay', function(data, cb)
    appearanceApply.ApplyHeadOverlay(data)
    cb('ok')
  end)

  RegisterNUICallback('applyClothing', function(data, cb)
    appearanceApply.ApplyClothing(data)
    cb('ok')
  end)

  RegisterNUICallback('applyProp', function(data, cb)
    appearanceApply.ApplyProp(data)
    cb('ok')
  end)

  RegisterNUICallback('getCustomizationLimits', function(data, cb)
    local limits = appearanceApply.GetCustomizationLimits()
    ambitionsPrint.info('Sending customization limits - Hair styles:', limits.hairStyles)
    cb(limits)
  end)

  ambitionsPrint.success('All appearance callbacks registered')
end

return {
  RegisterAppearanceCallbacks = RegisterAppearanceCallbacks,
}
