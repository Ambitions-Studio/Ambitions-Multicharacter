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

  if tattooConfig.ZONE_HEAD then
    for _, tattoo in ipairs(tattooConfig.ZONE_HEAD) do
      table.insert(tattoosByZone.head, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

  tattoosByZone.neck = tattoosByZone.head

  if tattooConfig.ZONE_TORSO then
    for _, tattoo in ipairs(tattooConfig.ZONE_TORSO) do
      table.insert(tattoosByZone.torso, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

  tattoosByZone.back = tattoosByZone.torso

  if tattooConfig.ZONE_LEFT_ARM then
    for _, tattoo in ipairs(tattooConfig.ZONE_LEFT_ARM) do
      table.insert(tattoosByZone.rightArm, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

  if tattooConfig.ZONE_RIGHT_ARM then
    for _, tattoo in ipairs(tattooConfig.ZONE_RIGHT_ARM) do
      table.insert(tattoosByZone.leftArm, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

  if tattooConfig.ZONE_LEFT_LEG then
    for _, tattoo in ipairs(tattooConfig.ZONE_LEFT_LEG) do
      table.insert(tattoosByZone.rightLeg, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

  if tattooConfig.ZONE_RIGHT_LEG then
    for _, tattoo in ipairs(tattooConfig.ZONE_RIGHT_LEG) do
      table.insert(tattoosByZone.leftLeg, {
        collection = tattoo.collection,
        name = tattoo.hashMale,
        label = tattoo.label
      })
    end
  end

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
function GetTattoosLimits()
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

function ClearAllTattoos()
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
end

--- Reapply all active tattoos to player ped after clearing decorations
---@return nil
local function ReapplyAllTattoos()
  local ped = PlayerPedId()

  local currentTorso = GetPedDrawableVariation(ped, 3)
  local currentTorsoTexture = GetPedTextureVariation(ped, 3)

  for zone, tattoo in pairs(activeTattoos) do
    if tattoo then
      AddPedDecorationFromHashes(ped, tattoo.collectionHash, tattoo.tattooHash)
    end
  end

  Wait(50)
  SetPedComponentVariation(ped, 3, currentTorso, currentTorsoTexture, 0)

  local currentArms = GetPedDrawableVariation(ped, 11)
  local currentArmsTexture = GetPedTextureVariation(ped, 11)
  SetPedComponentVariation(ped, 11, currentArms, currentArmsTexture, 0)
end

--- Apply head tattoo to player ped
---@param data table Contains tattooIndex number
---@return nil
function ApplyHeadTattoo(data)
  local ped = PlayerPedId()
  local tattooIndex = data.tattooIndex or 0
  local zoneTattoos = tattoosByZone.head

  if tattooIndex > 0 and tattooIndex <= #zoneTattoos then
    local tattoo = zoneTattoos[tattooIndex]
    local collectionHash = GetHashKey(tattoo.collection)
    local tattooHash = GetHashKey(tattoo.name)

    activeTattoos.head = {
      collection = tattoo.collection,
      collectionHash = collectionHash,
      tattooHash = tattooHash
    }
  else
    activeTattoos.head = nil
  end

  ClearPedDecorations(ped)
  ReapplyAllTattoos()
end

--- Apply neck tattoo to player ped
---@param data table Contains tattooIndex number
---@return nil
function ApplyNeckTattoo(data)
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
function ApplyTorsoTattoo(data)
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
function ApplyBackTattoo(data)
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
function ApplyLeftArmTattoo(data)
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
function ApplyRightArmTattoo(data)
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
function ApplyLeftLegTattoo(data)
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
function ApplyRightLegTattoo(data)
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