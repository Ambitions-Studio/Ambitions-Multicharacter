local appearanceApply = require('client.modules.appearance.apply')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client appearance callbacks module loaded')

--- Register all appearance-related NUI callbacks
local function RegisterAppearanceCallbacks()
  -- Real-time ped model change
  RegisterNUICallback('applyPedModel', function(data, cb)
    ambitionsPrint.info('Applying ped model in real-time:', data.pedModel)
    appearanceApply.ApplyPedModel(data.pedModel)
    cb('ok')
  end)

  -- Real-time heritage change
  RegisterNUICallback('applyHeritage', function(data, cb)
    ambitionsPrint.info('Applying heritage in real-time')
    appearanceApply.ApplyHeritage(data)
    cb('ok')
  end)

  -- Real-time hair style change
  RegisterNUICallback('applyHairStyle', function(data, cb)
    ambitionsPrint.info('Applying hair style in real-time')
    appearanceApply.ApplyHairStyle(data)
    cb('ok')
  end)

  -- Real-time face feature change
  RegisterNUICallback('applyFaceFeature', function(data, cb)
    appearanceApply.ApplyFaceFeature(data.index, data.value)
    cb('ok')
  end)

  -- Real-time eyes customization (opening + color)
  RegisterNUICallback('applyEyesCustomization', function(data, cb)
    ambitionsPrint.info('Applying eyes customization in real-time')
    appearanceApply.ApplyEyesCustomization(data)
    cb('ok')
  end)

  -- Real-time eyebrows customization (height, depth, style, color, opacity)
  RegisterNUICallback('applyEyebrowsCustomization', function(data, cb)
    ambitionsPrint.info('Applying eyebrows customization in real-time')
    appearanceApply.ApplyEyebrowsCustomization(data)
    cb('ok')
  end)

  -- Real-time nose customization (width, height, length, bridge, bridgeTwist, tipHeight)
  RegisterNUICallback('applyNoseCustomization', function(data, cb)
    ambitionsPrint.info('Applying nose customization in real-time')
    appearanceApply.ApplyNoseCustomization(data)
    cb('ok')
  end)

  -- Real-time cheeks customization (boneHeight, boneWidth, width)
  RegisterNUICallback('applyCheeksCustomization', function(data, cb)
    ambitionsPrint.info('Applying cheeks customization in real-time')
    appearanceApply.ApplyCheeksCustomization(data)
    cb('ok')
  end)

  -- Real-time beard customization (style, color, opacity)
  RegisterNUICallback('applyBeardCustomization', function(data, cb)
    ambitionsPrint.info('Applying beard customization in real-time')
    appearanceApply.ApplyBeardCustomization(data)
    cb('ok')
  end)

  -- Real-time jaw customization (width, height)
  RegisterNUICallback('applyJawCustomization', function(data, cb)
    ambitionsPrint.info('Applying jaw customization in real-time')
    appearanceApply.ApplyJawCustomization(data)
    cb('ok')
  end)

  -- Real-time lips customization (thickness, lipstick style, color, opacity)
  RegisterNUICallback('applyLipsCustomization', function(data, cb)
    ambitionsPrint.info('Applying lips customization in real-time')
    appearanceApply.ApplyLipsCustomization(data)
    cb('ok')
  end)

  -- Real-time chin customization (lowering, length, width, cleft)
  RegisterNUICallback('applyChinCustomization', function(data, cb)
    ambitionsPrint.info('Applying chin customization in real-time')
    appearanceApply.ApplyChinCustomization(data)
    cb('ok')
  end)

  -- Real-time neck customization (thickness)
  RegisterNUICallback('applyNeckCustomization', function(data, cb)
    ambitionsPrint.info('Applying neck customization in real-time')
    appearanceApply.ApplyNeckCustomization(data)
    cb('ok')
  end)

  -- Real-time ageing customization (style, opacity)
  RegisterNUICallback('applyAgeingCustomization', function(data, cb)
    ambitionsPrint.info('Applying ageing customization in real-time')
    appearanceApply.ApplyAgeingCustomization(data)
    cb('ok')
  end)

  -- Real-time head overlay change (beard, makeup, etc)
  RegisterNUICallback('applyHeadOverlay', function(data, cb)
    appearanceApply.ApplyHeadOverlay(data)
    cb('ok')
  end)

  -- Real-time clothing change
  RegisterNUICallback('applyClothing', function(data, cb)
    appearanceApply.ApplyClothing(data)
    cb('ok')
  end)

  -- Real-time prop change (accessories)
  RegisterNUICallback('applyProp', function(data, cb)
    appearanceApply.ApplyProp(data)
    cb('ok')
  end)

  -- Get customization limits for current ped
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
