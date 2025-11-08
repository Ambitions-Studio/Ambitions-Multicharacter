local characterDefaults = require('config.character_default')

local currentPed = nil
local currentGender = 'm'

--- Get available customization limits for current ped
---@return table Limits with max values for each customization option
local function GetCustomizationLimits()
  local ped = currentPed or PlayerPedId()

  return {
    hairStyles = GetNumberOfPedDrawableVariations(ped, 2) - 1, -- Component 2 = Hair
    hairTextures = GetNumberOfPedTextureVariations(ped, 2, 0) - 1, -- Textures for hair drawable 0
    eyebrowsStyles = GetNumHeadOverlayValues(2) - 1, -- Overlay 2 = Eyebrows
    beardStyles = GetNumHeadOverlayValues(1) - 1, -- Overlay 1 = Beard
    lipstickStyles = GetNumHeadOverlayValues(8) - 1, -- Overlay 8 = Lipstick
    ageingStyles = GetNumHeadOverlayValues(3) - 1, -- Overlay 3 = Ageing
    makeupStyles = GetNumHeadOverlayValues(4) - 1, -- Overlay 4 = Makeup
    blushStyles = GetNumHeadOverlayValues(5) - 1, -- Overlay 5 = Blush
    complexionStyles = GetNumHeadOverlayValues(6) - 1, -- Overlay 6 = Complexion
    sunDamageStyles = GetNumHeadOverlayValues(7) - 1, -- Overlay 7 = Sun Damage
    molesFrecklesStyles = GetNumHeadOverlayValues(9) - 1, -- Overlay 9 = Moles/Freckles
    chestHairStyles = GetNumHeadOverlayValues(10) - 1, -- Overlay 10 = Chest Hair
    bodyBlemishesStyles = GetNumHeadOverlayValues(11) - 1, -- Overlay 11 = Body Blemishes
  }
end

--- Apply ped model in real-time
---@param pedModel string The ped model to apply
local function ApplyPedModel(pedModel)
  if pedModel == 'mp_m_freemode_01' or pedModel == 'mp_f_freemode_01' then
    currentGender = pedModel == 'mp_m_freemode_01' and 'm' or 'f'

    local modelHash = GetHashKey(pedModel)
    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
      Wait(0)
    end

    SetPlayerModel(PlayerId(), modelHash)
    SetModelAsNoLongerNeeded(modelHash)

    currentPed = PlayerPedId()

    ApplyDefaultAppearance(currentPed, currentGender)
  else
    local modelHash = GetHashKey(pedModel)
    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
      Wait(0)
    end

    SetPlayerModel(PlayerId(), modelHash)
    SetModelAsNoLongerNeeded(modelHash)

    currentPed = PlayerPedId()
  end
end

