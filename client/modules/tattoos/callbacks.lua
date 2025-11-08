local tattoosApply = require('client.modules.tattoos.apply')

--- Register all tattoos-related NUI callbacks for real-time tattoos customization
---@return nil
local function RegisterTattoosCallbacks()
  RegisterNUICallback('applyHeadTattoo', function(data, cb)
    tattoosApply.ApplyHeadTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNeckTattoo', function(data, cb)
    tattoosApply.ApplyNeckTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyTorsoTattoo', function(data, cb)
    tattoosApply.ApplyTorsoTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBackTattoo', function(data, cb)
    tattoosApply.ApplyBackTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLeftArmTattoo', function(data, cb)
    tattoosApply.ApplyLeftArmTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyRightArmTattoo', function(data, cb)
    tattoosApply.ApplyRightArmTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLeftLegTattoo', function(data, cb)
    tattoosApply.ApplyLeftLegTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyRightLegTattoo', function(data, cb)
    tattoosApply.ApplyRightLegTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('getTattoosLimits', function(_, cb)
    local limits = tattoosApply.GetTattoosLimits()
    cb(limits)
  end)

  RegisterNUICallback('getTattooHashLimit', function(data, cb)
    local limit = tattoosApply.GetTattooHashLimit(data.collection, data.zone)
    cb({ limit = limit })
  end)

  RegisterNUICallback('clearAllTattoos', function(_, cb)
    tattoosApply.ClearAllTattoos()
    cb('ok')
  end)
end

return {
  RegisterTattoosCallbacks = RegisterTattoosCallbacks,
}
