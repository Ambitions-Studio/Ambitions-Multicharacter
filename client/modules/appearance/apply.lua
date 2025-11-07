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

  -- Force update the ped's appearance
  UpdatePedHeadBlendData(ped)

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

--- Apply eye color in real-time
---@param color number Eye color index
local function ApplyEyeColor(color)
  local ped = currentPed or PlayerPedId()
  SetPedEyeColor(ped, color)
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
  ApplyEyeColor = ApplyEyeColor,
  ApplyHeadOverlay = ApplyHeadOverlay,
  ApplyClothing = ApplyClothing,
  ApplyProp = ApplyProp,
  GetCustomizationLimits = GetCustomizationLimits,
}
