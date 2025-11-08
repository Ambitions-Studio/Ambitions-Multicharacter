<script setup lang="ts">
import { ref, watch } from 'vue'
import { useI18n } from 'vue-i18n'
import { VBtn } from 'vuetify/components'
import { useAppearanceStore } from '@/stores/useAppearanceStore'
import { useCharacterStore } from '@/stores/useCharacterStore'
import PhysicalCustomizationNavigation from '@/components/characterCreation/layout/PhysicalCustomizationNavigation.vue'
import HairSection from '@/components/characterCreation/physicalCustomization/HairSection.vue'
import EyesSection from '@/components/characterCreation/physicalCustomization/EyesSection.vue'
import EyebrowsSection from '@/components/characterCreation/physicalCustomization/EyebrowsSection.vue'
import NoseSection from '@/components/characterCreation/physicalCustomization/NoseSection.vue'
import CheeksSection from '@/components/characterCreation/physicalCustomization/CheeksSection.vue'
import JawSection from '@/components/characterCreation/physicalCustomization/JawSection.vue'
import BeardSection from '@/components/characterCreation/physicalCustomization/BeardSection.vue'
import AgeingSection from '@/components/characterCreation/physicalCustomization/AgeingSection.vue'
import MakeupSection from '@/components/characterCreation/physicalCustomization/MakeupSection.vue'
import BlushSection from '@/components/characterCreation/physicalCustomization/BlushSection.vue'
import ComplexionSection from '@/components/characterCreation/physicalCustomization/ComplexionSection.vue'
import SunDamageSection from '@/components/characterCreation/physicalCustomization/SunDamageSection.vue'
import LipsSection from '@/components/characterCreation/physicalCustomization/LipsSection.vue'
import ChinSection from '@/components/characterCreation/physicalCustomization/ChinSection.vue'
import NeckSection from '@/components/characterCreation/physicalCustomization/NeckSection.vue'
import MolesFrecklesSection from '@/components/characterCreation/physicalCustomization/MolesFrecklesSection.vue'
import ChestHairSection from '@/components/characterCreation/physicalCustomization/ChestHairSection.vue'
import BodyBlemishesSection from '@/components/characterCreation/physicalCustomization/BodyBlemishesSection.vue'

const { t } = useI18n()
const appearanceStore = useAppearanceStore()
const characterStore = useCharacterStore()

const currentCategory = ref(0)
const previousCategory = ref(0)

const physicalCategories = ref([
  { titleKey: 'characterCreation.physicalCustomization.categories.hair', key: 'hair' },
  { titleKey: 'characterCreation.physicalCustomization.categories.eyes', key: 'eyes' },
  { titleKey: 'characterCreation.physicalCustomization.categories.eyebrows', key: 'eyebrows' },
  { titleKey: 'characterCreation.physicalCustomization.categories.nose', key: 'nose' },
  { titleKey: 'characterCreation.physicalCustomization.categories.cheeks', key: 'cheeks' },
  { titleKey: 'characterCreation.physicalCustomization.categories.beard', key: 'beard' },
  { titleKey: 'characterCreation.physicalCustomization.categories.jaw', key: 'jaw' },
  { titleKey: 'characterCreation.physicalCustomization.categories.lips', key: 'lips' },
  { titleKey: 'characterCreation.physicalCustomization.categories.chin', key: 'chin' },
  { titleKey: 'characterCreation.physicalCustomization.categories.neck', key: 'neck' },
  { titleKey: 'characterCreation.physicalCustomization.categories.ageing', key: 'ageing' },
  { titleKey: 'characterCreation.physicalCustomization.categories.makeup', key: 'makeup' },
  { titleKey: 'characterCreation.physicalCustomization.categories.blush', key: 'blush' },
  { titleKey: 'characterCreation.physicalCustomization.categories.complexion', key: 'complexion' },
  { titleKey: 'characterCreation.physicalCustomization.categories.sunDamage', key: 'sunDamage' },
  { titleKey: 'characterCreation.physicalCustomization.categories.molesFreckles', key: 'molesFreckles' },
  { titleKey: 'characterCreation.physicalCustomization.categories.chestHair', key: 'chestHair' },
  { titleKey: 'characterCreation.physicalCustomization.categories.bodyBlemishes', key: 'bodyBlemishes' },
])