--- Apply default character appearance
---@param ped number The ped of the player
---@param gender string 'm' for male, 'f' for female
function ApplyDefaultAppearance(ped, gender)
  local defaults = characterDefaults.defaultCharacter[gender]

  if not defaults then
    return
  end

  SetPedHeadBlendData(ped, defaults.mom, defaults.dad, 0, defaults.mom, defaults.dad, 0, defaults.face_md_weight / 100.0, defaults.skin_md_weight / 100.0, 0.0, false)

  SetPedFaceFeature(ped, 0, defaults.nose_1 / 10.0)
  SetPedFaceFeature(ped, 1, defaults.nose_2 / 10.0)
  SetPedFaceFeature(ped, 2, defaults.nose_3 / 10.0)
  SetPedFaceFeature(ped, 3, defaults.nose_4 / 10.0)
  SetPedFaceFeature(ped, 4, defaults.nose_5 / 10.0)
  SetPedFaceFeature(ped, 5, defaults.nose_6 / 10.0)
  SetPedFaceFeature(ped, 6, defaults.eyebrows_5 / 10.0)
  SetPedFaceFeature(ped, 7, defaults.eyebrows_6 / 10.0)
  SetPedFaceFeature(ped, 8, defaults.cheeks_1 / 10.0)
  SetPedFaceFeature(ped, 9, defaults.cheeks_2 / 10.0)
  SetPedFaceFeature(ped, 10, defaults.cheeks_3 / 10.0)
  SetPedFaceFeature(ped, 11, defaults.eye_squint / 10.0)
  SetPedFaceFeature(ped, 12, defaults.lip_thickness / 10.0)
  SetPedFaceFeature(ped, 13, defaults.jaw_1 / 10.0)
  SetPedFaceFeature(ped, 14, defaults.jaw_2 / 10.0)
  SetPedFaceFeature(ped, 15, defaults.chin_1 / 10.0)
  SetPedFaceFeature(ped, 16, defaults.chin_2 / 10.0)
  SetPedFaceFeature(ped, 17, defaults.chin_3 / 10.0)
  SetPedFaceFeature(ped, 18, defaults.chin_4 / 10.0)
  SetPedFaceFeature(ped, 19, defaults.neck_thickness / 10.0)

  SetPedComponentVariation(ped, 2, defaults.hair_1, defaults.hair_2, 0)
  SetPedHairTint(ped, defaults.hair_color_1, defaults.hair_color_2)

  SetPedComponentVariation(ped, 8, defaults.tshirt_1, defaults.tshirt_2, 0)
  SetPedComponentVariation(ped, 3, defaults.torso_1, defaults.torso_2, 0)
  SetPedComponentVariation(ped, 10, defaults.decals_1, defaults.decals_2, 0)
  SetPedComponentVariation(ped, 11, defaults.arms, defaults.arms_2, 0)
  SetPedComponentVariation(ped, 4, defaults.pants_1, defaults.pants_2, 0)
  SetPedComponentVariation(ped, 6, defaults.shoes_1, defaults.shoes_2, 0)
  SetPedComponentVariation(ped, 1, defaults.mask_1, defaults.mask_2, 0)
  SetPedComponentVariation(ped, 9, defaults.bproof_1, defaults.bproof_2, 0)
  SetPedComponentVariation(ped, 7, defaults.chain_1, defaults.chain_2, 0)
  SetPedComponentVariation(ped, 5, defaults.bags_1, defaults.bags_2, 0)

  for i = 0, 7 do
    ClearPedProp(ped, i)
  end

  if defaults.helmet_1 ~= -1 then
    SetPedPropIndex(ped, 0, defaults.helmet_1, defaults.helmet_2, true)
  end
  if defaults.glasses_1 ~= -1 then
    SetPedPropIndex(ped, 1, defaults.glasses_1, defaults.glasses_2, true)
  end
  if defaults.ears_1 ~= -1 then
    SetPedPropIndex(ped, 2, defaults.ears_1, defaults.ears_2, true)
  end
  if defaults.watches_1 ~= -1 then
    SetPedPropIndex(ped, 6, defaults.watches_1, defaults.watches_2, true)
  end
  if defaults.bracelets_1 ~= -1 then
    SetPedPropIndex(ped, 7, defaults.bracelets_1, defaults.bracelets_2, true)
  end

  SetPedEyeColor(ped, defaults.eye_color)

  SetPedHeadOverlay(ped, 0, defaults.blemishes_1, defaults.blemishes_2 / 10.0)
  SetPedHeadOverlay(ped, 1, defaults.beard_1, defaults.beard_2 / 10.0)
  SetPedHeadOverlayColor(ped, 1, 1, defaults.beard_3, defaults.beard_4)
  SetPedHeadOverlay(ped, 2, defaults.eyebrows_1, defaults.eyebrows_2 / 10.0)
  SetPedHeadOverlayColor(ped, 2, 1, defaults.eyebrows_3, defaults.eyebrows_4)
  SetPedHeadOverlay(ped, 3, defaults.age_1, defaults.age_2 / 10.0)
  SetPedHeadOverlay(ped, 4, defaults.makeup_1, defaults.makeup_2 / 10.0)
  SetPedHeadOverlayColor(ped, 4, 2, defaults.makeup_3, defaults.makeup_4)
  SetPedHeadOverlay(ped, 5, defaults.blush_1, defaults.blush_2 / 10.0)
  SetPedHeadOverlayColor(ped, 5, 2, defaults.blush_3, 0)
  SetPedHeadOverlay(ped, 6, defaults.complexion_1, defaults.complexion_2 / 10.0)
  SetPedHeadOverlay(ped, 7, defaults.sun_1, defaults.sun_2 / 10.0)
  SetPedHeadOverlay(ped, 8, defaults.lipstick_1, defaults.lipstick_2 / 10.0)
  SetPedHeadOverlayColor(ped, 8, 2, defaults.lipstick_3, defaults.lipstick_4)
  SetPedHeadOverlay(ped, 9, defaults.moles_1, defaults.moles_2 / 10.0)
  SetPedHeadOverlay(ped, 10, defaults.chest_1, defaults.chest_2 / 10.0)
  SetPedHeadOverlayColor(ped, 10, 1, defaults.chest_3, 0)

  if defaults.bodyb_1 ~= -1 then
    SetPedHeadOverlay(ped, 11, defaults.bodyb_1, defaults.bodyb_2 / 10.0)
  end
  if defaults.bodyb_3 ~= -1 then
    SetPedHeadOverlay(ped, 12, defaults.bodyb_3, defaults.bodyb_4 / 10.0)
  end
