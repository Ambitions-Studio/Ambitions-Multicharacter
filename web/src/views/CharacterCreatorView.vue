<script setup lang="ts">
import { ref, onMounted } from 'vue'
import CharacterCreatorLayout from '@/components/characterCreation/layout/CharacterCreatorLayout.vue'
import StepBreadcrumb from '@/components/characterCreation/layout/StepBreadcrumb.vue'
import PedSelectionStep from '@/components/characterCreation/steps/PedSelectionStep.vue'
import HeritageStep from '@/components/characterCreation/steps/HeritageStep.vue'
import PhysicalCustomizationStep from '@/components/characterCreation/steps/PhysicalCustomizationStep.vue'
import ClothingStep from '@/components/characterCreation/steps/ClothingStep.vue'
import AccessoriesStep from '@/components/characterCreation/steps/AccessoriesStep.vue'
import TattoosStep from '@/components/characterCreation/steps/TattoosStep.vue'
import RecapStep from '@/components/characterCreation/steps/RecapStep.vue'
import ValidationButton from '@/components/characterCreation/steps/ValidationButton.vue'

const currentStep = ref(0)

const steps = ref([
  { titleKey: 'characterCreation.steps.pedSelection', key: 'ped' },
  { titleKey: 'characterCreation.steps.heritage', key: 'heritage' },
  { titleKey: 'characterCreation.steps.physicalCustomization', key: 'physical' },
  { titleKey: 'characterCreation.steps.clothing', key: 'clothing' },
  { titleKey: 'characterCreation.steps.accessories', key: 'accessories' },
  { titleKey: 'characterCreation.steps.tattoos', key: 'tattoos' },
  { titleKey: 'characterCreation.steps.confirmation', key: 'confirmation' },
])

interface PedModel {
  title: string
  value: string
  category: string
}

const selectedPed = ref<string | null>(null)
const authorizePedwhileInCreator = ref(false)

const pedModels = ref<PedModel[]>([])

// Identity step data - Disabled for now (will be used in RecapStep later)
// const firstName = ref<string>('')
// const lastName = ref<string>('')
// const dateOfBirth = ref<string>('')
// const gender = ref<string>('male')

// Heritage step data
const selectedFather = ref<number>(0)
const selectedMother = ref<number>(0)
const faceResemblance = ref<number>(0.5) // 0 = father, 1 = mother
const skinResemblance = ref<number>(0.5) // 0 = father, 1 = mother

// Heritage options
const fatherOptions = ref<{ id: number; name: string; photo?: string }[]>([])
const motherOptions = ref<{ id: number; name: string; photo?: string }[]>([])

// Physical Customization - Hair
const hairStyle = ref<number>(0)
const hairColor = ref<number>(0)
const hairHighlight = ref<number>(0)

// Physical Customization - Eyes
const eyeOpening = ref<number>(0)
const eyeColor = ref<number>(0)

// Physical Customization - Eyebrows
const eyebrowHeight = ref<number>(0)
const eyebrowDepth = ref<number>(0)
const eyebrowsStyle = ref<number>(0)
const eyebrowsColor = ref<number>(0)
const eyebrowsOpacity = ref<number>(1)

// Physical Customization - Nose
const noseWidth = ref<number>(0)
const noseHeight = ref<number>(0)
const noseLength = ref<number>(0)
const noseBridge = ref<number>(0)
const noseBridgeTwist = ref<number>(0)
const noseTipHeight = ref<number>(0)

// Physical Customization - Cheeks
const cheekBoneHeight = ref<number>(0)
const cheekBoneWidth = ref<number>(0)
const cheekWidth = ref<number>(0)

// Physical Customization - Jaw
const jawWidth = ref<number>(0)
const jawHeight = ref<number>(0)

// Physical Customization - Lips
const lipThickness = ref<number>(0)

// Physical Customization - Chin
const chinLowering = ref<number>(0)
const chinLength = ref<number>(0)
const chinWidth = ref<number>(0)
const chinCleft = ref<number>(0)

// Physical Customization - Neck
const neckThickness = ref<number>(0)

// Physical Customization - Beard
const beardStyle = ref<number>(0)
const beardColor = ref<number>(0)
const beardSecondaryColor = ref<number>(0)
const beardOpacity = ref<number>(1)

// Physical Customization - Ageing
const ageingStyle = ref<number>(0)
const ageingOpacity = ref<number>(0)

// Physical Customization - Makeup
const makeupStyle = ref<number>(0)
const makeupPrimaryColor = ref<number>(0)
const makeupSecondaryColor = ref<number>(0)
const makeupOpacity = ref<number>(0)