const props = withDefaults(
  defineProps<{
    hairStyle?: number
    hairColor?: number
    hairHighlight?: number
    eyeOpening?: number
    eyeColor?: number
    eyebrowHeight?: number
    eyebrowDepth?: number
    eyebrowsStyle?: number
    eyebrowsColor?: number
    eyebrowsOpacity?: number
    noseWidth?: number
    noseHeight?: number
    noseLength?: number
    noseBridge?: number
    noseBridgeTwist?: number
    noseTipHeight?: number
    cheekBoneHeight?: number
    cheekBoneWidth?: number
    cheekWidth?: number
    jawWidth?: number
    jawHeight?: number
    lipThickness?: number
    chinLowering?: number
    chinLength?: number
    chinWidth?: number
    chinCleft?: number
    neckThickness?: number
    beardStyle?: number
    beardColor?: number
    beardSecondaryColor?: number
    beardOpacity?: number
    ageingStyle?: number
    ageingOpacity?: number
    makeupStyle?: number
    makeupPrimaryColor?: number
    makeupSecondaryColor?: number
    makeupOpacity?: number
    blushStyle?: number
    blushColor?: number
    blushOpacity?: number
    complexionStyle?: number
    complexionOpacity?: number
    sunDamageStyle?: number
    sunDamageOpacity?: number
    lipstickStyle?: number
    lipstickColor?: number
    lipstickOpacity?: number
    molesFrecklesStyle?: number
    molesFrecklesOpacity?: number
    chestHairStyle?: number
    chestHairColor?: number
    chestHairOpacity?: number
    bodyBlemishesStyle?: number
    bodyBlemishesOpacity?: number
  }>(),
  {
    hairStyle: 0,
    hairColor: 0,
    hairHighlight: 0,
    eyeOpening: 0,
    eyeColor: 0,
    eyebrowHeight: 0,
    eyebrowDepth: 0,
    eyebrowsStyle: 0,
    eyebrowsColor: 0,
    eyebrowsOpacity: 1,
    noseWidth: 0,
    noseHeight: 0,
    noseLength: 0,
    noseBridge: 0,
    noseBridgeTwist: 0,
    noseTipHeight: 0,
    cheekBoneHeight: 0,
    cheekBoneWidth: 0,
    cheekWidth: 0,
    jawWidth: 0,
    jawHeight: 0,
    lipThickness: 0,
    chinLowering: 0,
    chinLength: 0,
    chinWidth: 0,
    chinCleft: 0,
    neckThickness: 0,
    beardStyle: 0,
    beardColor: 0,
    beardSecondaryColor: 0,
    beardOpacity: 1,
    ageingStyle: 0,
    ageingOpacity: 0,
    makeupStyle: 0,
    makeupPrimaryColor: 0,
    makeupSecondaryColor: 0,
    makeupOpacity: 0,
    blushStyle: 0,
    blushColor: 0,
    blushOpacity: 0,
    complexionStyle: 0,
    complexionOpacity: 0,
    sunDamageStyle: 0,
    sunDamageOpacity: 0,
    lipstickStyle: 0,
    lipstickColor: 0,
    lipstickOpacity: 0,
    molesFrecklesStyle: 0,
    molesFrecklesOpacity: 0,
    chestHairStyle: 0,
    chestHairColor: 0,
    chestHairOpacity: 0,
    bodyBlemishesStyle: 0,
    bodyBlemishesOpacity: 0,
  },
)

