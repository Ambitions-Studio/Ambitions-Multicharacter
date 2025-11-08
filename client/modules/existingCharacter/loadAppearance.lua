local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Existing character appearance loader module loaded')

--- Load complete character appearance from database data
---@param ped number The ped entity to apply appearance to
---@param appearanceData table Complete appearance data from database
---@return nil
local function LoadFullAppearance(ped, appearanceData)
  if not ped or not DoesEntityExist(ped) then
    ambitionsPrint.error('Invalid ped entity provided to LoadFullAppearance')
    return
  end

  if not appearanceData then
    ambitionsPrint.error('No appearance data provided to LoadFullAppearance')
    return
  end

  ambitionsPrint.info('========== LOADING FULL APPEARANCE ==========')
  ambitionsPrint.info('Ped:', ped, 'Model:', GetEntityModel(ped))

  SetPedDefaultComponentVariation(ped)
  ClearAllPedProps(ped)

  local physical = appearanceData.physical or {}
  local heritage = appearanceData.heritage or {}
  local clothing = appearanceData.clothing or {}
  local accessories = appearanceData.accessories or {}
  local tattoos = appearanceData.tattoos or {}

  if heritage and (heritage.father or heritage.mother) then
    ambitionsPrint.info('Applying heritage...')
    SetPedHeadBlendData(ped, heritage.father or 0, heritage.mother or 0, 0, heritage.father or 0, heritage.mother or 0, 0, heritage.faceResemblance or 0.5, heritage.skinResemblance or 0.5, 0.0, false)
  end

  if physical.hairStyle then
    ambitionsPrint.info('Applying hair...')
    SetPedComponentVariation(ped, 2, physical.hairStyle, 0, 0)
    SetPedHairColor(ped, physical.hairColor or 0, physical.hairHighlight or 0)
  end

  if physical.eyeColor then
    SetPedEyeColor(ped, physical.eyeColor)
  end

  if physical.eyebrowsStyle then
    ambitionsPrint.info('Applying eyebrows...')
    SetPedHeadOverlay(ped, 2, physical.eyebrowsStyle, physical.eyebrowsOpacity or 1.0)
    SetPedHeadOverlayColor(ped, 2, 1, physical.eyebrowsColor or 0, physical.eyebrowsColor or 0)
  end

  if physical.beardStyle then
    ambitionsPrint.info('Applying beard...')
    SetPedHeadOverlay(ped, 1, physical.beardStyle, physical.beardOpacity or 1.0)
    SetPedHeadOverlayColor(ped, 1, 1, physical.beardColor or 0, physical.beardSecondaryColor or 0)
  end

  if physical.ageingStyle then
    SetPedHeadOverlay(ped, 3, physical.ageingStyle, physical.ageingOpacity or 1.0)
  end

  if physical.makeupStyle then
    SetPedHeadOverlay(ped, 4, physical.makeupStyle, physical.makeupOpacity or 1.0)
    SetPedHeadOverlayColor(ped, 4, 2, physical.makeupPrimaryColor or 0, physical.makeupSecondaryColor or 0)
  end

  if physical.blushStyle then
    SetPedHeadOverlay(ped, 5, physical.blushStyle, physical.blushOpacity or 1.0)
    SetPedHeadOverlayColor(ped, 5, 2, physical.blushColor or 0, 0)
  end

  if physical.complexionStyle then
    SetPedHeadOverlay(ped, 6, physical.complexionStyle, physical.complexionOpacity or 1.0)
  end

  if physical.sunDamageStyle then
    SetPedHeadOverlay(ped, 7, physical.sunDamageStyle, physical.sunDamageOpacity or 1.0)
  end

  if physical.lipstickStyle then
    SetPedHeadOverlay(ped, 8, physical.lipstickStyle, physical.lipstickOpacity or 1.0)
    SetPedHeadOverlayColor(ped, 8, 2, physical.lipstickColor or 0, 0)
  end

  if physical.molesFrecklesStyle then
    SetPedHeadOverlay(ped, 9, physical.molesFrecklesStyle, physical.molesFrecklesOpacity or 1.0)
  end

  if physical.chestHairStyle then
    SetPedHeadOverlay(ped, 10, physical.chestHairStyle, physical.chestHairOpacity or 1.0)
    SetPedHeadOverlayColor(ped, 10, 1, physical.chestHairColor or 0, 0)
  end

  if physical.bodyBlemishesStyle then
    SetPedHeadOverlay(ped, 11, physical.bodyBlemishesStyle, physical.bodyBlemishesOpacity or 1.0)
  end

  local faceFeatures = {
    [0] = physical.noseWidth,
    [1] = physical.noseBridge,
    [2] = physical.noseTipHeight,
    [3] = physical.noseBridgeTwist,
    [4] = physical.noseHeight,
    [5] = physical.noseLength,
    [6] = physical.cheekBoneHeight,
    [7] = physical.cheekBoneWidth,
    [8] = physical.cheekWidth,
    [9] = physical.eyeOpening,
    [10] = physical.lipThickness,
    [11] = physical.jawWidth,
    [12] = physical.jawHeight,
    [13] = physical.chinLength,
    [14] = physical.chinLowering,
    [15] = physical.chinWidth,
    [16] = physical.chinCleft,
    [17] = physical.neckThickness,
    [18] = physical.eyebrowHeight,
    [19] = physical.eyebrowDepth
  }

  for index, value in pairs(faceFeatures) do
    if value then
      SetPedFaceFeature(ped, index, value)
    end
  end

  ambitionsPrint.info('Applying clothing...')
  SetPedComponentVariation(ped, 1, clothing.maskDrawable or 0, clothing.maskTexture or 0, 0)
  SetPedComponentVariation(ped, 3, clothing.armsDrawable or 0, clothing.armsTexture or 0, 0)
  SetPedComponentVariation(ped, 4, clothing.pantsDrawable or 0, clothing.pantsTexture or 0, 0)
  SetPedComponentVariation(ped, 5, clothing.backpackDrawable or 0, clothing.backpackTexture or 0, 0)
  SetPedComponentVariation(ped, 6, clothing.shoesDrawable or 0, clothing.shoesTexture or 0, 0)
  SetPedComponentVariation(ped, 7, clothing.jacketDrawable or 0, clothing.jacketTexture or 0, 0)
  SetPedComponentVariation(ped, 8, clothing.undershirtDrawable or 0, clothing.undershirtTexture or 0, 0)
  SetPedComponentVariation(ped, 9, clothing.bodyArmorDrawable or 0, clothing.bodyArmorTexture or 0, 0)
  SetPedComponentVariation(ped, 10, clothing.decalsDrawable or 0, clothing.decalsTexture or 0, 0)
  SetPedComponentVariation(ped, 11, clothing.torsoDrawable or 0, clothing.torsoTexture or 0, 0)

  ambitionsPrint.info('Applying accessories...')
  if accessories.hatDrawable and accessories.hatDrawable > 0 then
    SetPedPropIndex(ped, 0, accessories.hatDrawable, accessories.hatTexture or 0, true)
  else
    ClearPedProp(ped, 0)
  end

  if accessories.glassesDrawable and accessories.glassesDrawable > 0 then
    SetPedPropIndex(ped, 1, accessories.glassesDrawable, accessories.glassesTexture or 0, true)
  else
    ClearPedProp(ped, 1)
  end

  if accessories.earringsDrawable and accessories.earringsDrawable > 0 then
    SetPedPropIndex(ped, 2, accessories.earringsDrawable, accessories.earringsTexture or 0, true)
  else
    ClearPedProp(ped, 2)
  end

  if accessories.watchDrawable and accessories.watchDrawable > 0 then
    SetPedPropIndex(ped, 6, accessories.watchDrawable, accessories.watchTexture or 0, true)
  else
    ClearPedProp(ped, 6)
  end

  if accessories.braceletDrawable and accessories.braceletDrawable > 0 then
    SetPedPropIndex(ped, 7, accessories.braceletDrawable, accessories.braceletTexture or 0, true)
  else
    ClearPedProp(ped, 7)
  end

  ambitionsPrint.info('Applying tattoos...')
  ClearPedDecorations(ped)

  ambitionsPrint.success('========== FULL APPEARANCE LOADED ==========')
end

return {
  LoadFullAppearance = LoadFullAppearance,
}
