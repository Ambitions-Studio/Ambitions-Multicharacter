local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client tattoos module loaded')

local allTattoos = {
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_000_M', label = 'Demon Rider' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_001_M', label = 'Both Barrels' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_002_M', label = 'Rose Tribute' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_003_M', label = 'Web Rider' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_004_M', label = 'Dragon\'s Fury' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_005_M', label = 'Made In America' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_006_M', label = 'Chopper Freedom' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_007_M', label = 'Swooping Eagle' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_008_M', label = 'Freedom Wheels' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_009_M', label = 'Morbid Arachnid' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_010_M', label = 'Skull Of Taurus' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_011_M', label = 'R.I.P. My Brothers' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_012_M', label = 'Demon Crossbones' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_013_M', label = 'Clawed Beast' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_014_M', label = 'Midnight Rider' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_015_M', label = 'Skull Chain' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_016_M', label = 'Snake Bike' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_017_M', label = 'These Colors Don\'t Run' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_018_M', label = 'Nightmare Stallion' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_019_M', label = 'Grim Rider' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_020_M', label = 'Bone Wrench' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_021_M', label = 'Brothers For Life' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_022_M', label = 'Ride Forever' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_023_M', label = 'Ride Free' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_024_M', label = 'Western Stylized' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_025_M', label = 'Bone Cruiser' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_026_M', label = 'Laughing Skull' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_027_M', label = 'Reaper Vulture' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_028_M', label = 'Faggio' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_029_M', label = 'Western MC' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_030_M', label = 'American Dream' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_031_M', label = 'Combat Skull' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_032_M', label = 'Praying Gloves' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_033_M', label = 'Mum' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_034_M', label = 'Dagger Devil' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_035_M', label = 'Bikertribe Insignia' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_036_M', label = 'Eagle Emblem' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_037_M', label = 'Brotherhood of Bikes' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_038_M', label = 'Gas Guzzler' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_039_M', label = 'No Regrets' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_040_M', label = 'Ride Hard Die Fast' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_041_M', label = 'Virtue Eagle' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_042_M', label = 'Skeleton' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_043_M', label = 'STFU' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_044_M', label = 'Thicker Than Blood' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_045_M', label = 'Ride or Die' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_046_M', label = 'Bad Luck' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_047_M', label = 'Skull of Flames' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_048_M', label = 'Muffler Helmet' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_049_M', label = 'Wheels of Death' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_050_M', label = 'Bone Rattle' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_051_M', label = 'Laughing Skull' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_052_M', label = 'Executioner' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_053_M', label = 'Flaming Scorpion' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_054_M', label = 'Blazing Skull' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_055_M', label = 'Majestic Finish' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_056_M', label = 'Morbid' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_057_M', label = 'Bikers Mount' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_058_M', label = 'Skull and Sword' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_059_M', label = 'Western Eagle' },
  { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_060_M', label = 'Eagle Emblem' },
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
    totalTattoos = #allTattoos,
  }
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

  ambitionsPrint.info('ReapplyAllTattoos - Ped ID:', ped, 'Model:', GetEntityModel(ped))

  for zone, tattoo in pairs(activeTattoos) do
    if tattoo then
      if not HasStreamedTextureDictLoaded(tattoo.collection) then
        RequestStreamedTextureDict(tattoo.collection, true)
        while not HasStreamedTextureDictLoaded(tattoo.collection) do
          Wait(0)
        end
        ambitionsPrint.info('Loaded texture dict:', tattoo.collection)
      end

      AddPedDecorationFromHashes(ped, tattoo.collectionHash, tattoo.tattooHash)
      ambitionsPrint.info('Reapplied tattoo for zone:', zone, 'Collection:', tattoo.collection, 'Hash:', tattoo.tattooHash)
    end
  end
end

local function ApplyHeadTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0

  ambitionsPrint.info('ApplyHeadTattoo - Ped ID:', ped, 'Model:', GetEntityModel(ped), 'Tattoo Index:', tattooIndex)

  ClearPedDecorations(ped)

  if tattooIndex > 0 and tattooIndex <= #allTattoos then
    local tattoo = allTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    activeTattoos.head = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
    ambitionsPrint.info('Set head tattoo - Collection:', tattoo.collection, 'Name:', tattoo.name, 'Label:', tattoo.label)
  else
    activeTattoos.head = nil
    ambitionsPrint.info('Cleared head tattoo')
  end

  ReapplyAllTattoos()
end

local function ApplyNeckTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0

  ClearPedDecorations(ped)

  if tattooIndex > 0 and tattooIndex <= #allTattoos then
    local tattoo = allTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    activeTattoos.neck = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
    ambitionsPrint.info('Set neck tattoo:', tattoo.label)
  else
    activeTattoos.neck = nil
    ambitionsPrint.info('Cleared neck tattoo')
  end

  ReapplyAllTattoos()
end

local function ApplyTorsoTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0

  ClearPedDecorations(ped)

  if tattooIndex > 0 and tattooIndex <= #allTattoos then
    local tattoo = allTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    activeTattoos.torso = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
    ambitionsPrint.info('Set torso tattoo:', tattoo.label)
  else
    activeTattoos.torso = nil
    ambitionsPrint.info('Cleared torso tattoo')
  end

  ReapplyAllTattoos()
end

local function ApplyBackTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0

  ClearPedDecorations(ped)

  if tattooIndex > 0 and tattooIndex <= #allTattoos then
    local tattoo = allTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    activeTattoos.back = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
    ambitionsPrint.info('Set back tattoo:', tattoo.label)
  else
    activeTattoos.back = nil
    ambitionsPrint.info('Cleared back tattoo')
  end

  ReapplyAllTattoos()
end

local function ApplyLeftArmTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0

  ClearPedDecorations(ped)

  if tattooIndex > 0 and tattooIndex <= #allTattoos then
    local tattoo = allTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    activeTattoos.leftArm = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
    ambitionsPrint.info('Set left arm tattoo:', tattoo.label)
  else
    activeTattoos.leftArm = nil
    ambitionsPrint.info('Cleared left arm tattoo')
  end

  ReapplyAllTattoos()
end

local function ApplyRightArmTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0

  ClearPedDecorations(ped)

  if tattooIndex > 0 and tattooIndex <= #allTattoos then
    local tattoo = allTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    activeTattoos.rightArm = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
    ambitionsPrint.info('Set right arm tattoo:', tattoo.label)
  else
    activeTattoos.rightArm = nil
    ambitionsPrint.info('Cleared right arm tattoo')
  end

  ReapplyAllTattoos()
end

local function ApplyLeftLegTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0

  ClearPedDecorations(ped)

  if tattooIndex > 0 and tattooIndex <= #allTattoos then
    local tattoo = allTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    activeTattoos.leftLeg = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
    ambitionsPrint.info('Set left leg tattoo:', tattoo.label)
  else
    activeTattoos.leftLeg = nil
    ambitionsPrint.info('Cleared left leg tattoo')
  end

  ReapplyAllTattoos()
end

local function ApplyRightLegTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0

  ClearPedDecorations(ped)

  if tattooIndex > 0 and tattooIndex <= #allTattoos then
    local tattoo = allTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    activeTattoos.rightLeg = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
    ambitionsPrint.info('Set right leg tattoo:', tattoo.label)
  else
    activeTattoos.rightLeg = nil
    ambitionsPrint.info('Cleared right leg tattoo')
  end

  ReapplyAllTattoos()
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
  ClearAllTattoos = ClearAllTattoos,
}