const emit = defineEmits<{
  'update:hairStyle': [value: number]
  'update:hairColor': [value: number]
  'update:hairHighlight': [value: number]
  'update:eyeOpening': [value: number]
  'update:eyeColor': [value: number]
  'update:eyebrowHeight': [value: number]
  'update:eyebrowDepth': [value: number]
  'update:eyebrowsStyle': [value: number]
  'update:eyebrowsColor': [value: number]
  'update:eyebrowsOpacity': [value: number]
  'update:noseWidth': [value: number]
  'update:noseHeight': [value: number]
  'update:noseLength': [value: number]
  'update:noseBridge': [value: number]
  'update:noseBridgeTwist': [value: number]
  'update:noseTipHeight': [value: number]
  'update:cheekBoneHeight': [value: number]
  'update:cheekBoneWidth': [value: number]
  'update:cheekWidth': [value: number]
  'update:jawWidth': [value: number]
  'update:jawHeight': [value: number]
  'update:lipThickness': [value: number]
  'update:chinLowering': [value: number]
  'update:chinLength': [value: number]
  'update:chinWidth': [value: number]
  'update:chinCleft': [value: number]
  'update:neckThickness': [value: number]
  'update:beardStyle': [value: number]
  'update:beardColor': [value: number]
  'update:beardSecondaryColor': [value: number]
  'update:beardOpacity': [value: number]
  'update:ageingStyle': [value: number]
  'update:ageingOpacity': [value: number]
  'update:makeupStyle': [value: number]
  'update:makeupPrimaryColor': [value: number]
  'update:makeupSecondaryColor': [value: number]
  'update:makeupOpacity': [value: number]
  'update:blushStyle': [value: number]
  'update:blushColor': [value: number]
  'update:blushOpacity': [value: number]
  'update:complexionStyle': [value: number]
  'update:complexionOpacity': [value: number]
  'update:sunDamageStyle': [value: number]
  'update:sunDamageOpacity': [value: number]
  'update:lipstickStyle': [value: number]
  'update:lipstickColor': [value: number]
  'update:lipstickOpacity': [value: number]
  'update:molesFrecklesStyle': [value: number]
  'update:molesFrecklesOpacity': [value: number]
  'update:chestHairStyle': [value: number]
  'update:chestHairColor': [value: number]
  'update:chestHairOpacity': [value: number]
  'update:bodyBlemishesStyle': [value: number]
  'update:bodyBlemishesOpacity': [value: number]
  continue: []
}>()