end

--- Apply heritage in real-time
---@param data table Heritage data with father, mother, faceResemblance, skinResemblance
local function ApplyHeritage(data)
  local ped = currentPed or PlayerPedId()

  SetPedHeadBlendData(
    ped,
    data.mother,      -- Shape first ID (mother)
    data.father,      -- Shape second ID (father)
    0,                -- Shape third ID (not used)
    data.mother,      -- Skin first ID (mother)
    data.father,      -- Skin second ID (father)
    0,                -- Skin third ID (not used)
    data.faceResemblance,  -- Shape mix (0.0 = father, 1.0 = mother)
    data.skinResemblance,  -- Skin mix (0.0 = father, 1.0 = mother)
    0.0,              -- Third mix (not used)
    false             -- Is parent
  )
end

--- Apply hair style in real-time
---@param data table Hair data with style, color, highlight
local function ApplyHairStyle(data)
  local ped = currentPed or PlayerPedId()

  SetPedComponentVariation(ped, 2, data.style, 0, 0)

  SetPedHairTint(ped, data.color, data.highlight)
end

--- Apply face feature in real-time
---@param index number Face feature index (0-19)
---@param value number Value for the feature (-1.0 to 1.0)
local function ApplyFaceFeature(index, value)
  local ped = currentPed or PlayerPedId()
  SetPedFaceFeature(ped, index, value)
end

--- Apply eyes customization in real-time (opening + color)
---@param data table Eyes data with opening and color
local function ApplyEyesCustomization(data)
  local ped = currentPed or PlayerPedId()

  local invertedOpening = -data.opening
  SetPedFaceFeature(ped, 11, invertedOpening)

  SetPedEyeColor(ped, data.color)
end

--- Apply eyebrows customization in real-time (height, depth, style, color, opacity)
---@param data table Eyebrows data with height, depth, style, color, opacity
local function ApplyEyebrowsCustomization(data)
  local ped = currentPed or PlayerPedId()

  local invertedHeight = -data.height
  SetPedFaceFeature(ped, 6, invertedHeight)

  SetPedFaceFeature(ped, 7, data.depth)

  SetPedHeadOverlay(ped, 2, data.style, data.opacity)

  SetPedHeadOverlayColor(ped, 2, 1, data.color, data.color)
