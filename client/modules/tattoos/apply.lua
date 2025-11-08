local ambitionsPrint = require('Ambitions.shared.lib.log.print')
local ConfigTattoos = require('config.tattoo')

ambitionsPrint.info('Client tattoos module loaded')

--- Build tattoos organized by body zone from configuration
---@return table Table containing tattoos organized by zone (head, neck, torso, back, leftArm, rightArm, leftLeg, rightLeg)
local function BuildTattoosByZone()
  local tattoosByZone = {
    head = {},
    neck = {},
    torso = {},
    back = {},
    leftArm = {},
    rightArm = {},
    leftLeg = {},
    rightLeg = {},
  }

  if ConfigTattoos.ZONE_HEAD then
    for _, tattoo in ipairs(ConfigTattoos.ZONE_HEAD) do
      table.insert(tattoosByZone.head, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

  tattoosByZone.neck = tattoosByZone.head

  if ConfigTattoos.ZONE_TORSO then
    for _, tattoo in ipairs(ConfigTattoos.ZONE_TORSO) do
      table.insert(tattoosByZone.torso, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

  tattoosByZone.back = tattoosByZone.torso

  -- ZONE_LEFT_ARM dans le config correspond au bras DROIT du point de vue du joueur
  if ConfigTattoos.ZONE_LEFT_ARM then
    for _, tattoo in ipairs(ConfigTattoos.ZONE_LEFT_ARM) do
      table.insert(tattoosByZone.rightArm, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

  -- ZONE_RIGHT_ARM dans le config correspond au bras GAUCHE du point de vue du joueur
  if ConfigTattoos.ZONE_RIGHT_ARM then
    for _, tattoo in ipairs(ConfigTattoos.ZONE_RIGHT_ARM) do
      table.insert(tattoosByZone.leftArm, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

  -- ZONE_LEFT_LEG dans le config correspond à la jambe DROITE du point de vue du joueur
  if ConfigTattoos.ZONE_LEFT_LEG then
    for _, tattoo in ipairs(ConfigTattoos.ZONE_LEFT_LEG) do
      table.insert(tattoosByZone.rightLeg, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

  -- ZONE_RIGHT_LEG dans le config correspond à la jambe GAUCHE du point de vue du joueur
  if ConfigTattoos.ZONE_RIGHT_LEG then
    for _, tattoo in ipairs(ConfigTattoos.ZONE_RIGHT_LEG) do
      table.insert(tattoosByZone.leftLeg, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

  ambitionsPrint.success('Loaded tattoos from config:')
  ambitionsPrint.info('  Head:', #tattoosByZone.head)
  ambitionsPrint.info('  Torso:', #tattoosByZone.torso)
  ambitionsPrint.info('  Left Arm:', #tattoosByZone.leftArm)
  ambitionsPrint.info('  Right Arm:', #tattoosByZone.rightArm)
  ambitionsPrint.info('  Left Leg:', #tattoosByZone.leftLeg)
  ambitionsPrint.info('  Right Leg:', #tattoosByZone.rightLeg)

  return tattoosByZone
end

local tattoosByZone = BuildTattoosByZone()

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

--- Get available tattoo counts for each body zone
---@return table Table containing tattoo counts for each zone
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

--- Reapply all active tattoos to player ped after clearing decorations
---@return nil
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

      -- Les overlays ne nécessitent PAS de RequestStreamedTextureDict
      -- Appliquer directement la decoration
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

--- Apply head tattoo to player ped
---@param data table Contains tattooIndex number
---@return nil
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

--- Apply neck tattoo to player ped
---@param data table Contains tattooIndex number
---@return nil
local function ApplyNeckTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.head

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    activeTattoos.neck = {
      collection = tattoo.collection,
      collectionHash = GetHashKey(tattoo.collection),
      tattooHash = GetHashKey(tattoo.name)
    }
  else
    activeTattoos.neck = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

--- Apply torso tattoo to player ped
---@param data table Contains tattooIndex number
---@return nil
local function ApplyTorsoTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.torso

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    activeTattoos.torso = {
      collection = tattoo.collection,
      collectionHash = GetHashKey(tattoo.collection),
      tattooHash = GetHashKey(tattoo.name)
    }
  else
    activeTattoos.torso = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

--- Apply back tattoo to player ped
---@param data table Contains tattooIndex number
---@return nil
local function ApplyBackTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.back

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    activeTattoos.back = {
      collection = tattoo.collection,
      collectionHash = GetHashKey(tattoo.collection),
      tattooHash = GetHashKey(tattoo.name)
    }
  else
    activeTattoos.back = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

--- Apply left arm tattoo to player ped
---@param data table Contains tattooIndex number
---@return nil
local function ApplyLeftArmTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.leftArm

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    activeTattoos.leftArm = {
      collection = tattoo.collection,
      collectionHash = GetHashKey(tattoo.collection),
      tattooHash = GetHashKey(tattoo.name)
    }
  else
    activeTattoos.leftArm = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

--- Apply right arm tattoo to player ped
---@param data table Contains tattooIndex number
---@return nil
local function ApplyRightArmTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.rightArm

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    activeTattoos.rightArm = {
      collection = tattoo.collection,
      collectionHash = GetHashKey(tattoo.collection),
      tattooHash = GetHashKey(tattoo.name)
    }
  else
    activeTattoos.rightArm = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

--- Apply left leg tattoo to player ped
---@param data table Contains tattooIndex number
---@return nil
local function ApplyLeftLegTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.leftLeg

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    activeTattoos.leftLeg = {
      collection = tattoo.collection,
      collectionHash = GetHashKey(tattoo.collection),
      tattooHash = GetHashKey(tattoo.name)
    }
  else
    activeTattoos.leftLeg = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

--- Apply right leg tattoo to player ped
---@param data table Contains tattooIndex number
---@return nil
local function ApplyRightLegTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.rightLeg

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    activeTattoos.rightLeg = {
      collection = tattoo.collection,
      collectionHash = GetHashKey(tattoo.collection),
      tattooHash = GetHashKey(tattoo.name)
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