const localHairStyle = ref(appearanceStore.hairStyle ?? props.hairStyle)
const localHairColor = ref(appearanceStore.hairColor ?? props.hairColor)
const localHairHighlight = ref(appearanceStore.hairHighlight ?? props.hairHighlight)
const localEyeOpening = ref(appearanceStore.eyeOpening ?? props.eyeOpening)
const localEyeColor = ref(appearanceStore.eyeColor ?? props.eyeColor)
const localEyebrowHeight = ref(appearanceStore.eyebrowHeight ?? props.eyebrowHeight)
const localEyebrowDepth = ref(appearanceStore.eyebrowDepth ?? props.eyebrowDepth)
const localEyebrowsStyle = ref(appearanceStore.eyebrowsStyle ?? props.eyebrowsStyle)
const localEyebrowsColor = ref(appearanceStore.eyebrowsColor ?? props.eyebrowsColor)
const localEyebrowsOpacity = ref(appearanceStore.eyebrowsOpacity ?? props.eyebrowsOpacity)
const localNoseWidth = ref(appearanceStore.noseWidth ?? props.noseWidth)
const localNoseHeight = ref(appearanceStore.noseHeight ?? props.noseHeight)
const localNoseLength = ref(appearanceStore.noseLength ?? props.noseLength)
const localNoseBridge = ref(appearanceStore.noseBridge ?? props.noseBridge)
const localNoseBridgeTwist = ref(appearanceStore.noseBridgeTwist ?? props.noseBridgeTwist)
const localNoseTipHeight = ref(appearanceStore.noseTipHeight ?? props.noseTipHeight)
const localCheekBoneHeight = ref(appearanceStore.cheekBoneHeight ?? props.cheekBoneHeight)
const localCheekBoneWidth = ref(appearanceStore.cheekBoneWidth ?? props.cheekBoneWidth)
const localCheekWidth = ref(appearanceStore.cheekWidth ?? props.cheekWidth)
const localJawWidth = ref(appearanceStore.jawWidth ?? props.jawWidth)
const localJawHeight = ref(appearanceStore.jawHeight ?? props.jawHeight)
const localLipThickness = ref(appearanceStore.lipThickness ?? props.lipThickness)
const localChinLowering = ref(appearanceStore.chinLowering ?? props.chinLowering)
const localChinLength = ref(appearanceStore.chinLength ?? props.chinLength)
const localChinWidth = ref(appearanceStore.chinWidth ?? props.chinWidth)
const localChinCleft = ref(appearanceStore.chinCleft ?? props.chinCleft)
const localNeckThickness = ref(appearanceStore.neckThickness ?? props.neckThickness)
const localBeardStyle = ref(appearanceStore.beardStyle ?? props.beardStyle)
const localBeardColor = ref(appearanceStore.beardColor ?? props.beardColor)
const localBeardSecondaryColor = ref(appearanceStore.beardSecondaryColor ?? props.beardSecondaryColor)
const localBeardOpacity = ref(appearanceStore.beardOpacity ?? props.beardOpacity)
const localAgeingStyle = ref(appearanceStore.ageingStyle ?? props.ageingStyle)
const localAgeingOpacity = ref(appearanceStore.ageingOpacity ?? props.ageingOpacity)
const localMakeupStyle = ref(appearanceStore.makeupStyle ?? props.makeupStyle)
const localMakeupPrimaryColor = ref(appearanceStore.makeupPrimaryColor ?? props.makeupPrimaryColor)
const localMakeupSecondaryColor = ref(appearanceStore.makeupSecondaryColor ?? props.makeupSecondaryColor)
const localMakeupOpacity = ref(appearanceStore.makeupOpacity ?? props.makeupOpacity)
const localBlushStyle = ref(appearanceStore.blushStyle ?? props.blushStyle)
const localBlushColor = ref(appearanceStore.blushColor ?? props.blushColor)
const localBlushOpacity = ref(appearanceStore.blushOpacity ?? props.blushOpacity)
const localComplexionStyle = ref(appearanceStore.complexionStyle ?? props.complexionStyle)
const localComplexionOpacity = ref(appearanceStore.complexionOpacity ?? props.complexionOpacity)
const localSunDamageStyle = ref(appearanceStore.sunDamageStyle ?? props.sunDamageStyle)
const localSunDamageOpacity = ref(appearanceStore.sunDamageOpacity ?? props.sunDamageOpacity)
const localLipstickStyle = ref(appearanceStore.lipstickStyle ?? props.lipstickStyle)
const localLipstickColor = ref(appearanceStore.lipstickColor ?? props.lipstickColor)
const localLipstickOpacity = ref(appearanceStore.lipstickOpacity ?? props.lipstickOpacity)
const localMolesFrecklesStyle = ref(appearanceStore.molesFrecklesStyle ?? props.molesFrecklesStyle)
const localMolesFrecklesOpacity = ref(appearanceStore.molesFrecklesOpacity ?? props.molesFrecklesOpacity)
const localChestHairStyle = ref(appearanceStore.chestHairStyle ?? props.chestHairStyle)
const localChestHairColor = ref(appearanceStore.chestHairColor ?? props.chestHairColor)
const localChestHairOpacity = ref(appearanceStore.chestHairOpacity ?? props.chestHairOpacity)
const localBodyBlemishesStyle = ref(appearanceStore.bodyBlemishesStyle ?? props.bodyBlemishesStyle)
const localBodyBlemishesOpacity = ref(appearanceStore.bodyBlemishesOpacity ?? props.bodyBlemishesOpacity)

