--- Register all appearance-related NUI callbacks for real-time character customization
---@return nil
function RegisterAppearanceCallbacks()
  RegisterNUICallback('applyPedModel', function(data, cb)
    ApplyPedModel(data.pedModel)
    cb('ok')
  end)

  RegisterNUICallback('applyHeritage', function(data, cb)
    ApplyHeritage(data)
    cb('ok')
  end)

  RegisterNUICallback('applyHairStyle', function(data, cb)
    ApplyHairStyle(data)
    cb('ok')
  end)

  RegisterNUICallback('applyFaceFeature', function(data, cb)
    ApplyFaceFeature(data.index, data.value)
    cb('ok')
  end)

  RegisterNUICallback('applyEyesCustomization', function(data, cb)
    ApplyEyesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyEyebrowsCustomization', function(data, cb)
    ApplyEyebrowsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNoseCustomization', function(data, cb)
    ApplyNoseCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyCheeksCustomization', function(data, cb)
    ApplyCheeksCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBeardCustomization', function(data, cb)
    ApplyBeardCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyJawCustomization', function(data, cb)
    ApplyJawCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLipsCustomization', function(data, cb)
    ApplyLipsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyChinCustomization', function(data, cb)
    ApplyChinCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNeckCustomization', function(data, cb)
    ApplyNeckCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyAgeingCustomization', function(data, cb)
    ApplyAgeingCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyMakeupCustomization', function(data, cb)
    ApplyMakeupCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBlushCustomization', function(data, cb)
    ApplyBlushCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyComplexionCustomization', function(data, cb)
    ApplyComplexionCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applySunDamageCustomization', function(data, cb)
    ApplySunDamageCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyMolesFrecklesCustomization', function(data, cb)
    ApplyMolesFrecklesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyChestHairCustomization', function(data, cb)
    ApplyChestHairCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBodyBlemishesCustomization', function(data, cb)
    ApplyBodyBlemishesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyHeadOverlay', function(data, cb)
    ApplyHeadOverlay(data)
    cb('ok')
  end)

  RegisterNUICallback('applyClothing', function(data, cb)
    ApplyClothing(data)
    cb('ok')
  end)

  RegisterNUICallback('applyProp', function(data, cb)
    ApplyProp(data)
    cb('ok')
  end)

  RegisterNUICallback('getCustomizationLimits', function(data, cb)
    local limits = GetCustomizationLimits()
    cb(limits)
  end)
end