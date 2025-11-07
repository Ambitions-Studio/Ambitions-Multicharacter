local characterDefaults = require('config.character_default')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Client appearance module loaded')

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
  }
end

--- Apply ped model in real-time
---@param pedModel string The ped model to apply
local function ApplyPedModel(pedModel)
  local playerPed = PlayerPedId()

  -- Check if it's a freemode ped
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

    -- Apply default appearance for freemode peds
    ApplyDefaultAppearance(currentPed, currentGender)

    ambitionsPrint.success('Applied freemode ped model:', pedModel)
  else
    -- Non-freemode ped, just spawn the model
    local modelHash = GetHashKey(pedModel)
    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
      Wait(0)
    end

    SetPlayerModel(PlayerId(), modelHash)
    SetModelAsNoLongerNeeded(modelHash)

    currentPed = PlayerPedId()

    ambitionsPrint.success('Applied ped model:', pedModel)
  end
end

--- Apply default character appearance
---@param ped number The ped of the player
---@param gender string 'm' for male, 'f' for female
function ApplyDefaultAppearance(ped, gender)
  local defaults = characterDefaults.defaultCharacter[gender]

  if not defaults then
    ambitionsPrint.error('No default appearance found for gender:', gender)
    return
  end

  -- Head blend data (heritage)
  SetPedHeadBlendData(ped, defaults.mom, defaults.dad, 0, defaults.mom, defaults.dad, 0, defaults.face_md_weight / 100.0, defaults.skin_md_weight / 100.0, 0.0, false)

  -- Face features
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

  -- Hair
  SetPedComponentVariation(ped, 2, defaults.hair_1, defaults.hair_2, 0)
  SetPedHairTint(ped, defaults.hair_color_1, defaults.hair_color_2)

  -- Clothing
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

  -- Clear all props first
  for i = 0, 7 do
    ClearPedProp(ped, i)
  end

  -- Apply props
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

  -- Eyes
  SetPedEyeColor(ped, defaults.eye_color)

  -- Head overlays (makeup, facial hair, etc)
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

  ambitionsPrint.success('Applied default appearance for gender:', gender)
end

--- Apply heritage in real-time
---@param data table Heritage data with father, mother, faceResemblance, skinResemblance
local function ApplyHeritage(data)
  local ped = currentPed or PlayerPedId()

  -- Apply head blend with parent IDs and resemblance values
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

  ambitionsPrint.info('Applied heritage - Father:', data.father, 'Mother:', data.mother, 'Face:', data.faceResemblance, 'Skin:', data.skinResemblance)
end

--- Apply hair style in real-time
---@param data table Hair data with style, color, highlight
local function ApplyHairStyle(data)
  local ped = currentPed or PlayerPedId()

  -- Apply hair style (component 2 = hair)
  SetPedComponentVariation(ped, 2, data.style, 0, 0)

  -- Apply hair colors (primary and highlight)
  SetPedHairTint(ped, data.color, data.highlight)

  ambitionsPrint.info('Applied hair - Style:', data.style, 'Color:', data.color, 'Highlight:', data.highlight)
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

  -- Apply eye opening (face feature index 11)
  -- Invert the value: slider -1 (narrow) should be 1 in game, slider 1 (wide) should be -1 in game
  local invertedOpening = -data.opening
  SetPedFaceFeature(ped, 11, invertedOpening)

  -- Apply eye color
  SetPedEyeColor(ped, data.color)

  ambitionsPrint.info('Applied eyes - Opening:', invertedOpening, 'Color:', data.color)
end

--- Apply eyebrows customization in real-time (height, depth, style, color, opacity)
---@param data table Eyebrows data with height, depth, style, color, opacity
local function ApplyEyebrowsCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply eyebrow height (face feature index 6) - Inverted
  local invertedHeight = -data.height
  SetPedFaceFeature(ped, 6, invertedHeight)

  -- Apply eyebrow depth (face feature index 7)
  SetPedFaceFeature(ped, 7, data.depth)

  -- Apply eyebrow style (head overlay index 2)
  SetPedHeadOverlay(ped, 2, data.style, data.opacity)

  -- Apply eyebrow color (overlay color type 1 = hair color)
  SetPedHeadOverlayColor(ped, 2, 1, data.color, data.color)

  ambitionsPrint.info('Applied eyebrows - Height:', invertedHeight, 'Depth:', data.depth, 'Style:', data.style, 'Color:', data.color, 'Opacity:', data.opacity)