// Physical Customization - Blush
const blushStyle = ref<number>(0)
const blushColor = ref<number>(0)
const blushOpacity = ref<number>(0)

// Physical Customization - Complexion
const complexionStyle = ref<number>(0)
const complexionOpacity = ref<number>(0)

// Physical Customization - Sun Damage
const sunDamageStyle = ref<number>(0)
const sunDamageOpacity = ref<number>(0)

// Physical Customization - Lipstick
const lipstickStyle = ref<number>(0)
const lipstickColor = ref<number>(0)
const lipstickOpacity = ref<number>(0)

// Physical Customization - Moles & Freckles
const molesFrecklesStyle = ref<number>(0)
const molesFrecklesOpacity = ref<number>(0)

// Physical Customization - Chest Hair
const chestHairStyle = ref<number>(0)
const chestHairColor = ref<number>(0)
const chestHairOpacity = ref<number>(0)

// Physical Customization - Body Blemishes
const bodyBlemishesStyle = ref<number>(0)
const bodyBlemishesOpacity = ref<number>(0)

// Clothing - Each item has drawable (style) and texture (variant)
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

// Accessories - Each item has drawable (style) and texture (variant)
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

// Tattoos - Each zone has collection (style) and hash (specific tattoo)
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

const { forceVisible } = defineProps<{
  forceVisible?: boolean
}>()

const emit = defineEmits<{
  backToMenu: []
}>()

const isVisible = ref<boolean>(false)

const continuePhysicalCustomization = () => {
  currentStep.value++
}

const continueClothingCustomization = () => {
  currentStep.value++
}

const continueAccessoriesCustomization = () => {
  currentStep.value++
}

const continueTattoosCustomization = () => {
  currentStep.value++
}

const closeInterface = () => {
  isVisible.value = false
  fetch('https://Ambitions-Multicharacter/closeCharacterCreator', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({}),
  }).catch(() => {})
}

onMounted(() => {
  // Development mode hardcoded data
  if (import.meta.env.DEV) {
    // Peds list
    pedModels.value = [
      { title: 'Michael De Santa', value: 'player_zero', category: 'Protagonists' },
      { title: 'Franklin Clinton', value: 'player_one', category: 'Protagonists' },
      { title: 'Trevor Philips', value: 'player_two', category: 'Protagonists' },
      { title: 'Police Officer', value: 's_m_y_cop_01', category: 'Emergency Services' },
      { title: 'Sheriff', value: 's_m_y_sheriff_01', category: 'Emergency Services' },
      { title: 'Paramedic', value: 's_m_m_paramedic_01', category: 'Emergency Services' },
      { title: 'Firefighter', value: 's_m_y_fireman_01', category: 'Emergency Services' },
      { title: 'Business Woman', value: 'a_f_m_business_02', category: 'Civilians' },
      { title: 'Business Man', value: 'a_m_m_business_01', category: 'Civilians' },
      { title: 'Tourist Female', value: 'a_f_y_tourist_02', category: 'Civilians' },
      { title: 'Tourist Male', value: 'a_m_y_tourist_01', category: 'Civilians' },
      { title: 'Hipster Female', value: 'a_f_y_hipster_03', category: 'Civilians' },
      { title: 'Hipster Male', value: 'a_m_y_hipster_02', category: 'Civilians' },
      { title: 'Beach Female', value: 'a_f_y_beach_01', category: 'Beach/Casual' },
      { title: 'Surfer', value: 'a_m_y_surfer_01', category: 'Beach/Casual' },
      { title: 'Skater', value: 'a_m_y_skater_02', category: 'Beach/Casual' },
      { title: 'Mechanic', value: 's_m_y_construct_02', category: 'Workers' },
      { title: 'Construction Worker', value: 's_m_y_construct_01', category: 'Workers' },
      { title: 'Dock Worker', value: 's_m_m_dockwork_01', category: 'Workers' },
      { title: 'Security Guard', value: 's_m_m_security_01', category: 'Security' },
      { title: 'Bouncer', value: 's_m_y_bouncer_01', category: 'Security' },
      { title: 'Freemode Male', value: 'mp_m_freemode_01', category: 'Freemode' },
      { title: 'Freemode Female', value: 'mp_f_freemode_01', category: 'Freemode' },
      { title: 'Gang Member Vagos', value: 'g_m_y_mexgang_01', category: 'Gang Members' },
    ]

    // Heritage options (dev only - shorter list for testing)
    fatherOptions.value = [
      { id: 0, name: 'Benjamin Rodriguez' },
      { id: 1, name: 'Marcus Thompson' },
      { id: 2, name: 'David Anderson' },
    ]

    motherOptions.value = [
      { id: 0, name: 'Isabella Garcia' },
      { id: 1, name: 'Sofia Johnson' },
      { id: 2, name: 'Emma Williams' },
    ]
  }

  window.addEventListener('message', (event) => {
    if (event.data.action === 'showCharacterCreator') {
      isVisible.value = true
      if (event.data.config) {
        authorizePedwhileInCreator.value = event.data.config.authorizePedwhileInCreator
        // Only use config data in production mode
        if (!import.meta.env.DEV) {
          if (event.data.config.pedModels) {
            pedModels.value = event.data.config.pedModels
          }
          if (event.data.config.fatherOptions) {
            fatherOptions.value = event.data.config.fatherOptions
          }
          if (event.data.config.motherOptions) {
            motherOptions.value = event.data.config.motherOptions
          }
        }
      }
    } else if (event.data.action === 'hideCharacterCreator') {
      isVisible.value = false
    }
  })

  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape' && isVisible.value) {
      closeInterface()
    }
  })
})
</script>

