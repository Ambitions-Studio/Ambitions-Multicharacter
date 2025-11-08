local ambitionsPrint = require('Ambitions.shared.lib.log.print')
local appearanceApply = require('client.modules.appearance.apply')
local clothingApply = require('client.modules.clothing.apply')
local accessoriesApply = require('client.modules.accessories.apply')
local tattoosApply = require('client.modules.tattoos.apply')

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

  if appearanceData.heritage then
    ambitionsPrint.info('Applying heritage...')
    appearanceApply.ApplyHeritage(appearanceData.heritage)
  end

  if appearanceData.hairStyle then
    ambitionsPrint.info('Applying hair style...')
    appearanceApply.ApplyHairStyle(appearanceData.hairStyle)
  end

  if appearanceData.faceFeatures then
    ambitionsPrint.info('Applying face features...')
    for index, value in pairs(appearanceData.faceFeatures) do
      appearanceApply.ApplyFaceFeature(tonumber(index), value)
    end
  end

  if appearanceData.eyes then
    ambitionsPrint.info('Applying eyes customization...')
    appearanceApply.ApplyEyesCustomization(appearanceData.eyes)
  end

  if appearanceData.eyebrows then
    ambitionsPrint.info('Applying eyebrows customization...')
    appearanceApply.ApplyEyebrowsCustomization(appearanceData.eyebrows)
  end

  if appearanceData.nose then
    ambitionsPrint.info('Applying nose customization...')
    appearanceApply.ApplyNoseCustomization(appearanceData.nose)
  end

  if appearanceData.cheeks then
    ambitionsPrint.info('Applying cheeks customization...')
    appearanceApply.ApplyCheeksCustomization(appearanceData.cheeks)
  end

  if appearanceData.beard then
    ambitionsPrint.info('Applying beard customization...')
    appearanceApply.ApplyBeardCustomization(appearanceData.beard)
  end

  if appearanceData.jaw then
    ambitionsPrint.info('Applying jaw customization...')
    appearanceApply.ApplyJawCustomization(appearanceData.jaw)
  end

  if appearanceData.lips then
    ambitionsPrint.info('Applying lips customization...')
    appearanceApply.ApplyLipsCustomization(appearanceData.lips)
  end

  if appearanceData.chin then
    ambitionsPrint.info('Applying chin customization...')
    appearanceApply.ApplyChinCustomization(appearanceData.chin)
  end

  if appearanceData.neck then
    ambitionsPrint.info('Applying neck customization...')
    appearanceApply.ApplyNeckCustomization(appearanceData.neck)
  end

  if appearanceData.ageing then
    ambitionsPrint.info('Applying ageing customization...')
    appearanceApply.ApplyAgeingCustomization(appearanceData.ageing)
  end

  if appearanceData.makeup then
    ambitionsPrint.info('Applying makeup customization...')
    appearanceApply.ApplyMakeupCustomization(appearanceData.makeup)
  end

  if appearanceData.blush then
    ambitionsPrint.info('Applying blush customization...')
    appearanceApply.ApplyBlushCustomization(appearanceData.blush)
  end

  if appearanceData.complexion then
    ambitionsPrint.info('Applying complexion customization...')
    appearanceApply.ApplyComplexionCustomization(appearanceData.complexion)
  end

  if appearanceData.sunDamage then
    ambitionsPrint.info('Applying sun damage customization...')
    appearanceApply.ApplySunDamageCustomization(appearanceData.sunDamage)
  end

  if appearanceData.molesFreckles then
    ambitionsPrint.info('Applying moles/freckles customization...')
    appearanceApply.ApplyMolesFrecklesCustomization(appearanceData.molesFreckles)
  end

  if appearanceData.chestHair then
    ambitionsPrint.info('Applying chest hair customization...')
    appearanceApply.ApplyChestHairCustomization(appearanceData.chestHair)
  end

  if appearanceData.bodyBlemishes then
    ambitionsPrint.info('Applying body blemishes customization...')
    appearanceApply.ApplyBodyBlemishesCustomization(appearanceData.bodyBlemishes)
  end

  if appearanceData.clothing then
    ambitionsPrint.info('Applying clothing...')
    if appearanceData.clothing.mask then
      clothingApply.ApplyMaskCustomization(appearanceData.clothing.mask)
    end
    if appearanceData.clothing.torso then
      clothingApply.ApplyTorsoCustomization(appearanceData.clothing.torso)
    end
    if appearanceData.clothing.legs then
      clothingApply.ApplyLegsCustomization(appearanceData.clothing.legs)
    end
    if appearanceData.clothing.bags then
      clothingApply.ApplyBagsCustomization(appearanceData.clothing.bags)
    end
    if appearanceData.clothing.shoes then
      clothingApply.ApplyShoesCustomization(appearanceData.clothing.shoes)
    end
    if appearanceData.clothing.accessories then
      clothingApply.ApplyAccessoriesCustomization(appearanceData.clothing.accessories)
    end
    if appearanceData.clothing.undershirts then
      clothingApply.ApplyUndershirtsCustomization(appearanceData.clothing.undershirts)
    end
    if appearanceData.clothing.armor then
      clothingApply.ApplyArmorCustomization(appearanceData.clothing.armor)
    end
    if appearanceData.clothing.decals then
      clothingApply.ApplyDecalsCustomization(appearanceData.clothing.decals)
    end
    if appearanceData.clothing.tops then
      clothingApply.ApplyTopsCustomization(appearanceData.clothing.tops)
    end
  end

  if appearanceData.accessories then
    ambitionsPrint.info('Applying accessories...')
    if appearanceData.accessories.hat then
      accessoriesApply.ApplyHatCustomization(appearanceData.accessories.hat)
    end
    if appearanceData.accessories.glasses then
      accessoriesApply.ApplyGlassesCustomization(appearanceData.accessories.glasses)
    end
    if appearanceData.accessories.earrings then
      accessoriesApply.ApplyEarringsCustomization(appearanceData.accessories.earrings)
    end
    if appearanceData.accessories.watch then
      accessoriesApply.ApplyWatchCustomization(appearanceData.accessories.watch)
    end
    if appearanceData.accessories.bracelet then
      accessoriesApply.ApplyBraceletCustomization(appearanceData.accessories.bracelet)
    end
    if appearanceData.accessories.neckAccessory then
      accessoriesApply.ApplyNeckAccessoryCustomization(appearanceData.accessories.neckAccessory)
    end
  end

  if appearanceData.tattoos then
    ambitionsPrint.info('Applying tattoos...')
    if appearanceData.tattoos.head then
      tattoosApply.ApplyHeadTattoo(appearanceData.tattoos.head)
    end
    if appearanceData.tattoos.neck then
      tattoosApply.ApplyNeckTattoo(appearanceData.tattoos.neck)
    end
    if appearanceData.tattoos.torso then
      tattoosApply.ApplyTorsoTattoo(appearanceData.tattoos.torso)
    end
    if appearanceData.tattoos.back then
      tattoosApply.ApplyBackTattoo(appearanceData.tattoos.back)
    end
    if appearanceData.tattoos.leftArm then
      tattoosApply.ApplyLeftArmTattoo(appearanceData.tattoos.leftArm)
    end
    if appearanceData.tattoos.rightArm then
      tattoosApply.ApplyRightArmTattoo(appearanceData.tattoos.rightArm)
    end
    if appearanceData.tattoos.leftLeg then
      tattoosApply.ApplyLeftLegTattoo(appearanceData.tattoos.leftLeg)
    end
    if appearanceData.tattoos.rightLeg then
      tattoosApply.ApplyRightLegTattoo(appearanceData.tattoos.rightLeg)
    end
  end

  ambitionsPrint.success('========== FULL APPEARANCE LOADED ==========')
end

return {
  LoadFullAppearance = LoadFullAppearance,
}