end

--- Apply nose customization in real-time (width, height, length, bridge, bridgeTwist, tipHeight)
---@param data table Nose data with width, height, length, bridge, bridgeTwist, tipHeight
local function ApplyNoseCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedFaceFeature(ped, 0, data.width)

  SetPedFaceFeature(ped, 1, data.height)

  local invertedLength = -data.length
  SetPedFaceFeature(ped, 2, invertedLength)

  local invertedBridge = -data.bridge
  SetPedFaceFeature(ped, 3, invertedBridge)

  local invertedTipHeight = -data.tipHeight
  SetPedFaceFeature(ped, 4, invertedTipHeight)

  SetPedFaceFeature(ped, 5, data.bridgeTwist)
end

--- Apply cheeks customization in real-time (boneHeight, boneWidth, width)
---@param data table Cheeks data with boneHeight, boneWidth, width
local function ApplyCheeksCustomization(data)
  local ped = currentPed or PlayerPedId()

  local invertedBoneHeight = -data.boneHeight
  SetPedFaceFeature(ped, 8, invertedBoneHeight)

  SetPedFaceFeature(ped, 9, data.boneWidth)

  local invertedWidth = -data.width
  SetPedFaceFeature(ped, 10, invertedWidth)
end

--- Apply beard customization in real-time (style, color, opacity)
---@param data table Beard data with style, color, opacity
local function ApplyBeardCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedHeadOverlay(ped, 1, data.style, data.opacity)

  SetPedHeadOverlayColor(ped, 1, 1, data.color, data.color)
end

--- Apply jaw customization in real-time (width, height)
---@param data table Jaw data with width, height
local function ApplyJawCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedFaceFeature(ped, 13, data.width)

  SetPedFaceFeature(ped, 14, data.height)
end

--- Apply lips customization in real-time (thickness + lipstick style, color, opacity)
---@param data table Lips data with thickness, style, color, opacity
local function ApplyLipsCustomization(data)
  local ped = currentPed or PlayerPedId()

  local invertedThickness = -data.thickness
  SetPedFaceFeature(ped, 12, invertedThickness)

  SetPedHeadOverlay(ped, 8, data.style, data.opacity)

  SetPedHeadOverlayColor(ped, 8, 2, data.color, data.color)
end

--- Apply chin customization in real-time (lowering, length, width, cleft)
---@param data table Chin data with lowering, length, width, cleft
local function ApplyChinCustomization(data)
  local ped = currentPed or PlayerPedId()

  local invertedLowering = -data.lowering
  SetPedFaceFeature(ped, 15, invertedLowering)

  SetPedFaceFeature(ped, 16, data.length)

  SetPedFaceFeature(ped, 17, data.width)

  SetPedFaceFeature(ped, 18, data.cleft)
end

--- Apply neck customization in real-time (thickness)
---@param data table Neck data with thickness
local function ApplyNeckCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedFaceFeature(ped, 19, data.thickness)
end

--- Apply ageing customization in real-time (style, opacity)
---@param data table Ageing data with style, opacity
local function ApplyAgeingCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedHeadOverlay(ped, 3, data.style, data.opacity)
end

--- Apply makeup customization in real-time (style, primary color, secondary color, opacity)
---@param data table Makeup data with style, primaryColor, secondaryColor, opacity
local function ApplyMakeupCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedHeadOverlay(ped, 4, data.style, data.opacity)

  SetPedHeadOverlayColor(ped, 4, 2, data.primaryColor, data.secondaryColor)
end

--- Apply blush customization in real-time (style, color, opacity)
---@param data table Blush data with style, color, opacity
local function ApplyBlushCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedHeadOverlay(ped, 5, data.style, data.opacity)

  SetPedHeadOverlayColor(ped, 5, 2, data.color, data.color)
end

--- Apply complexion customization in real-time (style, opacity)
---@param data table Complexion data with style, opacity
local function ApplyComplexionCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedHeadOverlay(ped, 6, data.style, data.opacity)
end