end

--- Apply nose customization in real-time (width, height, length, bridge, bridgeTwist, tipHeight)
---@param data table Nose data with width, height, length, bridge, bridgeTwist, tipHeight
local function ApplyNoseCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply nose width (face feature index 0)
  SetPedFaceFeature(ped, 0, data.width)

  -- Apply nose height (face feature index 1)
  SetPedFaceFeature(ped, 1, data.height)

  -- Apply nose length (face feature index 2) - Inverted
  local invertedLength = -data.length
  SetPedFaceFeature(ped, 2, invertedLength)

  -- Apply nose bridge (face feature index 3) - Inverted
  local invertedBridge = -data.bridge
  SetPedFaceFeature(ped, 3, invertedBridge)

  -- Apply nose bridge twist (face feature index 4) - SWITCHED with tipHeight AND inverted
  local invertedTipHeight = -data.tipHeight
  SetPedFaceFeature(ped, 4, invertedTipHeight)

  -- Apply nose tip height (face feature index 5) - SWITCHED with bridgeTwist
  SetPedFaceFeature(ped, 5, data.bridgeTwist)

  ambitionsPrint.info('Applied nose - Width:', data.width, 'Height:', data.height, 'Length:', invertedLength, 'Bridge:', invertedBridge, 'BridgeTwist:', data.bridgeTwist, 'TipHeight:', data.tipHeight)
end

--- Apply cheeks customization in real-time (boneHeight, boneWidth, width)
---@param data table Cheeks data with boneHeight, boneWidth, width
local function ApplyCheeksCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply cheekbone height (face feature index 8) - Inverted
  local invertedBoneHeight = -data.boneHeight
  SetPedFaceFeature(ped, 8, invertedBoneHeight)

  -- Apply cheekbone width (face feature index 9)
  SetPedFaceFeature(ped, 9, data.boneWidth)

  -- Apply cheek width (face feature index 10) - Inverted
  local invertedWidth = -data.width
  SetPedFaceFeature(ped, 10, invertedWidth)

  ambitionsPrint.info('Applied cheeks - BoneHeight:', invertedBoneHeight, 'BoneWidth:', data.boneWidth, 'Width:', invertedWidth)
end

--- Apply beard customization in real-time (style, color, opacity)
---@param data table Beard data with style, color, opacity
local function ApplyBeardCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply beard style and opacity (head overlay index 1)
  SetPedHeadOverlay(ped, 1, data.style, data.opacity)

  -- Apply beard color (overlay color type 1 = hair color)
  SetPedHeadOverlayColor(ped, 1, 1, data.color, data.color)

  ambitionsPrint.info('Applied beard - Style:', data.style, 'Color:', data.color, 'Opacity:', data.opacity)
end

--- Apply jaw customization in real-time (width, height)
---@param data table Jaw data with width, height
local function ApplyJawCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply jaw width (face feature index 13)
  SetPedFaceFeature(ped, 13, data.width)

  -- Apply jaw height (face feature index 14)
  SetPedFaceFeature(ped, 14, data.height)

  ambitionsPrint.info('Applied jaw - Width:', data.width, 'Height:', data.height)
end

--- Apply lips customization in real-time (thickness + lipstick style, color, opacity)
---@param data table Lips data with thickness, style, color, opacity
local function ApplyLipsCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply lip thickness (face feature index 12) - Inverted
  local invertedThickness = -data.thickness
  SetPedFaceFeature(ped, 12, invertedThickness)

  -- Apply lipstick overlay (index 8 = lipstick)
  SetPedHeadOverlay(ped, 8, data.style, data.opacity)

  -- Apply lipstick color (type 2 = makeup color)
  SetPedHeadOverlayColor(ped, 8, 2, data.color, data.color)

  ambitionsPrint.info('Applied lips - Thickness:', invertedThickness, 'Style:', data.style, 'Color:', data.color, 'Opacity:', data.opacity)
end

