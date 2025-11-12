--- Register all tattoos-related NUI callbacks for real-time tattoos customization
---@return nil
function RegisterTattoosCallbacks()
  RegisterNUICallback('applyHeadTattoo', function(data, cb)
    ApplyHeadTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyNeckTattoo', function(data, cb)
    ApplyNeckTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyTorsoTattoo', function(data, cb)
    ApplyTorsoTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyBackTattoo', function(data, cb)
    ApplyBackTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLeftArmTattoo', function(data, cb)
    ApplyLeftArmTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyRightArmTattoo', function(data, cb)
    ApplyRightArmTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyLeftLegTattoo', function(data, cb)
    ApplyLeftLegTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('applyRightLegTattoo', function(data, cb)
    ApplyRightLegTattoo(data)
    cb('ok')
  end)

  RegisterNUICallback('getTattoosLimits', function(_, cb)
    local limits = GetTattoosLimits()
    cb(limits)
  end)

  RegisterNUICallback('getTattooHashLimit', function(data, cb)
    local limit = GetTattooHashLimit(data.collection, data.zone)
    cb({ limit = limit })
  end)

  RegisterNUICallback('clearAllTattoos', function(_, cb)
    ClearAllTattoos()
    cb('ok')
  end)
end