--- Apply sun damage customization in real-time (style, opacity)
---@param data table Sun damage data with style, opacity
local function ApplySunDamageCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedHeadOverlay(ped, 7, data.style, data.opacity)
end

--- Apply moles/freckles customization in real-time (style, opacity)
---@param data table Moles/freckles data with style, opacity
local function ApplyMolesFrecklesCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedHeadOverlay(ped, 9, data.style, data.opacity)
end

--- Apply chest hair customization in real-time (style, color, opacity)
---@param data table Chest hair data with style, color, opacity
local function ApplyChestHairCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedHeadOverlay(ped, 10, data.style, data.opacity)

  SetPedHeadOverlayColor(ped, 10, 1, data.color, data.color)
end

--- Apply body blemishes customization in real-time (style, opacity)
---@param data table Body blemishes data with style, opacity
local function ApplyBodyBlemishesCustomization(data)
  local ped = currentPed or PlayerPedId()

  SetPedHeadOverlay(ped, 11, data.style, data.opacity)
end

--- Apply head overlay (beard, makeup, etc) in real-time
---@param data table Overlay data with index, style, opacity, color1, color2
local function ApplyHeadOverlay(data)
  local ped = currentPed or PlayerPedId()

  SetPedHeadOverlay(ped, data.index, data.style, data.opacity)

  if data.colorType and data.color1 then
    SetPedHeadOverlayColor(ped, data.index, data.colorType, data.color1, data.color2 or 0)
  end
end

--- Apply clothing component in real-time
---@param data table Clothing data with component, drawable, texture
local function ApplyClothing(data)
  local ped = currentPed or PlayerPedId()
  SetPedComponentVariation(ped, data.component, data.drawable, data.texture, 0)
end

--- Apply prop (accessory) in real-time
---@param data table Prop data with component, drawable, texture
local function ApplyProp(data)
  local ped = currentPed or PlayerPedId()

  if data.drawable == -1 then
    ClearPedProp(ped, data.component)
  else
    SetPedPropIndex(ped, data.component, data.drawable, data.texture, true)
  end
end

return {
  ApplyPedModel = ApplyPedModel,
  ApplyDefaultAppearance = ApplyDefaultAppearance,
  ApplyHeritage = ApplyHeritage,
  ApplyHairStyle = ApplyHairStyle,
  ApplyFaceFeature = ApplyFaceFeature,
  ApplyEyesCustomization = ApplyEyesCustomization,
  ApplyEyebrowsCustomization = ApplyEyebrowsCustomization,
  ApplyNoseCustomization = ApplyNoseCustomization,
  ApplyCheeksCustomization = ApplyCheeksCustomization,
  ApplyBeardCustomization = ApplyBeardCustomization,
  ApplyJawCustomization = ApplyJawCustomization,
  ApplyLipsCustomization = ApplyLipsCustomization,
  ApplyChinCustomization = ApplyChinCustomization,
  ApplyNeckCustomization = ApplyNeckCustomization,
  ApplyAgeingCustomization = ApplyAgeingCustomization,
  ApplyMakeupCustomization = ApplyMakeupCustomization,
  ApplyBlushCustomization = ApplyBlushCustomization,
  ApplyComplexionCustomization = ApplyComplexionCustomization,
  ApplySunDamageCustomization = ApplySunDamageCustomization,
  ApplyMolesFrecklesCustomization = ApplyMolesFrecklesCustomization,
  ApplyChestHairCustomization = ApplyChestHairCustomization,
  ApplyBodyBlemishesCustomization = ApplyBodyBlemishesCustomization,
  ApplyHeadOverlay = ApplyHeadOverlay,
  ApplyClothing = ApplyClothing,
  ApplyProp = ApplyProp,
  GetCustomizationLimits = GetCustomizationLimits,
}