<template>
  <CharacterCreatorLayout
    :is-visible="isVisible"
    :force-visible="forceVisible"
    @back-to-menu="emit('backToMenu')"
  >
    <StepBreadcrumb
      v-model:current-step="currentStep"
      :steps="steps"
    />

    <!-- Ped Selection Step -->
    <PedSelectionStep
      v-if="currentStep === 0"
      v-model="selectedPed"
      :ped-models="pedModels"
      @continue="currentStep++"
    />

    <!-- Heritage Step -->
    <HeritageStep
      v-if="currentStep === 1"
      v-model:selected-father="selectedFather"
      v-model:selected-mother="selectedMother"
      v-model:face-resemblance="faceResemblance"
      v-model:skin-resemblance="skinResemblance"
      :father-options="fatherOptions"
      :mother-options="motherOptions"
      @continue="currentStep++"
    />

    <!-- Physical Customization Step -->
    <PhysicalCustomizationStep
      v-if="currentStep === 2"
      v-model:hair-style="hairStyle"
      v-model:hair-color="hairColor"
      v-model:hair-highlight="hairHighlight"
      v-model:eye-opening="eyeOpening"
      v-model:eye-color="eyeColor"
      v-model:eyebrow-height="eyebrowHeight"
      v-model:eyebrow-depth="eyebrowDepth"
      v-model:eyebrows-style="eyebrowsStyle"
      v-model:eyebrows-color="eyebrowsColor"
      v-model:eyebrows-opacity="eyebrowsOpacity"
      v-model:nose-width="noseWidth"
      v-model:nose-height="noseHeight"
      v-model:nose-length="noseLength"
      v-model:nose-bridge="noseBridge"
      v-model:nose-bridge-twist="noseBridgeTwist"
      v-model:nose-tip-height="noseTipHeight"
      v-model:cheek-bone-height="cheekBoneHeight"
      v-model:cheek-bone-width="cheekBoneWidth"
      v-model:cheek-width="cheekWidth"
      v-model:jaw-width="jawWidth"
      v-model:jaw-height="jawHeight"
      v-model:lip-thickness="lipThickness"
      v-model:chin-lowering="chinLowering"
      v-model:chin-length="chinLength"
      v-model:chin-width="chinWidth"
      v-model:chin-cleft="chinCleft"
      v-model:neck-thickness="neckThickness"
      v-model:beard-style="beardStyle"
      v-model:beard-color="beardColor"
      v-model:beard-secondary-color="beardSecondaryColor"
      v-model:beard-opacity="beardOpacity"
      v-model:ageing-style="ageingStyle"
      v-model:ageing-opacity="ageingOpacity"
      v-model:makeup-style="makeupStyle"
      v-model:makeup-primary-color="makeupPrimaryColor"
      v-model:makeup-secondary-color="makeupSecondaryColor"
      v-model:makeup-opacity="makeupOpacity"
      v-model:blush-style="blushStyle"
      v-model:blush-color="blushColor"
      v-model:blush-opacity="blushOpacity"
      v-model:complexion-style="complexionStyle"
      v-model:complexion-opacity="complexionOpacity"
      v-model:sun-damage-style="sunDamageStyle"
      v-model:sun-damage-opacity="sunDamageOpacity"
      v-model:lipstick-style="lipstickStyle"
      v-model:lipstick-color="lipstickColor"
      v-model:lipstick-opacity="lipstickOpacity"
      v-model:moles-freckles-style="molesFrecklesStyle"
      v-model:moles-freckles-opacity="molesFrecklesOpacity"
      v-model:chest-hair-style="chestHairStyle"
      v-model:chest-hair-color="chestHairColor"
      v-model:chest-hair-opacity="chestHairOpacity"
      v-model:body-blemishes-style="bodyBlemishesStyle"
      v-model:body-blemishes-opacity="bodyBlemishesOpacity"
      @continue="continuePhysicalCustomization"
    />

    <!-- Clothing Step -->
    <ClothingStep
      v-if="currentStep === 3"
      v-model:mask-drawable="maskDrawable"
      v-model:mask-texture="maskTexture"
      v-model:torso-drawable="torsoDrawable"
      v-model:torso-texture="torsoTexture"
      v-model:undershirt-drawable="undershirtDrawable"
      v-model:undershirt-texture="undershirtTexture"
      v-model:arms-drawable="armsDrawable"
      v-model:arms-texture="armsTexture"
      v-model:jacket-drawable="jacketDrawable"
      v-model:jacket-texture="jacketTexture"
      v-model:body-armor-drawable="bodyArmorDrawable"
      v-model:body-armor-texture="bodyArmorTexture"
      v-model:decals-drawable="decalsDrawable"
      v-model:decals-texture="decalsTexture"
      v-model:pants-drawable="pantsDrawable"
      v-model:pants-texture="pantsTexture"
      v-model:shoes-drawable="shoesDrawable"
      v-model:shoes-texture="shoesTexture"
      @continue="continueClothingCustomization"
    />

    <!-- Accessories Step -->
    <AccessoriesStep
      v-if="currentStep === 4"
      v-model:hat-drawable="hatDrawable"
      v-model:hat-texture="hatTexture"
      v-model:glasses-drawable="glassesDrawable"
      v-model:glasses-texture="glassesTexture"
      v-model:earrings-drawable="earringsDrawable"
      v-model:earrings-texture="earringsTexture"
      v-model:watch-drawable="watchDrawable"
      v-model:watch-texture="watchTexture"
      v-model:bracelet-drawable="braceletDrawable"
      v-model:bracelet-texture="braceletTexture"
      v-model:neck-accessory-drawable="neckAccessoryDrawable"
      v-model:neck-accessory-texture="neckAccessoryTexture"
      @continue="continueAccessoriesCustomization"
    />

    <!-- Tattoos Step -->
    <TattoosStep
      v-if="currentStep === 5"
      v-model:head-tattoo-collection="headTattooCollection"
      v-model:head-tattoo-hash="headTattooHash"
      v-model:neck-tattoo-collection="neckTattooCollection"
      v-model:neck-tattoo-hash="neckTattooHash"
      v-model:torso-tattoo-collection="torsoTattooCollection"
      v-model:torso-tattoo-hash="torsoTattooHash"
      v-model:back-tattoo-collection="backTattooCollection"
      v-model:back-tattoo-hash="backTattooHash"
      v-model:left-arm-tattoo-collection="leftArmTattooCollection"
      v-model:left-arm-tattoo-hash="leftArmTattooHash"
      v-model:right-arm-tattoo-collection="rightArmTattooCollection"
      v-model:right-arm-tattoo-hash="rightArmTattooHash"
      v-model:left-leg-tattoo-collection="leftLegTattooCollection"
      v-model:left-leg-tattoo-hash="leftLegTattooHash"
      v-model:right-leg-tattoo-collection="rightLegTattooCollection"
      v-model:right-leg-tattoo-hash="rightLegTattooHash"
      @continue="continueTattoosCustomization"
    />

    <!-- Recap Step -->
    <RecapStep
      v-if="currentStep === 6"
      :first-name="''"
      :last-name="''"
      :date-of-birth="''"
      :gender="'male'"
      :selected-ped="selectedPed"
      :selected-father="selectedFather"
      :selected-mother="selectedMother"
      :face-resemblance="faceResemblance"
      :skin-resemblance="skinResemblance"
      :hair-style="hairStyle"
      :hair-color="hairColor"
      :hair-highlight="hairHighlight"
      :eye-opening="eyeOpening"
      :eye-color="eyeColor"
      :eyebrow-height="eyebrowHeight"
      :eyebrow-depth="eyebrowDepth"
      :eyebrows-style="eyebrowsStyle"
      :eyebrows-color="eyebrowsColor"
      :eyebrows-opacity="eyebrowsOpacity"
      :nose-width="noseWidth"
      :nose-height="noseHeight"
      :nose-length="noseLength"
      :nose-bridge="noseBridge"
      :nose-bridge-twist="noseBridgeTwist"
      :nose-tip-height="noseTipHeight"
      :cheek-bone-height="cheekBoneHeight"
      :cheek-bone-width="cheekBoneWidth"
      :cheek-width="cheekWidth"
      :jaw-width="jawWidth"
      :jaw-height="jawHeight"
      :lip-thickness="lipThickness"
      :chin-lowering="chinLowering"
      :chin-length="chinLength"
      :chin-width="chinWidth"
      :chin-cleft="chinCleft"
      :neck-thickness="neckThickness"
      :beard-style="beardStyle"
      :beard-color="beardColor"
      :beard-secondary-color="beardSecondaryColor"
      :beard-opacity="beardOpacity"
      :ageing-style="ageingStyle"
      :ageing-opacity="ageingOpacity"
      :makeup-style="makeupStyle"
      :makeup-primary-color="makeupPrimaryColor"
      :makeup-secondary-color="makeupSecondaryColor"
      :makeup-opacity="makeupOpacity"
      :blush-style="blushStyle"
      :blush-color="blushColor"
      :blush-opacity="blushOpacity"
      :complexion-style="complexionStyle"
      :complexion-opacity="complexionOpacity"
      :sun-damage-style="sunDamageStyle"
      :sun-damage-opacity="sunDamageOpacity"
      :lipstick-style="lipstickStyle"
      :lipstick-color="lipstickColor"
      :lipstick-opacity="lipstickOpacity"
      :moles-freckles-style="molesFrecklesStyle"
      :moles-freckles-opacity="molesFrecklesOpacity"
      :chest-hair-style="chestHairStyle"
      :chest-hair-color="chestHairColor"
      :chest-hair-opacity="chestHairOpacity"
      :body-blemishes-style="bodyBlemishesStyle"
      :body-blemishes-opacity="bodyBlemishesOpacity"
      :mask-drawable="maskDrawable"
      :mask-texture="maskTexture"
      :torso-drawable="torsoDrawable"
      :torso-texture="torsoTexture"
      :undershirt-drawable="undershirtDrawable"
      :undershirt-texture="undershirtTexture"
      :arms-drawable="armsDrawable"
      :arms-texture="armsTexture"
      :jacket-drawable="jacketDrawable"
      :jacket-texture="jacketTexture"
      :body-armor-drawable="bodyArmorDrawable"
      :body-armor-texture="bodyArmorTexture"
      :decals-drawable="decalsDrawable"
      :decals-texture="decalsTexture"
      :pants-drawable="pantsDrawable"
      :pants-texture="pantsTexture"
      :shoes-drawable="shoesDrawable"
      :shoes-texture="shoesTexture"
      :hat-drawable="hatDrawable"
      :hat-texture="hatTexture"
      :glasses-drawable="glassesDrawable"
      :glasses-texture="glassesTexture"
      :earrings-drawable="earringsDrawable"
      :earrings-texture="earringsTexture"
      :watch-drawable="watchDrawable"
      :watch-texture="watchTexture"
      :bracelet-drawable="braceletDrawable"
      :bracelet-texture="braceletTexture"
      :neck-accessory-drawable="neckAccessoryDrawable"
      :neck-accessory-texture="neckAccessoryTexture"
      :head-tattoo-collection="headTattooCollection"
      :head-tattoo-hash="headTattooHash"
      :neck-tattoo-collection="neckTattooCollection"
      :neck-tattoo-hash="neckTattooHash"
      :torso-tattoo-collection="torsoTattooCollection"
      :torso-tattoo-hash="torsoTattooHash"
      :back-tattoo-collection="backTattooCollection"
      :back-tattoo-hash="backTattooHash"
      :left-arm-tattoo-collection="leftArmTattooCollection"
      :left-arm-tattoo-hash="leftArmTattooHash"
      :right-arm-tattoo-collection="rightArmTattooCollection"
      :right-arm-tattoo-hash="rightArmTattooHash"
      :left-leg-tattoo-collection="leftLegTattooCollection"
      :left-leg-tattoo-hash="leftLegTattooHash"
      :right-leg-tattoo-collection="rightLegTattooCollection"
      :right-leg-tattoo-hash="rightLegTattooHash"
    />

    <template #outside-transition>
      <!-- Validation Button - Fixed Bottom Right -->
      <ValidationButton v-if="currentStep === 6" />

      <div class="absolute right-0 top-0 w-3/5 h-full pointer-events-none"></div>
    </template>
  </CharacterCreatorLayout>
</template>

<style scoped>
.fade-in-enter-active {
  transition: all 0.6s ease-out;
}

.fade-in-enter-from {
  opacity: 0;
  transform: translateX(-30px);
}

.fade-in-enter-to {
  opacity: 1;
  transform: translateX(0);
}
</style>
