local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client tattoos module loaded')

local tattooCollections = {
  { name = 'mpairraces_overlays', label = 'Air Races' },
  { name = 'mpbeach_overlays', label = 'Beach' },
  { name = 'mpbiker_overlays', label = 'Biker' },
  { name = 'mpbusiness_overlays', label = 'Business' },
  { name = 'mpchristmas2_overlays', label = 'Christmas 2' },
  { name = 'mpchristmas2017_overlays', label = 'Christmas 2017' },
  { name = 'mpchristmas3_overlays', label = 'Christmas 3' },
  { name = 'mpgunrunning_overlays', label = 'Gunrunning' },
  { name = 'mphipster_overlays', label = 'Hipster' },
  { name = 'mpimportexport_overlays', label = 'Import Export' },
  { name = 'mplowrider_overlays', label = 'Lowrider' },
  { name = 'mplowrider2_overlays', label = 'Lowrider 2' },
  { name = 'mpluxe_overlays', label = 'Luxe' },
  { name = 'mpluxe2_overlays', label = 'Luxe 2' },
  { name = 'mpsmuggler_overlays', label = 'Smuggler' },
  { name = 'mpstunt_overlays', label = 'Stunt' },
  { name = 'mpvinewood_overlays', label = 'Vinewood' },
  { name = 'multiplayer_overlays', label = 'Multiplayer' },
}

local activeTattoos = {
  head = nil,
  neck = nil,
  torso = nil,
  back = nil,
  leftArm = nil,
  rightArm = nil,
  leftLeg = nil,
  rightLeg = nil,
}

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
  activeTattoos = {
    head = nil,
    neck = nil,
    torso = nil,
    back = nil,
    leftArm = nil,
    rightArm = nil,
    leftLeg = nil,
    rightLeg = nil,
  }
  ambitionsPrint.info('Cleared all tattoos')
end

local function ReapplyAllTattoos()
  local ped = PlayerPedId()

  for zone, tattoo in pairs(activeTattoos) do
    if tattoo then
      SetPedDecoration(ped, tattoo.collectionHash, tattoo.tattooHash)
      ambitionsPrint.info('Reapplied tattoo for zone:', zone)
    end
  end
end

local function ApplyHeadTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collection = tattooCollections[data.collection]
    local collectionName = collection.name
    local collectionHash = GetHashKey(collectionName)
    local tattooName = 'MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash)
    local tattooHash = GetHashKey(tattooName)

    ClearPedDecorations(ped)

    if data.hash > 0 then
      activeTattoos.head = { collectionHash = collectionHash, tattooHash = tattooHash }
      ambitionsPrint.info('Set head tattoo - Collection:', collectionName, 'Tattoo:', tattooName, 'Hash:', data.hash)
    else
      activeTattoos.head = nil
      ambitionsPrint.info('Cleared head tattoo')
    end

    ReapplyAllTattoos()
  end
end

local function ApplyNeckTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collection = tattooCollections[data.collection]
    local collectionName = collection.name
    local collectionHash = GetHashKey(collectionName)
    local tattooName = 'MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash)
    local tattooHash = GetHashKey(tattooName)

    ClearPedDecorations(ped)

    if data.hash > 0 then
      activeTattoos.neck = { collectionHash = collectionHash, tattooHash = tattooHash }
      ambitionsPrint.info('Set neck tattoo - Collection:', collectionName, 'Tattoo:', tattooName, 'Hash:', data.hash)
    else
      activeTattoos.neck = nil
      ambitionsPrint.info('Cleared neck tattoo')
    end

    ReapplyAllTattoos()
  end
end

local function ApplyTorsoTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collection = tattooCollections[data.collection]
    local collectionName = collection.name
    local collectionHash = GetHashKey(collectionName)
    local tattooName = 'MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash)
    local tattooHash = GetHashKey(tattooName)

    ClearPedDecorations(ped)

    if data.hash > 0 then
      activeTattoos.torso = { collectionHash = collectionHash, tattooHash = tattooHash }
      ambitionsPrint.info('Set torso tattoo - Collection:', collectionName, 'Tattoo:', tattooName, 'Hash:', data.hash)
    else
      activeTattoos.torso = nil
      ambitionsPrint.info('Cleared torso tattoo')
    end

    ReapplyAllTattoos()
  end
