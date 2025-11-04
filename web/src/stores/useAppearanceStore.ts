import { defineStore } from 'pinia'
import { ref } from 'vue'

export type AppearanceData = {
  ped: {
    selectedPed: string | null
  }
  heritage: {
    father: number
    mother: number
    faceResemblance: number
    skinResemblance: number
  }
  physical: {
    hairStyle: number
    hairColor: number
    hairHighlight: number
    eyeOpening: number
    eyeColor: number
    eyebrowHeight: number
    eyebrowDepth: number
    eyebrowsStyle: number
    eyebrowsColor: number
    eyebrowsOpacity: number
    noseWidth: number
    noseHeight: number
    noseLength: number
    noseBridge: number
    noseBridgeTwist: number
    noseTipHeight: number
    cheekBoneHeight: number
    cheekBoneWidth: number
    cheekWidth: number
    jawWidth: number
    jawHeight: number
    lipThickness: number
    chinLowering: number
    chinLength: number
    chinWidth: number
    chinCleft: number
    neckThickness: number
    beardStyle: number
    beardColor: number
    beardSecondaryColor: number
    beardOpacity: number
    ageingStyle: number
    ageingOpacity: number
    makeupStyle: number
    makeupPrimaryColor: number
    makeupSecondaryColor: number
    makeupOpacity: number
    blushStyle: number
    blushColor: number
    blushOpacity: number
    complexionStyle: number
    complexionOpacity: number
    sunDamageStyle: number
    sunDamageOpacity: number
    lipstickStyle: number
    lipstickColor: number
    lipstickOpacity: number
    molesFrecklesStyle: number
    molesFrecklesOpacity: number
    chestHairStyle: number
    chestHairColor: number
    chestHairOpacity: number
    bodyBlemishesStyle: number
    bodyBlemishesOpacity: number
  }
  clothing: {
    maskDrawable: number
    maskTexture: number
    torsoDrawable: number
    torsoTexture: number
    undershirtDrawable: number
    undershirtTexture: number
    armsDrawable: number
    armsTexture: number
    jacketDrawable: number
    jacketTexture: number
    bodyArmorDrawable: number
    bodyArmorTexture: number
    decalsDrawable: number
    decalsTexture: number
    pantsDrawable: number
    pantsTexture: number
    shoesDrawable: number
    shoesTexture: number
    backpackDrawable: number
    backpackTexture: number
  }
  accessories: {
    hatDrawable: number
    hatTexture: number
    glassesDrawable: number
    glassesTexture: number
    earringsDrawable: number
    earringsTexture: number
    watchDrawable: number
    watchTexture: number
    braceletDrawable: number
    braceletTexture: number
    neckAccessoryDrawable: number
    neckAccessoryTexture: number
  }
  tattoos: {
    headTattooCollection: number
    headTattooHash: number
    neckTattooCollection: number
    neckTattooHash: number
    torsoTattooCollection: number
    torsoTattooHash: number
    backTattooCollection: number
    backTattooHash: number
    leftArmTattooCollection: number
    leftArmTattooHash: number
    rightArmTattooCollection: number
    rightArmTattooHash: number
    leftLegTattooCollection: number
    leftLegTattooHash: number
    rightLegTattooCollection: number
    rightLegTattooHash: number
  }
}

