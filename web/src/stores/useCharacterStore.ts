import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { useIdentityCreationStore, type IdentityData } from '@/stores/useIdentityCreationStore'
import { useAppearanceStore, type AppearanceData } from '@/stores/useAppearanceStore'

export type CharacterAppearance = {
  ped?: {
    selectedPed: string | null
  }
  heritage?: {
    father: number
    mother: number
    resemblance: number
    skinTone: number
  }
  physical?: {
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
  clothing?: {
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
  accessories?: {
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
  tattoos?: {
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

export type CharacterData = {
  identity: IdentityData | null
  appearance: CharacterAppearance | null
}

export const useCharacterStore = defineStore('character', () => {
  const identity = ref<IdentityData | null>(null)
  const appearance = ref<CharacterAppearance | null>(null)
  const isNewCharacter = ref(false)
  const selectedSlot = ref<number | null>(null)

  const isIdentityComplete = computed(() => identity.value !== null)
  const isAppearanceComplete = computed(() => appearance.value !== null)
  const isCharacterComplete = computed(
    () => isIdentityComplete.value && isAppearanceComplete.value,
  )

  const startNewCharacter = (slotId: number) => {
    identity.value = null
    appearance.value = null
    isNewCharacter.value = true
    selectedSlot.value = slotId
  }

  const loadExistingCharacter = (slotId: number, data: CharacterData) => {
    identity.value = data.identity
    appearance.value = data.appearance
    isNewCharacter.value = false
    selectedSlot.value = slotId
  }

  const setIdentity = (identityData: IdentityData) => {
    identity.value = identityData
  }

  const setAppearance = (appearanceData: CharacterAppearance) => {
    appearance.value = appearanceData
  }

  const getCharacterData = (): CharacterData => {
    return {
      identity: identity.value,
      appearance: appearance.value,
    }
  }

  const reset = () => {
    identity.value = null
    appearance.value = null
    isNewCharacter.value = false
    selectedSlot.value = null
  }

  const setPedSelection = (pedData: { selectedPed: string | null }) => {
    appearance.value = {
      ...appearance.value,
      ped: pedData,
    }
  }

  const setHeritage = (heritageData: {
    father: number
    mother: number
    faceResemblance: number
    skinResemblance: number
  }) => {
    appearance.value = {
      ...appearance.value,
      heritage: {
        father: heritageData.father,
        mother: heritageData.mother,
        resemblance: heritageData.faceResemblance,
        skinTone: heritageData.skinResemblance,
      },
    }
  }

  const setPhysicalCustomization = (physicalData: AppearanceData['physical']) => {
    appearance.value = {
      ...appearance.value,
      physical: physicalData,
    }
  }

  const setClothing = (clothingData: AppearanceData['clothing']) => {
    appearance.value = {
      ...appearance.value,
      clothing: clothingData,
    }
  }

  const setAccessories = (accessoriesData: AppearanceData['accessories']) => {
    appearance.value = {
      ...appearance.value,
      accessories: accessoriesData,
    }
  }

  const setTattoos = (tattoosData: AppearanceData['tattoos']) => {
    appearance.value = {
      ...appearance.value,
      tattoos: tattoosData,
    }
  }

  const resetAll = () => {
    reset()

    const identityStore = useIdentityCreationStore()
    identityStore.resetIdentity()

    const appearanceStore = useAppearanceStore()
    appearanceStore.resetAppearance()
  }

  const validateIntegrity = (): boolean => {
    const identityStore = useIdentityCreationStore()

    if (!identity.value || !identityStore.isIdentityComplete) {
      return true
    }

    const storedIdentity = identityStore.getIdentityData()

    const isValid =
      identity.value.firstName === storedIdentity.firstName &&
      identity.value.lastName === storedIdentity.lastName &&
      identity.value.dateOfBirth === storedIdentity.dateOfBirth &&
      identity.value.gender === storedIdentity.gender &&
      identity.value.nationality === storedIdentity.nationality &&
      identity.value.height === storedIdentity.height

    if (!isValid) {
      console.error('❌ Data integrity check failed!')
      console.error('Character Store:', identity.value)
      console.error('Identity Store:', storedIdentity)
    }

    return isValid
  }

  return {
    identity,
    appearance,
    isNewCharacter,
    selectedSlot,
    isIdentityComplete,
    isAppearanceComplete,
    isCharacterComplete,
    startNewCharacter,
    loadExistingCharacter,
    setIdentity,
    setAppearance,
    setPedSelection,
    setHeritage,
    setPhysicalCustomization,
    setClothing,
    setAccessories,
    setTattoos,
    getCharacterData,
    reset,
    resetAll,
    validateIntegrity,
  }
})
