local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client tattoos module loaded')

local tattoosByZone = {
  head = {
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_009_M', label = 'Morbid Arachnid' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_038_M', label = 'Gas Guzzler' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_048_M', label = 'Muffler Helmet' },
  },
  torso = {
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_000_M', label = 'Demon Rider' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_001_M', label = 'Both Barrels' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_003_M', label = 'Web Rider' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_005_M', label = 'Made In America' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_006_M', label = 'Chopper Freedom' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_007_M', label = 'Swooping Eagle' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_010_M', label = 'Skull Of Taurus' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_011_M', label = 'R.I.P. My Brothers' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_013_M', label = 'Clawed Beast' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_017_M', label = 'These Colors Don\'t Run' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_018_M', label = 'Nightmare Stallion' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_019_M', label = 'Grim Rider' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_021_M', label = 'Brothers For Life' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_024_M', label = 'Western Stylized' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_026_M', label = 'Laughing Skull' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_036_M', label = 'Eagle Emblem' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_037_M', label = 'Brotherhood of Bikes' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_042_M', label = 'Skeleton' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_044_M', label = 'Thicker Than Blood' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_045_M', label = 'Ride or Die' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_054_M', label = 'Blazing Skull' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_056_M', label = 'Morbid' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_057_M', label = 'Bikers Mount' },
  },
  back = {
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_002_M', label = 'Rose Tribute' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_004_M', label = 'Dragon\'s Fury' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_008_M', label = 'Freedom Wheels' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_012_M', label = 'Demon Crossbones' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_014_M', label = 'Midnight Rider' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_015_M', label = 'Skull Chain' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_016_M', label = 'Snake Bike' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_022_M', label = 'Ride Forever' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_023_M', label = 'Ride Free' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_027_M', label = 'Reaper Vulture' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_029_M', label = 'Western MC' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_035_M', label = 'Bikertribe Insignia' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_039_M', label = 'No Regrets' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_041_M', label = 'Virtue Eagle' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_046_M', label = 'Bad Luck' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_047_M', label = 'Skull of Flames' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_049_M', label = 'Wheels of Death' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_053_M', label = 'Flaming Scorpion' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_055_M', label = 'Majestic Finish' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_059_M', label = 'Western Eagle' },
  },
  leftArm = {
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_020_M', label = 'Bone Wrench' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_028_M', label = 'Faggio' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_030_M', label = 'American Dream' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_031_M', label = 'Combat Skull' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_032_M', label = 'Praying Gloves' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_034_M', label = 'Dagger Devil' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_043_M', label = 'STFU' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_052_M', label = 'Executioner' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_058_M', label = 'Skull and Sword' },
  },
  rightArm = {
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_025_M', label = 'Bone Cruiser' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_033_M', label = 'Mum' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_040_M', label = 'Ride Hard Die Fast' },
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_051_M', label = 'Laughing Skull' },
  },
  leftLeg = {
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_050_M', label = 'Bone Rattle' },
  },
  rightLeg = {
    { collection = 'mpbiker_overlays', name = 'MP_MP_Biker_Tat_060_M', label = 'Eagle Emblem' },
  },
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
    headTattoos = #tattoosByZone.head,
    torsoTattoos = #tattoosByZone.torso,
    backTattoos = #tattoosByZone.back,
    leftArmTattoos = #tattoosByZone.leftArm,
    rightArmTattoos = #tattoosByZone.rightArm,
    leftLegTattoos = #tattoosByZone.leftLeg,
    rightLegTattoos = #tattoosByZone.rightLeg,
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
  local pedModel = GetEntityModel(ped)

  ambitionsPrint.info('========== ReapplyAllTattoos START ==========')
  ambitionsPrint.info('Ped ID:', ped, 'Model:', pedModel)

  -- IMPORTANT: Refresh le component du torse pour forcer l'affichage des overlays
  local currentTorso = GetPedDrawableVariation(ped, 3)
  local currentTorsoTexture = GetPedTextureVariation(ped, 3)

  for zone, tattoo in pairs(activeTattoos) do
    if tattoo then
      ambitionsPrint.info('Processing tattoo for zone:', zone)
      ambitionsPrint.info('  Collection:', tattoo.collection)
      ambitionsPrint.info('  Collection Hash:', tattoo.collectionHash)
      ambitionsPrint.info('  Tattoo Hash:', tattoo.tattooHash)

      if not HasStreamedTextureDictLoaded(tattoo.collection) then
        ambitionsPrint.warn('Texture dict not loaded, requesting:', tattoo.collection)
        RequestStreamedTextureDict(tattoo.collection, true)
        local timeout = 0
        while not HasStreamedTextureDictLoaded(tattoo.collection) and timeout < 100 do
          Wait(10)
          timeout = timeout + 1
        end
        if HasStreamedTextureDictLoaded(tattoo.collection) then
          ambitionsPrint.success('Texture dict loaded:', tattoo.collection)
        else
          ambitionsPrint.error('Failed to load texture dict:', tattoo.collection)
        end
      else
        ambitionsPrint.info('Texture dict already loaded:', tattoo.collection)
      end

      -- Appliquer la decoration
      AddPedDecorationFromHashes(ped, tattoo.collectionHash, tattoo.tattooHash)
      ambitionsPrint.success('Applied decoration for zone:', zone)
    end
  end

  -- FORCER le refresh du component pour afficher les overlays
  Wait(50)
  SetPedComponentVariation(ped, 3, currentTorso, currentTorsoTexture, 0)

  -- Aussi refresh les bras (component 11)
  local currentArms = GetPedDrawableVariation(ped, 11)
  local currentArmsTexture = GetPedTextureVariation(ped, 11)
  SetPedComponentVariation(ped, 11, currentArms, currentArmsTexture, 0)

  ambitionsPrint.info('Refreshed components to display overlays')
  ambitionsPrint.info('========== ReapplyAllTattoos END ==========')