--- Apply chin customization in real-time (lowering, length, width, cleft)
---@param data table Chin data with lowering, length, width, cleft
local function ApplyChinCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply chin lowering (face feature index 15) - Inverted
  local invertedLowering = -data.lowering
  SetPedFaceFeature(ped, 15, invertedLowering)

  -- Apply chin length (face feature index 16)
  SetPedFaceFeature(ped, 16, data.length)

  -- Apply chin width (face feature index 17)
  SetPedFaceFeature(ped, 17, data.width)

  -- Apply chin cleft (face feature index 18)
  SetPedFaceFeature(ped, 18, data.cleft)

  ambitionsPrint.info('Applied chin - Lowering:', invertedLowering, 'Length:', data.length, 'Width:', data.width, 'Cleft:', data.cleft)
end

--- Apply neck customization in real-time (thickness)
---@param data table Neck data with thickness
local function ApplyNeckCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply neck thickness (face feature index 19)
  SetPedFaceFeature(ped, 19, data.thickness)

  ambitionsPrint.info('Applied neck - Thickness:', data.thickness)
end

--- Apply ageing customization in real-time (style, opacity)
---@param data table Ageing data with style, opacity
local function ApplyAgeingCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply ageing overlay (index 3 = ageing)
  SetPedHeadOverlay(ped, 3, data.style, data.opacity)

  ambitionsPrint.info('Applied ageing - Style:', data.style, 'Opacity:', data.opacity)
end

--- Apply makeup customization in real-time (style, primary color, secondary color, opacity)
---@param data table Makeup data with style, primaryColor, secondaryColor, opacity
local function ApplyMakeupCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply makeup overlay (index 4 = makeup)
  SetPedHeadOverlay(ped, 4, data.style, data.opacity)

  -- Apply makeup colors (type 2 = makeup color)
  SetPedHeadOverlayColor(ped, 4, 2, data.primaryColor, data.secondaryColor)

  ambitionsPrint.info('Applied makeup - Style:', data.style, 'PrimaryColor:', data.primaryColor, 'SecondaryColor:', data.secondaryColor, 'Opacity:', data.opacity)
end

--- Apply blush customization in real-time (style, color, opacity)
---@param data table Blush data with style, color, opacity
local function ApplyBlushCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply blush overlay (index 5 = blush)
  SetPedHeadOverlay(ped, 5, data.style, data.opacity)

  -- Apply blush color (type 2 = makeup color)
  SetPedHeadOverlayColor(ped, 5, 2, data.color, data.color)

  ambitionsPrint.info('Applied blush - Style:', data.style, 'Color:', data.color, 'Opacity:', data.opacity)
end

--- Apply complexion customization in real-time (style, opacity)
---@param data table Complexion data with style, opacity
local function ApplyComplexionCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply complexion overlay (index 6 = complexion)
  SetPedHeadOverlay(ped, 6, data.style, data.opacity)

  ambitionsPrint.info('Applied complexion - Style:', data.style, 'Opacity:', data.opacity)
end

--- Apply sun damage customization in real-time (style, opacity)
---@param data table Sun damage data with style, opacity
local function ApplySunDamageCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply sun damage overlay (index 7 = sun damage)
  SetPedHeadOverlay(ped, 7, data.style, data.opacity)

  ambitionsPrint.info('Applied sun damage - Style:', data.style, 'Opacity:', data.opacity)
end

--- Apply moles/freckles customization in real-time (style, opacity)
---@param data table Moles/freckles data with style, opacity
local function ApplyMolesFrecklesCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply moles/freckles overlay (index 9 = moles/freckles)
  SetPedHeadOverlay(ped, 9, data.style, data.opacity)

  ambitionsPrint.info('Applied moles/freckles - Style:', data.style, 'Opacity:', data.opacity)
end

--- Apply chest hair customization in real-time (style, color, opacity)
---@param data table Chest hair data with style, color, opacity
local function ApplyChestHairCustomization(data)
  local ped = currentPed or PlayerPedId()

  -- Apply chest hair overlay (index 10 = chest hair)
  SetPedHeadOverlay(ped, 10, data.style, data.opacity)

  -- Apply chest hair color (type 1 = hair color)
  SetPedHeadOverlayColor(ped, 10, 1, data.color, data.color)

  ambitionsPrint.info('Applied chest hair - Style:', data.style, 'Color:', data.color, 'Opacity:', data.opacity)
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
  ApplyHeadOverlay = ApplyHeadOverlay,
  ApplyClothing = ApplyClothing,
  ApplyProp = ApplyProp,
  GetCustomizationLimits = GetCustomizationLimits,
}
