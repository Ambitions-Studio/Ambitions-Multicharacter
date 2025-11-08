local appearanceApply = require('client.modules.appearance.apply')

--- Register all appearance-related NUI callbacks for real-time character customization
---@return nil
local function RegisterAppearanceCallbacks()
  RegisterNUICallback('applyPedModel', function(data, cb)
    appearanceApply.ApplyPedModel(data.pedModel)
    cb('ok')
  end)

  RegisterNUICallback('applyHeritage', function(data, cb)
    appearanceApply.ApplyHeritage(data)
    cb('ok')
  end)

  RegisterNUICallback('applyHairStyle', function(data, cb)
    appearanceApply.ApplyHairStyle(data)
    cb('ok')
  end)

  RegisterNUICallback('applyFaceFeature', function(data, cb)
    appearanceApply.ApplyFaceFeature(data.index, data.value)
    cb('ok')
  end)

  RegisterNUICallback('applyEyesCustomization', function(data, cb)
    appearanceApply.ApplyEyesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyEyebrowsCustomization', function(data, cb)
    appearanceApply.ApplyEyebrowsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNoseCustomization', function(data, cb)
    appearanceApply.ApplyNoseCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyCheeksCustomization', function(data, cb)
    appearanceApply.ApplyCheeksCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBeardCustomization', function(data, cb)
    appearanceApply.ApplyBeardCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyJawCustomization', function(data, cb)
    appearanceApply.ApplyJawCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLipsCustomization', function(data, cb)
    appearanceApply.ApplyLipsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyChinCustomization', function(data, cb)
    appearanceApply.ApplyChinCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNeckCustomization', function(data, cb)
    appearanceApply.ApplyNeckCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyAgeingCustomization', function(data, cb)
    appearanceApply.ApplyAgeingCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyMakeupCustomization', function(data, cb)
    appearanceApply.ApplyMakeupCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBlushCustomization', function(data, cb)
    appearanceApply.ApplyBlushCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyComplexionCustomization', function(data, cb)
    appearanceApply.ApplyComplexionCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applySunDamageCustomization', function(data, cb)
    appearanceApply.ApplySunDamageCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyMolesFrecklesCustomization', function(data, cb)
    appearanceApply.ApplyMolesFrecklesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyChestHairCustomization', function(data, cb)
    appearanceApply.ApplyChestHairCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBodyBlemishesCustomization', function(data, cb)
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
    cb(limits)
  end)
end

return {
  RegisterAppearanceCallbacks = RegisterAppearanceCallbacks,
}