end

local function ApplyBackTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collection = tattooCollections[data.collection]
    local collectionName = collection.name
    local collectionHash = GetHashKey(collectionName)
    local tattooName = 'MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash)
    local tattooHash = GetHashKey(tattooName)

    ClearPedDecorations(ped)

    if data.hash > 0 then
      activeTattoos.back = { collectionHash = collectionHash, tattooHash = tattooHash }
      ambitionsPrint.info('Set back tattoo - Collection:', collectionName, 'Tattoo:', tattooName, 'Hash:', data.hash)
    else
      activeTattoos.back = nil
      ambitionsPrint.info('Cleared back tattoo')
    end

    ReapplyAllTattoos()
  end
end

local function ApplyLeftArmTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collection = tattooCollections[data.collection]
    local collectionName = collection.name
    local collectionHash = GetHashKey(collectionName)
    local tattooName = 'MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash)
    local tattooHash = GetHashKey(tattooName)

    ClearPedDecorations(ped)

    if data.hash > 0 then
      activeTattoos.leftArm = { collectionHash = collectionHash, tattooHash = tattooHash }
      ambitionsPrint.info('Set left arm tattoo - Collection:', collectionName, 'Tattoo:', tattooName, 'Hash:', data.hash)
    else
      activeTattoos.leftArm = nil
      ambitionsPrint.info('Cleared left arm tattoo')
    end

    ReapplyAllTattoos()
  end
end

local function ApplyRightArmTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collection = tattooCollections[data.collection]
    local collectionName = collection.name
    local collectionHash = GetHashKey(collectionName)
    local tattooName = 'MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash)
    local tattooHash = GetHashKey(tattooName)

    ClearPedDecorations(ped)

    if data.hash > 0 then
      activeTattoos.rightArm = { collectionHash = collectionHash, tattooHash = tattooHash }
      ambitionsPrint.info('Set right arm tattoo - Collection:', collectionName, 'Tattoo:', tattooName, 'Hash:', data.hash)
    else
      activeTattoos.rightArm = nil
      ambitionsPrint.info('Cleared right arm tattoo')
    end

    ReapplyAllTattoos()
  end
end

local function ApplyLeftLegTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collection = tattooCollections[data.collection]
    local collectionName = collection.name
    local collectionHash = GetHashKey(collectionName)
    local tattooName = 'MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash)
    local tattooHash = GetHashKey(tattooName)

    ClearPedDecorations(ped)

    if data.hash > 0 then
      activeTattoos.leftLeg = { collectionHash = collectionHash, tattooHash = tattooHash }
      ambitionsPrint.info('Set left leg tattoo - Collection:', collectionName, 'Tattoo:', tattooName, 'Hash:', data.hash)
    else
      activeTattoos.leftLeg = nil
      ambitionsPrint.info('Cleared left leg tattoo')
    end

    ReapplyAllTattoos()
  end
end

local function ApplyRightLegTattoo(data)
  local ped = PlayerPedId()

  if data.collection > 0 and data.collection <= #tattooCollections then
    local collection = tattooCollections[data.collection]
    local collectionName = collection.name
    local collectionHash = GetHashKey(collectionName)
    local tattooName = 'MP_' .. string.upper(collectionName:gsub('_overlays', '')) .. '_TAT_' .. string.format('%03d', data.hash)
    local tattooHash = GetHashKey(tattooName)

    ClearPedDecorations(ped)

    if data.hash > 0 then
      activeTattoos.rightLeg = { collectionHash = collectionHash, tattooHash = tattooHash }
      ambitionsPrint.info('Set right leg tattoo - Collection:', collectionName, 'Tattoo:', tattooName, 'Hash:', data.hash)
    else
      activeTattoos.rightLeg = nil
      ambitionsPrint.info('Cleared right leg tattoo')
    end

    ReapplyAllTattoos()
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