end

local function ApplyHeadTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.head

  ambitionsPrint.info('========== ApplyHeadTattoo START ==========')
  ambitionsPrint.info('Tattoo Index:', tattooIndex, 'Available head tattoos:', #zoneTattoos)

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    ambitionsPrint.info('Applying head tattoo:', tattoo.label)
    ambitionsPrint.info('  Collection:', tattoo.collection)
    ambitionsPrint.info('  Name:', tattoo.name)

    if not HasStreamedTextureDictLoaded(tattoo.collection) then
      RequestStreamedTextureDict(tattoo.collection, true)
      local timeout = 0
      while not HasStreamedTextureDictLoaded(tattoo.collection) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
      end
    end

    activeTattoos.head = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }

    ambitionsPrint.success('Head tattoo set:', tattoo.label)
  else
    activeTattoos.head = nil
    ambitionsPrint.info('Cleared head tattoo')
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
  ambitionsPrint.info('========== ApplyHeadTattoo END ==========')
end

local function ApplyNeckTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.head

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    if not HasStreamedTextureDictLoaded(tattoo.collection) then
      RequestStreamedTextureDict(tattoo.collection, true)
      local timeout = 0
      while not HasStreamedTextureDictLoaded(tattoo.collection) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
      end
    end

    activeTattoos.neck = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
  else
    activeTattoos.neck = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

local function ApplyTorsoTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.torso

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    if not HasStreamedTextureDictLoaded(tattoo.collection) then
      RequestStreamedTextureDict(tattoo.collection, true)
      local timeout = 0
      while not HasStreamedTextureDictLoaded(tattoo.collection) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
      end
    end

    activeTattoos.torso = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
  else
    activeTattoos.torso = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

local function ApplyBackTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.back

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    if not HasStreamedTextureDictLoaded(tattoo.collection) then
      RequestStreamedTextureDict(tattoo.collection, true)
      local timeout = 0
      while not HasStreamedTextureDictLoaded(tattoo.collection) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
      end
    end

    activeTattoos.back = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
  else
    activeTattoos.back = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

local function ApplyLeftArmTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.leftArm

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    if not HasStreamedTextureDictLoaded(tattoo.collection) then
      RequestStreamedTextureDict(tattoo.collection, true)
      local timeout = 0
      while not HasStreamedTextureDictLoaded(tattoo.collection) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
      end
    end

    activeTattoos.leftArm = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
  else
    activeTattoos.leftArm = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

local function ApplyRightArmTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.rightArm

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    if not HasStreamedTextureDictLoaded(tattoo.collection) then
      RequestStreamedTextureDict(tattoo.collection, true)
      local timeout = 0
      while not HasStreamedTextureDictLoaded(tattoo.collection) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
      end
    end

    activeTattoos.rightArm = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
  else
    activeTattoos.rightArm = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

local function ApplyLeftLegTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.leftLeg

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    if not HasStreamedTextureDictLoaded(tattoo.collection) then
      RequestStreamedTextureDict(tattoo.collection, true)
      local timeout = 0
      while not HasStreamedTextureDictLoaded(tattoo.collection) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
      end
    end

    activeTattoos.leftLeg = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
  else
    activeTattoos.leftLeg = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

local function ApplyRightLegTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.rightLeg

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    if not HasStreamedTextureDictLoaded(tattoo.collection) then
      RequestStreamedTextureDict(tattoo.collection, true)
      local timeout = 0
      while not HasStreamedTextureDictLoaded(tattoo.collection) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
      end
    end

    activeTattoos.rightLeg = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
  else
    activeTattoos.rightLeg = nil
  end

  ClearPedDecorations(ped)
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
