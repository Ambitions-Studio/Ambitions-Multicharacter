local tattoosApply = require('client.modules.tattoos.apply')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client tattoos callbacks module loaded')

--- Register all tattoos-related NUI callbacks for real-time tattoos customization
---@return nil
local function RegisterTattoosCallbacks()
  RegisterNUICallback('applyHeadTattoo', function(data, cb)
    ambitionsPrint.info('Applying head tattoo in real-time')
    tattoosApply.ApplyHeadTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNeckTattoo', function(data, cb)
    ambitionsPrint.info('Applying neck tattoo in real-time')
    tattoosApply.ApplyNeckTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyTorsoTattoo', function(data, cb)
    ambitionsPrint.info('Applying torso tattoo in real-time')
    tattoosApply.ApplyTorsoTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBackTattoo', function(data, cb)
    ambitionsPrint.info('Applying back tattoo in real-time')
    tattoosApply.ApplyBackTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLeftArmTattoo', function(data, cb)
    ambitionsPrint.info('Applying left arm tattoo in real-time')
    tattoosApply.ApplyLeftArmTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyRightArmTattoo', function(data, cb)
    ambitionsPrint.info('Applying right arm tattoo in real-time')
    tattoosApply.ApplyRightArmTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLeftLegTattoo', function(data, cb)
    ambitionsPrint.info('Applying left leg tattoo in real-time')
    tattoosApply.ApplyLeftLegTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyRightLegTattoo', function(data, cb)
    ambitionsPrint.info('Applying right leg tattoo in real-time')
    tattoosApply.ApplyRightLegTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('getTattoosLimits', function(_, cb)
    local limits = tattoosApply.GetTattoosLimits()
    ambitionsPrint.info('Sending tattoos limits to UI')
    cb(limits)
  end)

  RegisterNUICallback('getTattooHashLimit', function(data, cb)
    local limit = tattoosApply.GetTattooHashLimit(data.collection, data.zone)
    cb({ limit = limit })
  end)

  RegisterNUICallback('clearAllTattoos', function(_, cb)
    ambitionsPrint.info('Clearing all tattoos')
    tattoosApply.ClearAllTattoos()
    cb('ok')
  end)

  ambitionsPrint.success('Registered all tattoos callbacks')
end

return {
  RegisterTattoosCallbacks = RegisterTattoosCallbacks,
}