export const useAppearanceStore = defineStore('appearance', () => {
  // State - Ped Selection
  const selectedPed = ref<string | null>(null)

  // State - Heritage
  const selectedFather = ref<number>(0)
  const selectedMother = ref<number>(0)
  const faceResemblance = ref<number>(0.5)
  const skinResemblance = ref<number>(0.5)

  // State - Physical Customization
  const hairStyle = ref<number>(0)
  const hairColor = ref<number>(0)
  const hairHighlight = ref<number>(0)
  const eyeOpening = ref<number>(0)
  const eyeColor = ref<number>(0)
  const eyebrowHeight = ref<number>(0)
  const eyebrowDepth = ref<number>(0)
  const eyebrowsStyle = ref<number>(0)
  const eyebrowsColor = ref<number>(0)
  const eyebrowsOpacity = ref<number>(1)
  const noseWidth = ref<number>(0)
  const noseHeight = ref<number>(0)
  const noseLength = ref<number>(0)
  const noseBridge = ref<number>(0)
  const noseBridgeTwist = ref<number>(0)
  const noseTipHeight = ref<number>(0)
  const cheekBoneHeight = ref<number>(0)
  const cheekBoneWidth = ref<number>(0)
  const cheekWidth = ref<number>(0)
  const jawWidth = ref<number>(0)
  const jawHeight = ref<number>(0)
  const lipThickness = ref<number>(0)
  const chinLowering = ref<number>(0)
  const chinLength = ref<number>(0)
  const chinWidth = ref<number>(0)
  const chinCleft = ref<number>(0)
  const neckThickness = ref<number>(0)
  const beardStyle = ref<number>(0)
  const beardColor = ref<number>(0)
  const beardSecondaryColor = ref<number>(0)
  const beardOpacity = ref<number>(1)
  const ageingStyle = ref<number>(0)
  const ageingOpacity = ref<number>(0)
  const makeupStyle = ref<number>(0)
  const makeupPrimaryColor = ref<number>(0)
  const makeupSecondaryColor = ref<number>(0)
  const makeupOpacity = ref<number>(0)
  const blushStyle = ref<number>(0)
  const blushColor = ref<number>(0)
  const blushOpacity = ref<number>(0)
  const complexionStyle = ref<number>(0)
  const complexionOpacity = ref<number>(0)
  const sunDamageStyle = ref<number>(0)
  const sunDamageOpacity = ref<number>(0)
  const lipstickStyle = ref<number>(0)
  const lipstickColor = ref<number>(0)
  const lipstickOpacity = ref<number>(0)
  const molesFrecklesStyle = ref<number>(0)
  const molesFrecklesOpacity = ref<number>(0)
  const chestHairStyle = ref<number>(0)
  const chestHairColor = ref<number>(0)
  const chestHairOpacity = ref<number>(0)
  const bodyBlemishesStyle = ref<number>(0)
  const bodyBlemishesOpacity = ref<number>(0)

  // State - Clothing
  const maskDrawable = ref<number>(0)
  const maskTexture = ref<number>(0)
  const torsoDrawable = ref<number>(0)
  const torsoTexture = ref<number>(0)
  const undershirtDrawable = ref<number>(0)
  const undershirtTexture = ref<number>(0)
  const armsDrawable = ref<number>(0)
  const armsTexture = ref<number>(0)
  const jacketDrawable = ref<number>(0)
  const jacketTexture = ref<number>(0)
  const bodyArmorDrawable = ref<number>(0)
  const bodyArmorTexture = ref<number>(0)
  const decalsDrawable = ref<number>(0)
  const decalsTexture = ref<number>(0)
  const pantsDrawable = ref<number>(0)
  const pantsTexture = ref<number>(0)
  const shoesDrawable = ref<number>(0)
  const shoesTexture = ref<number>(0)
  const backpackDrawable = ref<number>(0)
  const backpackTexture = ref<number>(0)

  // State - Accessories
  const hatDrawable = ref<number>(0)
  const hatTexture = ref<number>(0)
  const glassesDrawable = ref<number>(0)
  const glassesTexture = ref<number>(0)
  const earringsDrawable = ref<number>(0)
  const earringsTexture = ref<number>(0)
  const watchDrawable = ref<number>(0)
  const watchTexture = ref<number>(0)
  const braceletDrawable = ref<number>(0)
  const braceletTexture = ref<number>(0)
  const neckAccessoryDrawable = ref<number>(0)
  const neckAccessoryTexture = ref<number>(0)

  // State - Tattoos
  const headTattooCollection = ref<number>(0)
  const headTattooHash = ref<number>(0)
  const neckTattooCollection = ref<number>(0)
  const neckTattooHash = ref<number>(0)
  const torsoTattooCollection = ref<number>(0)
  const torsoTattooHash = ref<number>(0)
  const backTattooCollection = ref<number>(0)
  const backTattooHash = ref<number>(0)
  const leftArmTattooCollection = ref<number>(0)
  const leftArmTattooHash = ref<number>(0)
  const rightArmTattooCollection = ref<number>(0)
  const rightArmTattooHash = ref<number>(0)
  const leftLegTattooCollection = ref<number>(0)
  const leftLegTattooHash = ref<number>(0)
  const rightLegTattooCollection = ref<number>(0)
  const rightLegTattooHash = ref<number>(0)

  const isAppearanceComplete = ref(false)

  // Setters - Ped Selection
  const setSelectedPed = (value: string | null) => {
    selectedPed.value = value
  }

  // Setters - Heritage
  const setSelectedFather = (value: number) => {
    selectedFather.value = value
  }

  const setSelectedMother = (value: number) => {
    selectedMother.value = value
  }

  const setFaceResemblance = (value: number) => {
    faceResemblance.value = value
  }

  const setSkinResemblance = (value: number) => {
    skinResemblance.value = value
  }

  // Setters - Physical Customization (Global)
  const setPhysicalCustomization = (data: AppearanceData['physical']) => {
    hairStyle.value = data.hairStyle
    hairColor.value = data.hairColor
    hairHighlight.value = data.hairHighlight
    eyeOpening.value = data.eyeOpening
    eyeColor.value = data.eyeColor
    eyebrowHeight.value = data.eyebrowHeight
    eyebrowDepth.value = data.eyebrowDepth
    eyebrowsStyle.value = data.eyebrowsStyle
    eyebrowsColor.value = data.eyebrowsColor
    eyebrowsOpacity.value = data.eyebrowsOpacity
    noseWidth.value = data.noseWidth
    noseHeight.value = data.noseHeight
    noseLength.value = data.noseLength
    noseBridge.value = data.noseBridge
    noseBridgeTwist.value = data.noseBridgeTwist
    noseTipHeight.value = data.noseTipHeight
    cheekBoneHeight.value = data.cheekBoneHeight
    cheekBoneWidth.value = data.cheekBoneWidth
    cheekWidth.value = data.cheekWidth
    jawWidth.value = data.jawWidth
    jawHeight.value = data.jawHeight
    lipThickness.value = data.lipThickness
    chinLowering.value = data.chinLowering
    chinLength.value = data.chinLength
    chinWidth.value = data.chinWidth
    chinCleft.value = data.chinCleft
    neckThickness.value = data.neckThickness
    beardStyle.value = data.beardStyle
    beardColor.value = data.beardColor
    beardSecondaryColor.value = data.beardSecondaryColor
    beardOpacity.value = data.beardOpacity
    ageingStyle.value = data.ageingStyle
    ageingOpacity.value = data.ageingOpacity
    makeupStyle.value = data.makeupStyle
    makeupPrimaryColor.value = data.makeupPrimaryColor
    makeupSecondaryColor.value = data.makeupSecondaryColor
    makeupOpacity.value = data.makeupOpacity
    blushStyle.value = data.blushStyle
    blushColor.value = data.blushColor
    blushOpacity.value = data.blushOpacity
    complexionStyle.value = data.complexionStyle
    complexionOpacity.value = data.complexionOpacity
    sunDamageStyle.value = data.sunDamageStyle
    sunDamageOpacity.value = data.sunDamageOpacity
    lipstickStyle.value = data.lipstickStyle
    lipstickColor.value = data.lipstickColor
    lipstickOpacity.value = data.lipstickOpacity
    molesFrecklesStyle.value = data.molesFrecklesStyle
    molesFrecklesOpacity.value = data.molesFrecklesOpacity
    chestHairStyle.value = data.chestHairStyle
    chestHairColor.value = data.chestHairColor
    chestHairOpacity.value = data.chestHairOpacity
    bodyBlemishesStyle.value = data.bodyBlemishesStyle
    bodyBlemishesOpacity.value = data.bodyBlemishesOpacity
  }

  // Setters - Physical Customization (Per Section)
  const setHairSection = (data: {
    hairStyle: number
    hairColor: number
    hairHighlight: number
  }) => {
    hairStyle.value = data.hairStyle
    hairColor.value = data.hairColor
    hairHighlight.value = data.hairHighlight
  }

  const setEyesSection = (data: { eyeOpening: number; eyeColor: number }) => {
    eyeOpening.value = data.eyeOpening
    eyeColor.value = data.eyeColor
  }

  const setEyebrowsSection = (data: {
    eyebrowHeight: number
    eyebrowDepth: number
    eyebrowsStyle: number
    eyebrowsColor: number
    eyebrowsOpacity: number
  }) => {
    eyebrowHeight.value = data.eyebrowHeight
    eyebrowDepth.value = data.eyebrowDepth
    eyebrowsStyle.value = data.eyebrowsStyle
    eyebrowsColor.value = data.eyebrowsColor
    eyebrowsOpacity.value = data.eyebrowsOpacity
  }

  const setNoseSection = (data: {
    noseWidth: number
    noseHeight: number
    noseLength: number
    noseBridge: number
    noseBridgeTwist: number
    noseTipHeight: number
  }) => {
    noseWidth.value = data.noseWidth
    noseHeight.value = data.noseHeight
    noseLength.value = data.noseLength
    noseBridge.value = data.noseBridge
    noseBridgeTwist.value = data.noseBridgeTwist
    noseTipHeight.value = data.noseTipHeight
  }

  const setCheeksSection = (data: {
    cheekBoneHeight: number
    cheekBoneWidth: number
    cheekWidth: number
  }) => {
    cheekBoneHeight.value = data.cheekBoneHeight
    cheekBoneWidth.value = data.cheekBoneWidth
    cheekWidth.value = data.cheekWidth
  }

  const setBeardSection = (data: {
    beardStyle: number
    beardColor: number
    beardSecondaryColor: number
    beardOpacity: number
  }) => {
    beardStyle.value = data.beardStyle
    beardColor.value = data.beardColor
    beardSecondaryColor.value = data.beardSecondaryColor
    beardOpacity.value = data.beardOpacity
  }

  const setJawSection = (data: { jawWidth: number; jawHeight: number }) => {
    jawWidth.value = data.jawWidth
    jawHeight.value = data.jawHeight
  }

  const setLipsSection = (data: {
    lipThickness: number
    lipstickStyle: number
    lipstickColor: number
    lipstickOpacity: number
  }) => {
    lipThickness.value = data.lipThickness
    lipstickStyle.value = data.lipstickStyle
    lipstickColor.value = data.lipstickColor
    lipstickOpacity.value = data.lipstickOpacity
  }

  const setChinSection = (data: {
    chinLowering: number
    chinLength: number
    chinWidth: number
    chinCleft: number
  }) => {
    chinLowering.value = data.chinLowering
    chinLength.value = data.chinLength
    chinWidth.value = data.chinWidth
    chinCleft.value = data.chinCleft
  }

  const setNeckSection = (data: { neckThickness: number }) => {
    neckThickness.value = data.neckThickness
  }

  const setAgeingSection = (data: { ageingStyle: number; ageingOpacity: number }) => {
    ageingStyle.value = data.ageingStyle
    ageingOpacity.value = data.ageingOpacity
  }

  const setMakeupSection = (data: {
    makeupStyle: number
    makeupPrimaryColor: number
    makeupSecondaryColor: number
    makeupOpacity: number
  }) => {
    makeupStyle.value = data.makeupStyle
    makeupPrimaryColor.value = data.makeupPrimaryColor
    makeupSecondaryColor.value = data.makeupSecondaryColor
    makeupOpacity.value = data.makeupOpacity
  }

  const setBlushSection = (data: {
    blushStyle: number
    blushColor: number
    blushOpacity: number
  }) => {
    blushStyle.value = data.blushStyle
    blushColor.value = data.blushColor
    blushOpacity.value = data.blushOpacity
  }

  const setComplexionSection = (data: {
    complexionStyle: number
    complexionOpacity: number
  }) => {
    complexionStyle.value = data.complexionStyle
    complexionOpacity.value = data.complexionOpacity
  }

  const setSunDamageSection = (data: {
    sunDamageStyle: number
    sunDamageOpacity: number
  }) => {
    sunDamageStyle.value = data.sunDamageStyle
    sunDamageOpacity.value = data.sunDamageOpacity
  }

  const setMolesFrecklesSection = (data: {
    molesFrecklesStyle: number
    molesFrecklesOpacity: number
  }) => {
    molesFrecklesStyle.value = data.molesFrecklesStyle
    molesFrecklesOpacity.value = data.molesFrecklesOpacity
  }

  const setChestHairSection = (data: {
    chestHairStyle: number
    chestHairColor: number
    chestHairOpacity: number
  }) => {
    chestHairStyle.value = data.chestHairStyle
    chestHairColor.value = data.chestHairColor
    chestHairOpacity.value = data.chestHairOpacity
  }

  const setBodyBlemishesSection = (data: {
    bodyBlemishesStyle: number
    bodyBlemishesOpacity: number
  }) => {
    bodyBlemishesStyle.value = data.bodyBlemishesStyle
    bodyBlemishesOpacity.value = data.bodyBlemishesOpacity
  }

  // Setters - Clothing (Global)
  const setClothing = (data: AppearanceData['clothing']) => {
    maskDrawable.value = data.maskDrawable
    maskTexture.value = data.maskTexture
    torsoDrawable.value = data.torsoDrawable
    torsoTexture.value = data.torsoTexture
    undershirtDrawable.value = data.undershirtDrawable
    undershirtTexture.value = data.undershirtTexture
    armsDrawable.value = data.armsDrawable
    armsTexture.value = data.armsTexture
    jacketDrawable.value = data.jacketDrawable
    jacketTexture.value = data.jacketTexture
    bodyArmorDrawable.value = data.bodyArmorDrawable
    bodyArmorTexture.value = data.bodyArmorTexture
    decalsDrawable.value = data.decalsDrawable
    decalsTexture.value = data.decalsTexture
    pantsDrawable.value = data.pantsDrawable
    pantsTexture.value = data.pantsTexture
    shoesDrawable.value = data.shoesDrawable
    shoesTexture.value = data.shoesTexture
    backpackDrawable.value = data.backpackDrawable
    backpackTexture.value = data.backpackTexture
  }

  // Setters - Clothing (Per Section)
  const setMaskSection = (data: { maskDrawable: number; maskTexture: number }) => {
    maskDrawable.value = data.maskDrawable
    maskTexture.value = data.maskTexture
  }

  const setTorsoSection = (data: { torsoDrawable: number; torsoTexture: number }) => {
    torsoDrawable.value = data.torsoDrawable
    torsoTexture.value = data.torsoTexture
  }

  const setUndershirtSection = (data: {
    undershirtDrawable: number
    undershirtTexture: number
  }) => {
    undershirtDrawable.value = data.undershirtDrawable
    undershirtTexture.value = data.undershirtTexture
  }

  const setArmsSection = (data: { armsDrawable: number; armsTexture: number }) => {
    armsDrawable.value = data.armsDrawable
    armsTexture.value = data.armsTexture
  }

  const setJacketSection = (data: { jacketDrawable: number; jacketTexture: number }) => {
    jacketDrawable.value = data.jacketDrawable
    jacketTexture.value = data.jacketTexture
  }

  const setBodyArmorSection = (data: {
    bodyArmorDrawable: number
    bodyArmorTexture: number
  }) => {
    bodyArmorDrawable.value = data.bodyArmorDrawable
    bodyArmorTexture.value = data.bodyArmorTexture
  }

  const setDecalsSection = (data: { decalsDrawable: number; decalsTexture: number }) => {
    decalsDrawable.value = data.decalsDrawable
    decalsTexture.value = data.decalsTexture
  }

  const setPantsSection = (data: { pantsDrawable: number; pantsTexture: number }) => {
    pantsDrawable.value = data.pantsDrawable
    pantsTexture.value = data.pantsTexture
  }

  const setShoesSection = (data: { shoesDrawable: number; shoesTexture: number }) => {
    shoesDrawable.value = data.shoesDrawable
    shoesTexture.value = data.shoesTexture
  }

  const setBackpackSection = (data: { backpackDrawable: number; backpackTexture: number }) => {
    backpackDrawable.value = data.backpackDrawable
    backpackTexture.value = data.backpackTexture
  }

  // Setters - Accessories (Global)
  const setAccessories = (data: AppearanceData['accessories']) => {
    hatDrawable.value = data.hatDrawable
    hatTexture.value = data.hatTexture
    glassesDrawable.value = data.glassesDrawable
    glassesTexture.value = data.glassesTexture
    earringsDrawable.value = data.earringsDrawable
    earringsTexture.value = data.earringsTexture
    watchDrawable.value = data.watchDrawable
    watchTexture.value = data.watchTexture
    braceletDrawable.value = data.braceletDrawable
    braceletTexture.value = data.braceletTexture
    neckAccessoryDrawable.value = data.neckAccessoryDrawable
    neckAccessoryTexture.value = data.neckAccessoryTexture
  }

  // Setters - Accessories (Per Section)
  const setHatSection = (data: { hatDrawable: number; hatTexture: number }) => {
    hatDrawable.value = data.hatDrawable
    hatTexture.value = data.hatTexture
  }

  const setGlassesSection = (data: { glassesDrawable: number; glassesTexture: number }) => {
    glassesDrawable.value = data.glassesDrawable
    glassesTexture.value = data.glassesTexture
  }

  const setEarringsSection = (data: { earringsDrawable: number; earringsTexture: number }) => {
    earringsDrawable.value = data.earringsDrawable
    earringsTexture.value = data.earringsTexture
  }

  const setWatchSection = (data: { watchDrawable: number; watchTexture: number }) => {
    watchDrawable.value = data.watchDrawable
    watchTexture.value = data.watchTexture
  }

  const setBraceletSection = (data: { braceletDrawable: number; braceletTexture: number }) => {
    braceletDrawable.value = data.braceletDrawable
    braceletTexture.value = data.braceletTexture
  }

  const setNeckAccessorySection = (data: {
    neckAccessoryDrawable: number
    neckAccessoryTexture: number
  }) => {
    neckAccessoryDrawable.value = data.neckAccessoryDrawable
    neckAccessoryTexture.value = data.neckAccessoryTexture
  }

  // Setters - Tattoos (Global)
  const setTattoos = (data: AppearanceData['tattoos']) => {
    headTattooCollection.value = data.headTattooCollection
    headTattooHash.value = data.headTattooHash
    neckTattooCollection.value = data.neckTattooCollection
    neckTattooHash.value = data.neckTattooHash
    torsoTattooCollection.value = data.torsoTattooCollection
    torsoTattooHash.value = data.torsoTattooHash
    backTattooCollection.value = data.backTattooCollection
    backTattooHash.value = data.backTattooHash
    leftArmTattooCollection.value = data.leftArmTattooCollection
    leftArmTattooHash.value = data.leftArmTattooHash
    rightArmTattooCollection.value = data.rightArmTattooCollection
    rightArmTattooHash.value = data.rightArmTattooHash
    leftLegTattooCollection.value = data.leftLegTattooCollection
    leftLegTattooHash.value = data.leftLegTattooHash
    rightLegTattooCollection.value = data.rightLegTattooCollection
    rightLegTattooHash.value = data.rightLegTattooHash
  }

  // Setters - Tattoos (Per Section)
  const setHeadTattooSection = (data: {
    headTattooCollection: number
    headTattooHash: number
  }) => {
    headTattooCollection.value = data.headTattooCollection
    headTattooHash.value = data.headTattooHash
  }

  const setNeckTattooSection = (data: {
    neckTattooCollection: number
    neckTattooHash: number
  }) => {
    neckTattooCollection.value = data.neckTattooCollection
    neckTattooHash.value = data.neckTattooHash
  }

  const setTorsoTattooSection = (data: {
    torsoTattooCollection: number
    torsoTattooHash: number
  }) => {
    torsoTattooCollection.value = data.torsoTattooCollection
    torsoTattooHash.value = data.torsoTattooHash
  }

  const setBackTattooSection = (data: {
    backTattooCollection: number
    backTattooHash: number
  }) => {
    backTattooCollection.value = data.backTattooCollection
    backTattooHash.value = data.backTattooHash
  }

  const setLeftArmTattooSection = (data: {
    leftArmTattooCollection: number
    leftArmTattooHash: number
  }) => {
    leftArmTattooCollection.value = data.leftArmTattooCollection
    leftArmTattooHash.value = data.leftArmTattooHash
  }

  const setRightArmTattooSection = (data: {
    rightArmTattooCollection: number
    rightArmTattooHash: number
  }) => {
    rightArmTattooCollection.value = data.rightArmTattooCollection
    rightArmTattooHash.value = data.rightArmTattooHash
  }

  const setLeftLegTattooSection = (data: {
    leftLegTattooCollection: number
    leftLegTattooHash: number
  }) => {
    leftLegTattooCollection.value = data.leftLegTattooCollection
    leftLegTattooHash.value = data.leftLegTattooHash
  }

  const setRightLegTattooSection = (data: {
    rightLegTattooCollection: number
    rightLegTattooHash: number
  }) => {
    rightLegTattooCollection.value = data.rightLegTattooCollection
    rightLegTattooHash.value = data.rightLegTattooHash
  }

  // Getters
  const getAppearanceData = (): AppearanceData => {
    return {
      ped: {
        selectedPed: selectedPed.value,
      },
      heritage: {
        father: selectedFather.value,
        mother: selectedMother.value,
        faceResemblance: faceResemblance.value,
        skinResemblance: skinResemblance.value,
      },
      physical: {
        hairStyle: hairStyle.value,
        hairColor: hairColor.value,
        hairHighlight: hairHighlight.value,
        eyeOpening: eyeOpening.value,
        eyeColor: eyeColor.value,
        eyebrowHeight: eyebrowHeight.value,
        eyebrowDepth: eyebrowDepth.value,
        eyebrowsStyle: eyebrowsStyle.value,
        eyebrowsColor: eyebrowsColor.value,
        eyebrowsOpacity: eyebrowsOpacity.value,
        noseWidth: noseWidth.value,
        noseHeight: noseHeight.value,
        noseLength: noseLength.value,
        noseBridge: noseBridge.value,
        noseBridgeTwist: noseBridgeTwist.value,
        noseTipHeight: noseTipHeight.value,
        cheekBoneHeight: cheekBoneHeight.value,
        cheekBoneWidth: cheekBoneWidth.value,
        cheekWidth: cheekWidth.value,
        jawWidth: jawWidth.value,
        jawHeight: jawHeight.value,
        lipThickness: lipThickness.value,
        chinLowering: chinLowering.value,
        chinLength: chinLength.value,
        chinWidth: chinWidth.value,
        chinCleft: chinCleft.value,
        neckThickness: neckThickness.value,
        beardStyle: beardStyle.value,
        beardColor: beardColor.value,
        beardSecondaryColor: beardSecondaryColor.value,
        beardOpacity: beardOpacity.value,
        ageingStyle: ageingStyle.value,
        ageingOpacity: ageingOpacity.value,
        makeupStyle: makeupStyle.value,
        makeupPrimaryColor: makeupPrimaryColor.value,
        makeupSecondaryColor: makeupSecondaryColor.value,
        makeupOpacity: makeupOpacity.value,
        blushStyle: blushStyle.value,
        blushColor: blushColor.value,
        blushOpacity: blushOpacity.value,
        complexionStyle: complexionStyle.value,
        complexionOpacity: complexionOpacity.value,
        sunDamageStyle: sunDamageStyle.value,
        sunDamageOpacity: sunDamageOpacity.value,
        lipstickStyle: lipstickStyle.value,
        lipstickColor: lipstickColor.value,
        lipstickOpacity: lipstickOpacity.value,
        molesFrecklesStyle: molesFrecklesStyle.value,
        molesFrecklesOpacity: molesFrecklesOpacity.value,
        chestHairStyle: chestHairStyle.value,
        chestHairColor: chestHairColor.value,
        chestHairOpacity: chestHairOpacity.value,
        bodyBlemishesStyle: bodyBlemishesStyle.value,
        bodyBlemishesOpacity: bodyBlemishesOpacity.value,
      },
      clothing: {
        maskDrawable: maskDrawable.value,
        maskTexture: maskTexture.value,
        torsoDrawable: torsoDrawable.value,
        torsoTexture: torsoTexture.value,
        undershirtDrawable: undershirtDrawable.value,
        undershirtTexture: undershirtTexture.value,
        armsDrawable: armsDrawable.value,
        armsTexture: armsTexture.value,
        jacketDrawable: jacketDrawable.value,
        jacketTexture: jacketTexture.value,
        bodyArmorDrawable: bodyArmorDrawable.value,
        bodyArmorTexture: bodyArmorTexture.value,
        decalsDrawable: decalsDrawable.value,
        decalsTexture: decalsTexture.value,
        pantsDrawable: pantsDrawable.value,
        pantsTexture: pantsTexture.value,
        shoesDrawable: shoesDrawable.value,
        shoesTexture: shoesTexture.value,
        backpackDrawable: backpackDrawable.value,
        backpackTexture: backpackTexture.value,
      },
      accessories: {
        hatDrawable: hatDrawable.value,
        hatTexture: hatTexture.value,
        glassesDrawable: glassesDrawable.value,
        glassesTexture: glassesTexture.value,
        earringsDrawable: earringsDrawable.value,
        earringsTexture: earringsTexture.value,
        watchDrawable: watchDrawable.value,
        watchTexture: watchTexture.value,
        braceletDrawable: braceletDrawable.value,
        braceletTexture: braceletTexture.value,
        neckAccessoryDrawable: neckAccessoryDrawable.value,
        neckAccessoryTexture: neckAccessoryTexture.value,
      },
      tattoos: {
        headTattooCollection: headTattooCollection.value,
        headTattooHash: headTattooHash.value,
        neckTattooCollection: neckTattooCollection.value,
        neckTattooHash: neckTattooHash.value,
        torsoTattooCollection: torsoTattooCollection.value,
        torsoTattooHash: torsoTattooHash.value,
        backTattooCollection: backTattooCollection.value,
        backTattooHash: backTattooHash.value,
        leftArmTattooCollection: leftArmTattooCollection.value,
        leftArmTattooHash: leftArmTattooHash.value,
        rightArmTattooCollection: rightArmTattooCollection.value,
        rightArmTattooHash: rightArmTattooHash.value,
        leftLegTattooCollection: leftLegTattooCollection.value,
        leftLegTattooHash: leftLegTattooHash.value,
        rightLegTattooCollection: rightLegTattooCollection.value,
        rightLegTattooHash: rightLegTattooHash.value,
      },
    }
  }

  // Actions
  const setAppearanceData = (data: AppearanceData) => {
    selectedPed.value = data.ped.selectedPed
    selectedFather.value = data.heritage.father
    selectedMother.value = data.heritage.mother
    faceResemblance.value = data.heritage.faceResemblance
    skinResemblance.value = data.heritage.skinResemblance
    setPhysicalCustomization(data.physical)
    setClothing(data.clothing)
    setAccessories(data.accessories)
    setTattoos(data.tattoos)
  }

  const submitAppearance = () => {
    isAppearanceComplete.value = true
    return getAppearanceData()
  }

  const resetAppearance = () => {
    selectedPed.value = null
    selectedFather.value = 0
    selectedMother.value = 0
    faceResemblance.value = 0.5
    skinResemblance.value = 0.5
    hairStyle.value = 0
    hairColor.value = 0
    hairHighlight.value = 0
    eyeOpening.value = 0
    eyeColor.value = 0
    eyebrowHeight.value = 0
    eyebrowDepth.value = 0
    eyebrowsStyle.value = 0
    eyebrowsColor.value = 0
    eyebrowsOpacity.value = 1
    noseWidth.value = 0
    noseHeight.value = 0
    noseLength.value = 0
    noseBridge.value = 0
    noseBridgeTwist.value = 0
    noseTipHeight.value = 0
    cheekBoneHeight.value = 0
    cheekBoneWidth.value = 0
    cheekWidth.value = 0
    jawWidth.value = 0
    jawHeight.value = 0
    lipThickness.value = 0
    chinLowering.value = 0
    chinLength.value = 0
    chinWidth.value = 0
    chinCleft.value = 0
    neckThickness.value = 0
    beardStyle.value = 0
    beardColor.value = 0
    beardSecondaryColor.value = 0
    beardOpacity.value = 1
    ageingStyle.value = 0
    ageingOpacity.value = 0
    makeupStyle.value = 0
    makeupPrimaryColor.value = 0
    makeupSecondaryColor.value = 0
    makeupOpacity.value = 0
    blushStyle.value = 0
    blushColor.value = 0
    blushOpacity.value = 0
    complexionStyle.value = 0
    complexionOpacity.value = 0
    sunDamageStyle.value = 0
    sunDamageOpacity.value = 0
    lipstickStyle.value = 0
    lipstickColor.value = 0
    lipstickOpacity.value = 0
    molesFrecklesStyle.value = 0
    molesFrecklesOpacity.value = 0
    chestHairStyle.value = 0
    chestHairColor.value = 0
    chestHairOpacity.value = 0
    bodyBlemishesStyle.value = 0
    bodyBlemishesOpacity.value = 0
    maskDrawable.value = 0
    maskTexture.value = 0
    torsoDrawable.value = 0
    torsoTexture.value = 0
    undershirtDrawable.value = 0
    undershirtTexture.value = 0
    armsDrawable.value = 0
    armsTexture.value = 0
    jacketDrawable.value = 0
    jacketTexture.value = 0
    bodyArmorDrawable.value = 0
    bodyArmorTexture.value = 0
    decalsDrawable.value = 0
    decalsTexture.value = 0
    pantsDrawable.value = 0
    pantsTexture.value = 0
    shoesDrawable.value = 0
    shoesTexture.value = 0
    backpackDrawable.value = 0
    backpackTexture.value = 0
    hatDrawable.value = 0
    hatTexture.value = 0
    glassesDrawable.value = 0
    glassesTexture.value = 0
    earringsDrawable.value = 0
    earringsTexture.value = 0
    watchDrawable.value = 0
    watchTexture.value = 0
    braceletDrawable.value = 0
    braceletTexture.value = 0
    neckAccessoryDrawable.value = 0
    neckAccessoryTexture.value = 0
    headTattooCollection.value = 0
    headTattooHash.value = 0
    neckTattooCollection.value = 0
    neckTattooHash.value = 0
    torsoTattooCollection.value = 0
    torsoTattooHash.value = 0
    backTattooCollection.value = 0
    backTattooHash.value = 0
    leftArmTattooCollection.value = 0
    leftArmTattooHash.value = 0
    rightArmTattooCollection.value = 0
    rightArmTattooHash.value = 0
    leftLegTattooCollection.value = 0
    leftLegTattooHash.value = 0
    rightLegTattooCollection.value = 0
    rightLegTattooHash.value = 0
    isAppearanceComplete.value = false
  }

  return {
    // State - Ped
    selectedPed,
    // State - Heritage
    selectedFather,
    selectedMother,
    faceResemblance,
    skinResemblance,
    // State - Physical
    hairStyle,
    hairColor,
    hairHighlight,
    eyeOpening,
    eyeColor,
    eyebrowHeight,
    eyebrowDepth,
    eyebrowsStyle,
    eyebrowsColor,
    eyebrowsOpacity,
    noseWidth,
    noseHeight,
    noseLength,
    noseBridge,
    noseBridgeTwist,
    noseTipHeight,
    cheekBoneHeight,
    cheekBoneWidth,
    cheekWidth,
    jawWidth,
    jawHeight,
    lipThickness,
    chinLowering,
    chinLength,
    chinWidth,
    chinCleft,
    neckThickness,
    beardStyle,
    beardColor,
    beardSecondaryColor,
    beardOpacity,
    ageingStyle,
    ageingOpacity,
    makeupStyle,
    makeupPrimaryColor,
    makeupSecondaryColor,
    makeupOpacity,
    blushStyle,
    blushColor,
    blushOpacity,
    complexionStyle,
    complexionOpacity,
    sunDamageStyle,
    sunDamageOpacity,
    lipstickStyle,
    lipstickColor,
    lipstickOpacity,
    molesFrecklesStyle,
    molesFrecklesOpacity,
    chestHairStyle,
    chestHairColor,
    chestHairOpacity,
    bodyBlemishesStyle,
    bodyBlemishesOpacity,
    // State - Clothing
    maskDrawable,
    maskTexture,
    torsoDrawable,
    torsoTexture,
    undershirtDrawable,
    undershirtTexture,
    armsDrawable,
    armsTexture,
    jacketDrawable,
    jacketTexture,
    bodyArmorDrawable,
    bodyArmorTexture,
    decalsDrawable,
    decalsTexture,
    pantsDrawable,
    pantsTexture,
    shoesDrawable,
    shoesTexture,
    backpackDrawable,
    backpackTexture,
    // State - Accessories
    hatDrawable,
    hatTexture,
    glassesDrawable,
    glassesTexture,
    earringsDrawable,
    earringsTexture,
    watchDrawable,
    watchTexture,
    braceletDrawable,
    braceletTexture,
    neckAccessoryDrawable,
    neckAccessoryTexture,
    // State - Tattoos
    headTattooCollection,
    headTattooHash,
    neckTattooCollection,
    neckTattooHash,
    torsoTattooCollection,
    torsoTattooHash,
    backTattooCollection,
    backTattooHash,
    leftArmTattooCollection,
    leftArmTattooHash,
    rightArmTattooCollection,
    rightArmTattooHash,
    leftLegTattooCollection,
    leftLegTattooHash,
    rightLegTattooCollection,
    rightLegTattooHash,
    isAppearanceComplete,
    // Setters - Ped & Heritage
    setSelectedPed,
    setSelectedFather,
    setSelectedMother,
    setFaceResemblance,
    setSkinResemblance,
    // Setters - Physical (Global)
    setPhysicalCustomization,
    // Setters - Physical (Per Section)
    setHairSection,
    setEyesSection,
    setEyebrowsSection,
    setNoseSection,
    setCheeksSection,
    setBeardSection,
    setJawSection,
    setLipsSection,
    setChinSection,
    setNeckSection,
    setAgeingSection,
    setMakeupSection,
    setBlushSection,
    setComplexionSection,
    setSunDamageSection,
    setMolesFrecklesSection,
    setChestHairSection,
    setBodyBlemishesSection,
    // Setters - Clothing (Global)
    setClothing,
    // Setters - Clothing (Per Section)
    setMaskSection,
    setTorsoSection,
    setUndershirtSection,
    setArmsSection,
    setJacketSection,
    setBodyArmorSection,
    setDecalsSection,
    setPantsSection,
    setShoesSection,
    setBackpackSection,
    // Setters - Accessories (Global)
    setAccessories,
    // Setters - Accessories (Per Section)
    setHatSection,
    setGlassesSection,
    setEarringsSection,
    setWatchSection,
    setBraceletSection,
    setNeckAccessorySection,
    // Setters - Tattoos (Global)
    setTattoos,
    // Setters - Tattoos (Per Section)
    setHeadTattooSection,
    setNeckTattooSection,
    setTorsoTattooSection,
    setBackTattooSection,
    setLeftArmTattooSection,
    setRightArmTattooSection,
    setLeftLegTattooSection,
    setRightLegTattooSection,
    // Getters
    getAppearanceData,
    setAppearanceData,
    submitAppearance,
    resetAppearance,
  }
})
