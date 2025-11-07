local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client tattoos module loaded')

local tattooCollections = {
  'mpairraces_overlays',
  'mpbeach_overlays',
  'mpbiker_overlays',
  'mpbusiness_overlays',
  'mpchristmas2_overlays',
  'mpchristmas2017_overlays',
  'mpchristmas3_overlays',
  'mpgunrunning_overlays',
  'mphipster_overlays',
  'mpimportexport_overlays',
  'mplowrider_overlays',
  'mplowrider2_overlays',
  'mpluxe_overlays',
  'mpluxe2_overlays',
  'mpsmuggler_overlays',
  'mpstunt_overlays',
  'mpvinewood_overlays',
  'multiplayer_overlays',
}

local activeTattoos = {}

local function GetTattoosLimits()
  return {
    collections = #tattooCollections,
    head = 50,
    neck = 50,
    torso = 50,
    back = 50,
    leftArm = 50,
    rightArm = 50,
    leftLeg = 50,
    rightLeg = 50,
  }
end

local function GetTattooHashLimit(collection, zone)
  return 50
end

local function ClearAllTattoos()
  local ped = PlayerPedId()
  ClearPedDecorations(ped)
  activeTattoos = {}
  ambitionsPrint.info('Cleared all tattoos')
end

local function ApplyHeadTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collectionName = tattooCollections[data.collection]
    local tattooHash = GetHashKey('MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash))

    if activeTattoos.head then
      ClearPedDecorations(ped)
      activeTattoos.head = nil
    end

    if data.hash > 0 then
      SetPedDecoration(ped, GetHashKey(collectionName), tattooHash)
      activeTattoos.head = { collection = collectionName, hash = tattooHash }
      ambitionsPrint.info('Applied head tattoo - Collection:', collectionName, 'Hash:', data.hash)
    end
  end
end

local function ApplyNeckTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collectionName = tattooCollections[data.collection]
    local tattooHash = GetHashKey('MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash))

    if activeTattoos.neck then
      ClearPedDecorations(ped)
      activeTattoos.neck = nil
    end

    if data.hash > 0 then
      SetPedDecoration(ped, GetHashKey(collectionName), tattooHash)
      activeTattoos.neck = { collection = collectionName, hash = tattooHash }
      ambitionsPrint.info('Applied neck tattoo - Collection:', collectionName, 'Hash:', data.hash)
    end
  end
end

local function ApplyTorsoTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collectionName = tattooCollections[data.collection]
    local tattooHash = GetHashKey('MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash))

    if activeTattoos.torso then
      ClearPedDecorations(ped)
      activeTattoos.torso = nil
    end

    if data.hash > 0 then
      SetPedDecoration(ped, GetHashKey(collectionName), tattooHash)
      activeTattoos.torso = { collection = collectionName, hash = tattooHash }
      ambitionsPrint.info('Applied torso tattoo - Collection:', collectionName, 'Hash:', data.hash)
    end
  end
end

local function ApplyBackTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collectionName = tattooCollections[data.collection]
    local tattooHash = GetHashKey('MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash))

    if activeTattoos.back then
      ClearPedDecorations(ped)
      activeTattoos.back = nil
    end

    if data.hash > 0 then
      SetPedDecoration(ped, GetHashKey(collectionName), tattooHash)
      activeTattoos.back = { collection = collectionName, hash = tattooHash }
      ambitionsPrint.info('Applied back tattoo - Collection:', collectionName, 'Hash:', data.hash)
    end
  end
end

local function ApplyLeftArmTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collectionName = tattooCollections[data.collection]
    local tattooHash = GetHashKey('MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash))

    if activeTattoos.leftArm then
      ClearPedDecorations(ped)
      activeTattoos.leftArm = nil
    end

    if data.hash > 0 then
      SetPedDecoration(ped, GetHashKey(collectionName), tattooHash)
      activeTattoos.leftArm = { collection = collectionName, hash = tattooHash }
      ambitionsPrint.info('Applied left arm tattoo - Collection:', collectionName, 'Hash:', data.hash)
    end
  end
end

local function ApplyRightArmTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collectionName = tattooCollections[data.collection]
    local tattooHash = GetHashKey('MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash))

    if activeTattoos.rightArm then
      ClearPedDecorations(ped)
      activeTattoos.rightArm = nil
    end

    if data.hash > 0 then
      SetPedDecoration(ped, GetHashKey(collectionName), tattooHash)
      activeTattoos.rightArm = { collection = collectionName, hash = tattooHash }
      ambitionsPrint.info('Applied right arm tattoo - Collection:', collectionName, 'Hash:', data.hash)
    end
  end
end

local function ApplyLeftLegTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collectionName = tattooCollections[data.collection]
    local tattooHash = GetHashKey('MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash))

    if activeTattoos.leftLeg then
      ClearPedDecorations(ped)
      activeTattoos.leftLeg = nil
    end

    if data.hash > 0 then
      SetPedDecoration(ped, GetHashKey(collectionName), tattooHash)
      activeTattoos.leftLeg = { collection = collectionName, hash = tattooHash }
      ambitionsPrint.info('Applied left leg tattoo - Collection:', collectionName, 'Hash:', data.hash)
    end
  end
end

local function ApplyRightLegTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collectionName = tattooCollections[data.collection]
    local tattooHash = GetHashKey('MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash))

    if activeTattoos.rightLeg then
      ClearPedDecorations(ped)
      activeTattoos.rightLeg = nil
    end

    if data.hash > 0 then
      SetPedDecoration(ped, GetHashKey(collectionName), tattooHash)
      activeTattoos.rightLeg = { collection = collectionName, hash = tattooHash }
      ambitionsPrint.info('Applied right leg tattoo - Collection:', collectionName, 'Hash:', data.hash)
    end
  end
end

return {
  ApplyHeadTattoo = ApplyHeadTattoo,
  ApplyNeckTattoo = ApplyNeckTattoo,
  ApplyTorsoTattoo = ApplyTorsoTattoo,
  ApplyBackTattoo = ApplyBackTattoo,
  ApplyLeftArmTattoo = ApplyLeftArmTattoo,
  ApplyRightArmTattoo = ApplyRightArmTattoo,
  ApplyLeftLegTattoo = ApplyLeftLegTattoo,
  ApplyRightLegTattoo = ApplyRightLegTattoo,
  GetTattoosLimits = GetTattoosLimits,
  GetTattooHashLimit = GetTattooHashLimit,
  ClearAllTattoos = ClearAllTattoos,
}
