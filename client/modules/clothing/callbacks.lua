local clothingApply = require('client.modules.clothing.apply')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client clothing callbacks module loaded')

--- Register all clothing-related NUI callbacks for real-time clothing customization
---@return nil
local function RegisterClothingCallbacks()
  RegisterNUICallback('applyMaskCustomization', function(data, cb)
    ambitionsPrint.info('Applying mask customization in real-time')
    clothingApply.ApplyMaskCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyTorsoCustomization', function(data, cb)
    ambitionsPrint.info('Applying torso customization in real-time')
    clothingApply.ApplyTorsoCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLegsCustomization', function(data, cb)
    ambitionsPrint.info('Applying legs customization in real-time')
    clothingApply.ApplyLegsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBagsCustomization', function(data, cb)
    ambitionsPrint.info('Applying bags customization in real-time')
    clothingApply.ApplyBagsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyShoesCustomization', function(data, cb)
    ambitionsPrint.info('Applying shoes customization in real-time')
    clothingApply.ApplyShoesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyAccessoriesCustomization', function(data, cb)
    ambitionsPrint.info('Applying accessories customization in real-time')
    clothingApply.ApplyAccessoriesCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyUndershirtsCustomization', function(data, cb)
    ambitionsPrint.info('Applying undershirts customization in real-time')
    clothingApply.ApplyUndershirtsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyArmorCustomization', function(data, cb)
    ambitionsPrint.info('Applying armor customization in real-time')
    clothingApply.ApplyArmorCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyDecalsCustomization', function(data, cb)
    ambitionsPrint.info('Applying decals customization in real-time')
    clothingApply.ApplyDecalsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('applyTopsCustomization', function(data, cb)
    ambitionsPrint.info('Applying tops customization in real-time')
    clothingApply.ApplyTopsCustomization(data)
    cb('ok')
  end)

  RegisterNUICallback('getClothingLimits', function(_, cb)
    local limits = clothingApply.GetClothingLimits()
    ambitionsPrint.info('Sending clothing limits to UI')
    cb(limits)
  end)

  RegisterNUICallback('getClothingTextureLimit', function(data, cb)
    local limit = clothingApply.GetClothingTextureLimit(data.component, data.drawable)
    cb({ limit = limit })
  end)

  ambitionsPrint.success('Registered all clothing callbacks')
end

return {
  RegisterClothingCallbacks = RegisterClothingCallbacks,
}