const saveSectionData = (categoryIndex: number) => {
  switch (categoryIndex) {
    case 0: // Hair
      appearanceStore.setHairSection({
        hairStyle: localHairStyle.value,
        hairColor: localHairColor.value,
        hairHighlight: localHairHighlight.value,
      })
      break
    case 1: // Eyes
      appearanceStore.setEyesSection({
        eyeOpening: localEyeOpening.value,
        eyeColor: localEyeColor.value,
      })
      break
    case 2: // Eyebrows
      appearanceStore.setEyebrowsSection({
        eyebrowHeight: localEyebrowHeight.value,
        eyebrowDepth: localEyebrowDepth.value,
        eyebrowsStyle: localEyebrowsStyle.value,
        eyebrowsColor: localEyebrowsColor.value,
        eyebrowsOpacity: localEyebrowsOpacity.value,
      })
      break
    case 3: // Nose
      appearanceStore.setNoseSection({
        noseWidth: localNoseWidth.value,
        noseHeight: localNoseHeight.value,
        noseLength: localNoseLength.value,
        noseBridge: localNoseBridge.value,
        noseBridgeTwist: localNoseBridgeTwist.value,
        noseTipHeight: localNoseTipHeight.value,
      })
      break
    case 4: // Cheeks
      appearanceStore.setCheeksSection({
        cheekBoneHeight: localCheekBoneHeight.value,
        cheekBoneWidth: localCheekBoneWidth.value,
        cheekWidth: localCheekWidth.value,
      })
      break
    case 5: // Beard
      appearanceStore.setBeardSection({
        beardStyle: localBeardStyle.value,
        beardColor: localBeardColor.value,
        beardSecondaryColor: localBeardSecondaryColor.value,
        beardOpacity: localBeardOpacity.value,
      })
      break
    case 6: // Jaw
      appearanceStore.setJawSection({
        jawWidth: localJawWidth.value,
        jawHeight: localJawHeight.value,
      })
      break
    case 7: // Lips
      appearanceStore.setLipsSection({
        lipThickness: localLipThickness.value,
        lipstickStyle: localLipstickStyle.value,
        lipstickColor: localLipstickColor.value,
        lipstickOpacity: localLipstickOpacity.value,
      })
      break
    case 8: // Chin
      appearanceStore.setChinSection({
        chinLowering: localChinLowering.value,
        chinLength: localChinLength.value,
        chinWidth: localChinWidth.value,
        chinCleft: localChinCleft.value,
      })
      break
    case 9: // Neck
      appearanceStore.setNeckSection({
        neckThickness: localNeckThickness.value,
      })
      break
    case 10: // Ageing
      appearanceStore.setAgeingSection({
        ageingStyle: localAgeingStyle.value,
        ageingOpacity: localAgeingOpacity.value,
      })
      break
    case 11: // Makeup
      appearanceStore.setMakeupSection({
        makeupStyle: localMakeupStyle.value,
        makeupPrimaryColor: localMakeupPrimaryColor.value,
        makeupSecondaryColor: localMakeupSecondaryColor.value,
        makeupOpacity: localMakeupOpacity.value,
      })
      break
    case 12: // Blush
      appearanceStore.setBlushSection({
        blushStyle: localBlushStyle.value,
        blushColor: localBlushColor.value,
        blushOpacity: localBlushOpacity.value,
      })
      break
    case 13: // Complexion
      appearanceStore.setComplexionSection({
        complexionStyle: localComplexionStyle.value,
        complexionOpacity: localComplexionOpacity.value,
      })
      break
    case 14: // Sun Damage
      appearanceStore.setSunDamageSection({
        sunDamageStyle: localSunDamageStyle.value,
        sunDamageOpacity: localSunDamageOpacity.value,
      })
      break
    case 15: // Moles & Freckles
      appearanceStore.setMolesFrecklesSection({
        molesFrecklesStyle: localMolesFrecklesStyle.value,
        molesFrecklesOpacity: localMolesFrecklesOpacity.value,
      })
      break
    case 16: // Chest Hair
      appearanceStore.setChestHairSection({
        chestHairStyle: localChestHairStyle.value,
        chestHairColor: localChestHairColor.value,
        chestHairOpacity: localChestHairOpacity.value,
      })
      break
    case 17: // Body Blemishes
      appearanceStore.setBodyBlemishesSection({
        bodyBlemishesStyle: localBodyBlemishesStyle.value,
        bodyBlemishesOpacity: localBodyBlemishesOpacity.value,
      })
      break
  }
}

watch(currentCategory, (newCategory, oldCategory) => {
  saveSectionData(oldCategory)
  previousCategory.value = oldCategory
})

const handleContinue = () => {
  saveSectionData(currentCategory.value)

  const physicalData = {
    hairStyle: localHairStyle.value,
    hairColor: localHairColor.value,
    hairHighlight: localHairHighlight.value,
    eyeOpening: localEyeOpening.value,
    eyeColor: localEyeColor.value,
    eyebrowHeight: localEyebrowHeight.value,
    eyebrowDepth: localEyebrowDepth.value,
    eyebrowsStyle: localEyebrowsStyle.value,
    eyebrowsColor: localEyebrowsColor.value,
    eyebrowsOpacity: localEyebrowsOpacity.value,
    noseWidth: localNoseWidth.value,
    noseHeight: localNoseHeight.value,
    noseLength: localNoseLength.value,
    noseBridge: localNoseBridge.value,
    noseBridgeTwist: localNoseBridgeTwist.value,
    noseTipHeight: localNoseTipHeight.value,
    cheekBoneHeight: localCheekBoneHeight.value,
    cheekBoneWidth: localCheekBoneWidth.value,
    cheekWidth: localCheekWidth.value,
    jawWidth: localJawWidth.value,
    jawHeight: localJawHeight.value,
    lipThickness: localLipThickness.value,
    chinLowering: localChinLowering.value,
    chinLength: localChinLength.value,
    chinWidth: localChinWidth.value,
    chinCleft: localChinCleft.value,
    neckThickness: localNeckThickness.value,
    beardStyle: localBeardStyle.value,
    beardColor: localBeardColor.value,
    beardSecondaryColor: localBeardSecondaryColor.value,
    beardOpacity: localBeardOpacity.value,
    ageingStyle: localAgeingStyle.value,
    ageingOpacity: localAgeingOpacity.value,
    makeupStyle: localMakeupStyle.value,
    makeupPrimaryColor: localMakeupPrimaryColor.value,
    makeupSecondaryColor: localMakeupSecondaryColor.value,
    makeupOpacity: localMakeupOpacity.value,
    blushStyle: localBlushStyle.value,
    blushColor: localBlushColor.value,
    blushOpacity: localBlushOpacity.value,
    complexionStyle: localComplexionStyle.value,
    complexionOpacity: localComplexionOpacity.value,
    sunDamageStyle: localSunDamageStyle.value,
    sunDamageOpacity: localSunDamageOpacity.value,
    lipstickStyle: localLipstickStyle.value,
    lipstickColor: localLipstickColor.value,
    lipstickOpacity: localLipstickOpacity.value,
    molesFrecklesStyle: localMolesFrecklesStyle.value,
    molesFrecklesOpacity: localMolesFrecklesOpacity.value,
    chestHairStyle: localChestHairStyle.value,
    chestHairColor: localChestHairColor.value,
    chestHairOpacity: localChestHairOpacity.value,
    bodyBlemishesStyle: localBodyBlemishesStyle.value,
    bodyBlemishesOpacity: localBodyBlemishesOpacity.value,
  }

  appearanceStore.setPhysicalCustomization(physicalData)

  characterStore.setPhysicalCustomization(physicalData)

  emit('update:hairStyle', localHairStyle.value)
  emit('update:hairColor', localHairColor.value)
  emit('update:hairHighlight', localHairHighlight.value)
  emit('update:eyeOpening', localEyeOpening.value)
  emit('update:eyeColor', localEyeColor.value)
  emit('update:eyebrowHeight', localEyebrowHeight.value)
  emit('update:eyebrowDepth', localEyebrowDepth.value)
  emit('update:eyebrowsStyle', localEyebrowsStyle.value)
  emit('update:eyebrowsColor', localEyebrowsColor.value)
  emit('update:eyebrowsOpacity', localEyebrowsOpacity.value)
  emit('update:noseWidth', localNoseWidth.value)
  emit('update:noseHeight', localNoseHeight.value)
  emit('update:noseLength', localNoseLength.value)
  emit('update:noseBridge', localNoseBridge.value)
  emit('update:noseBridgeTwist', localNoseBridgeTwist.value)
  emit('update:noseTipHeight', localNoseTipHeight.value)
  emit('update:cheekBoneHeight', localCheekBoneHeight.value)
  emit('update:cheekBoneWidth', localCheekBoneWidth.value)
  emit('update:cheekWidth', localCheekWidth.value)
  emit('update:jawWidth', localJawWidth.value)
  emit('update:jawHeight', localJawHeight.value)
  emit('update:lipThickness', localLipThickness.value)
  emit('update:chinLowering', localChinLowering.value)
  emit('update:chinLength', localChinLength.value)
  emit('update:chinWidth', localChinWidth.value)
  emit('update:chinCleft', localChinCleft.value)
  emit('update:neckThickness', localNeckThickness.value)
  emit('update:beardStyle', localBeardStyle.value)
  emit('update:beardColor', localBeardColor.value)
  emit('update:beardSecondaryColor', localBeardSecondaryColor.value)
  emit('update:beardOpacity', localBeardOpacity.value)
  emit('update:ageingStyle', localAgeingStyle.value)
  emit('update:ageingOpacity', localAgeingOpacity.value)
  emit('update:makeupStyle', localMakeupStyle.value)
  emit('update:makeupPrimaryColor', localMakeupPrimaryColor.value)
  emit('update:makeupSecondaryColor', localMakeupSecondaryColor.value)
  emit('update:makeupOpacity', localMakeupOpacity.value)
  emit('update:blushStyle', localBlushStyle.value)
  emit('update:blushColor', localBlushColor.value)
  emit('update:blushOpacity', localBlushOpacity.value)
  emit('update:complexionStyle', localComplexionStyle.value)
  emit('update:complexionOpacity', localComplexionOpacity.value)
  emit('update:sunDamageStyle', localSunDamageStyle.value)
  emit('update:sunDamageOpacity', localSunDamageOpacity.value)
  emit('update:lipstickStyle', localLipstickStyle.value)
  emit('update:lipstickColor', localLipstickColor.value)
  emit('update:lipstickOpacity', localLipstickOpacity.value)
  emit('update:molesFrecklesStyle', localMolesFrecklesStyle.value)
  emit('update:molesFrecklesOpacity', localMolesFrecklesOpacity.value)
  emit('update:chestHairStyle', localChestHairStyle.value)
  emit('update:chestHairColor', localChestHairColor.value)
  emit('update:chestHairOpacity', localChestHairOpacity.value)
  emit('update:bodyBlemishesStyle', localBodyBlemishesStyle.value)
  emit('update:bodyBlemishesOpacity', localBodyBlemishesOpacity.value)

  emit('continue')
}
</script>
<template>
  <div class="space-y-6">
    <PhysicalCustomizationNavigation
      v-model="currentCategory"
      :categories="physicalCategories"
    />

    <div class="h-[60vh] overflow-y-scroll pr-2 pb-6">
      <div v-if="currentCategory === 0" class="space-y-6">
        <HairSection
          v-model:hair-style="localHairStyle"
          v-model:hair-color="localHairColor"
          v-model:hair-highlight="localHairHighlight"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 1" class="space-y-6">
        <EyesSection
          v-model:eye-opening="localEyeOpening"
          v-model:eye-color="localEyeColor"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 2" class="space-y-6">
        <EyebrowsSection
          v-model:eyebrow-height="localEyebrowHeight"
          v-model:eyebrow-depth="localEyebrowDepth"
          v-model:eyebrows-style="localEyebrowsStyle"
          v-model:eyebrows-color="localEyebrowsColor"
          v-model:eyebrows-opacity="localEyebrowsOpacity"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 3" class="space-y-6">
        <NoseSection
          v-model:nose-width="localNoseWidth"
          v-model:nose-height="localNoseHeight"
          v-model:nose-length="localNoseLength"
          v-model:nose-bridge="localNoseBridge"
          v-model:nose-bridge-twist="localNoseBridgeTwist"
          v-model:nose-tip-height="localNoseTipHeight"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 4" class="space-y-6">
        <CheeksSection
          v-model:cheek-bone-height="localCheekBoneHeight"
          v-model:cheek-bone-width="localCheekBoneWidth"
          v-model:cheek-width="localCheekWidth"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 5" class="space-y-6">
        <BeardSection
          v-model:beard-style="localBeardStyle"
          v-model:beard-color="localBeardColor"
          v-model:beard-secondary-color="localBeardSecondaryColor"
          v-model:beard-opacity="localBeardOpacity"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 6" class="space-y-6">
        <JawSection
          v-model:jaw-width="localJawWidth"
          v-model:jaw-height="localJawHeight"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 7" class="space-y-6">
        <LipsSection
          v-model:lip-thickness="localLipThickness"
          v-model:lipstick-style="localLipstickStyle"
          v-model:lipstick-color="localLipstickColor"
          v-model:lipstick-opacity="localLipstickOpacity"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 8" class="space-y-6">
        <ChinSection
          v-model:chin-lowering="localChinLowering"
          v-model:chin-length="localChinLength"
          v-model:chin-width="localChinWidth"
          v-model:chin-cleft="localChinCleft"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 9" class="space-y-6">
        <NeckSection
          v-model:neck-thickness="localNeckThickness"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 10" class="space-y-6">
        <AgeingSection
          v-model:ageing-style="localAgeingStyle"
          v-model:ageing-opacity="localAgeingOpacity"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 11" class="space-y-6">
        <MakeupSection
          v-model:makeup-style="localMakeupStyle"
          v-model:makeup-primary-color="localMakeupPrimaryColor"
          v-model:makeup-secondary-color="localMakeupSecondaryColor"
          v-model:makeup-opacity="localMakeupOpacity"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 12" class="space-y-6">
        <BlushSection
          v-model:blush-style="localBlushStyle"
          v-model:blush-color="localBlushColor"
          v-model:blush-opacity="localBlushOpacity"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 13" class="space-y-6">
        <ComplexionSection
          v-model:complexion-style="localComplexionStyle"
          v-model:complexion-opacity="localComplexionOpacity"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 14" class="space-y-6">
        <SunDamageSection
          v-model:sun-damage-style="localSunDamageStyle"
          v-model:sun-damage-opacity="localSunDamageOpacity"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 15" class="space-y-6">
        <MolesFrecklesSection
          v-model:moles-freckles-style="localMolesFrecklesStyle"
          v-model:moles-freckles-opacity="localMolesFrecklesOpacity"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 16" class="space-y-6">
        <ChestHairSection
          v-model:chest-hair-style="localChestHairStyle"
          v-model:chest-hair-color="localChestHairColor"
          v-model:chest-hair-opacity="localChestHairOpacity"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>

      <div v-if="currentCategory === 17" class="space-y-6">
        <BodyBlemishesSection
          v-model:body-blemishes-style="localBodyBlemishesStyle"
          v-model:body-blemishes-opacity="localBodyBlemishesOpacity"
        />

        <!-- Continue/Validate Button -->
        <div class="flex justify-end pr-6">
          <VBtn
            variant="outlined"
            size="large"
            class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
            elevation="0"
            @click="handleContinue"
          >
            <span class="text-base tracking-wide uppercase">
              {{ t('characterCreation.physicalCustomization.validateButton') }}
            </span>
          </VBtn>
        </div>
      </div>
    </div>
  </div>
</template>
