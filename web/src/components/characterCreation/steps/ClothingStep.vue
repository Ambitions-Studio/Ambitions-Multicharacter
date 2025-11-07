<script setup lang="ts">
import { ref, watch, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider, VBtn } from 'vuetify/components'
import { useAppearanceStore } from '@/stores/useAppearanceStore'
import { useCharacterStore } from '@/stores/useCharacterStore'
import ClothingNavigation from '@/components/characterCreation/layout/ClothingNavigation.vue'
import { sendNuiCallback } from '@/utils/nui'

const { t } = useI18n()
const appearanceStore = useAppearanceStore()
const characterStore = useCharacterStore()

const selectedCategory = ref(0)
const previousCategory = ref(0)

const maxMaskTypes = ref(100)
const maxMaskVariants = ref(50)
const maxTorsoTypes = ref(100)
const maxTorsoVariants = ref(50)
const maxUndershirtTypes = ref(100)
const maxUndershirtVariants = ref(50)
const maxArmsTypes = ref(100)
const maxArmsVariants = ref(50)
const maxBodyArmorTypes = ref(100)
const maxBodyArmorVariants = ref(50)
const maxDecalsTypes = ref(100)
const maxDecalsVariants = ref(50)
const maxPantsTypes = ref(100)
const maxPantsVariants = ref(50)
const maxShoesTypes = ref(100)
const maxShoesVariants = ref(50)
const maxBackpackTypes = ref(100)
const maxBackpackVariants = ref(50)

const clothingCategories = ref([
  { titleKey: 'characterCreation.clothing.categories.mask', key: 'mask' },
  { titleKey: 'characterCreation.clothing.categories.torso', key: 'torso' },
  { titleKey: 'characterCreation.clothing.categories.undershirt', key: 'undershirt' },
  { titleKey: 'characterCreation.clothing.categories.arms', key: 'arms' },
  { titleKey: 'characterCreation.clothing.categories.bodyArmor', key: 'bodyArmor' },
  { titleKey: 'characterCreation.clothing.categories.decals', key: 'decals' },
  { titleKey: 'characterCreation.clothing.categories.pants', key: 'pants' },
  { titleKey: 'characterCreation.clothing.categories.shoes', key: 'shoes' },
  { titleKey: 'characterCreation.clothing.categories.backpack', key: 'backpack' },
])

const props = withDefaults(
  defineProps<{
    maskDrawable?: number
    maskTexture?: number
    torsoDrawable?: number
    torsoTexture?: number
    undershirtDrawable?: number
    undershirtTexture?: number
    armsDrawable?: number
    armsTexture?: number
    jacketDrawable?: number
    jacketTexture?: number
    bodyArmorDrawable?: number
    bodyArmorTexture?: number
    decalsDrawable?: number
    decalsTexture?: number
    pantsDrawable?: number
    pantsTexture?: number
    shoesDrawable?: number
    shoesTexture?: number
    backpackDrawable?: number
    backpackTexture?: number
  }>(),
  {
    currentSubStep: 0,
    maskDrawable: 0,
    maskTexture: 0,
    torsoDrawable: 0,
    torsoTexture: 0,
    undershirtDrawable: 0,
    undershirtTexture: 0,
    armsDrawable: 0,
    armsTexture: 0,
    jacketDrawable: 0,
    jacketTexture: 0,
    bodyArmorDrawable: 0,
    bodyArmorTexture: 0,
    decalsDrawable: 0,
    decalsTexture: 0,
    pantsDrawable: 0,
    pantsTexture: 0,
    shoesDrawable: 0,
    shoesTexture: 0,
    backpackDrawable: 0,
    backpackTexture: 0,
  },
)

const emit = defineEmits<{
  'update:maskDrawable': [value: number]
  'update:maskTexture': [value: number]
  'update:torsoDrawable': [value: number]
  'update:torsoTexture': [value: number]
  'update:undershirtDrawable': [value: number]
  'update:undershirtTexture': [value: number]
  'update:armsDrawable': [value: number]
  'update:armsTexture': [value: number]
  'update:jacketDrawable': [value: number]
  'update:jacketTexture': [value: number]
  'update:bodyArmorDrawable': [value: number]
  'update:bodyArmorTexture': [value: number]
  'update:decalsDrawable': [value: number]
  'update:decalsTexture': [value: number]
  'update:pantsDrawable': [value: number]
  'update:pantsTexture': [value: number]
  'update:shoesDrawable': [value: number]
  'update:shoesTexture': [value: number]
  'update:backpackDrawable': [value: number]
  'update:backpackTexture': [value: number]
  continue: []
}>()

// Initialize from store if available, otherwise use props
const localMaskDrawable = ref(appearanceStore.maskDrawable ?? props.maskDrawable)
const localMaskTexture = ref(appearanceStore.maskTexture ?? props.maskTexture)
const localTorsoDrawable = ref(appearanceStore.torsoDrawable ?? props.torsoDrawable)
const localTorsoTexture = ref(appearanceStore.torsoTexture ?? props.torsoTexture)
const localUndershirtDrawable = ref(appearanceStore.undershirtDrawable ?? props.undershirtDrawable)
const localUndershirtTexture = ref(appearanceStore.undershirtTexture ?? props.undershirtTexture)
const localArmsDrawable = ref(appearanceStore.armsDrawable ?? props.armsDrawable)
const localArmsTexture = ref(appearanceStore.armsTexture ?? props.armsTexture)
const localJacketDrawable = ref(appearanceStore.jacketDrawable ?? props.jacketDrawable)
const localJacketTexture = ref(appearanceStore.jacketTexture ?? props.jacketTexture)
const localBodyArmorDrawable = ref(appearanceStore.bodyArmorDrawable ?? props.bodyArmorDrawable)
const localBodyArmorTexture = ref(appearanceStore.bodyArmorTexture ?? props.bodyArmorTexture)
const localDecalsDrawable = ref(appearanceStore.decalsDrawable ?? props.decalsDrawable)
const localDecalsTexture = ref(appearanceStore.decalsTexture ?? props.decalsTexture)
const localPantsDrawable = ref(appearanceStore.pantsDrawable ?? props.pantsDrawable)
const localPantsTexture = ref(appearanceStore.pantsTexture ?? props.pantsTexture)
const localShoesDrawable = ref(appearanceStore.shoesDrawable ?? props.shoesDrawable)
const localShoesTexture = ref(appearanceStore.shoesTexture ?? props.shoesTexture)
const localBackpackDrawable = ref(appearanceStore.backpackDrawable ?? props.backpackDrawable)
const localBackpackTexture = ref(appearanceStore.backpackTexture ?? props.backpackTexture)

// Save current section when switching categories
const saveSectionData = (categoryIndex: number) => {
  switch (categoryIndex) {
    case 0: // Mask
      appearanceStore.setMaskSection({
        maskDrawable: localMaskDrawable.value,
        maskTexture: localMaskTexture.value,
      })
      break
    case 1: // Torso
      appearanceStore.setTorsoSection({
        torsoDrawable: localTorsoDrawable.value,
        torsoTexture: localTorsoTexture.value,
      })
      break
    case 2: // Undershirt
      appearanceStore.setUndershirtSection({
        undershirtDrawable: localUndershirtDrawable.value,
        undershirtTexture: localUndershirtTexture.value,
      })
      break
    case 3: // Arms
      appearanceStore.setArmsSection({
        armsDrawable: localArmsDrawable.value,
        armsTexture: localArmsTexture.value,
      })
      break
    case 4: // Body Armor
      appearanceStore.setBodyArmorSection({
        bodyArmorDrawable: localBodyArmorDrawable.value,
        bodyArmorTexture: localBodyArmorTexture.value,
      })
      break
    case 5: // Decals
      appearanceStore.setDecalsSection({
        decalsDrawable: localDecalsDrawable.value,
        decalsTexture: localDecalsTexture.value,
      })
      break
    case 6: // Pants
      appearanceStore.setPantsSection({
        pantsDrawable: localPantsDrawable.value,
        pantsTexture: localPantsTexture.value,
      })
      break
    case 7: // Shoes
      appearanceStore.setShoesSection({
        shoesDrawable: localShoesDrawable.value,
        shoesTexture: localShoesTexture.value,
      })
      break
    case 8: // Backpack
      appearanceStore.setBackpackSection({
        backpackDrawable: localBackpackDrawable.value,
        backpackTexture: localBackpackTexture.value,
      })
      break
  }
}

// Watch for category changes and save previous section
watch(selectedCategory, (newCategory, oldCategory) => {
  saveSectionData(oldCategory)
  previousCategory.value = oldCategory
})

const updateMaskTypeLimit = async () => {
  try {
    const response = await sendNuiCallback<{ component: number; drawable: number }, { limit: number }>('getClothingTextureLimit', { component: 1, drawable: localMaskDrawable.value })
    if (response && typeof response.limit === 'number') {
      maxMaskVariants.value = response.limit
      if (localMaskTexture.value > response.limit) {
        localMaskTexture.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get mask texture limit:', error)
  }
}

watch(localMaskDrawable, async (newVal) => {
  appearanceStore.setMaskSection({ maskDrawable: newVal, maskTexture: localMaskTexture.value })

  try {
    await sendNuiCallback('applyMaskCustomization', {
      type: newVal,
      variant: localMaskTexture.value
    })

    await updateMaskTypeLimit()
  } catch (error) {
    console.error('Failed to apply mask drawable:', error)
  }
})

watch(localMaskTexture, async (newVal) => {
  appearanceStore.setMaskSection({ maskDrawable: localMaskDrawable.value, maskTexture: newVal })

  try {
    await sendNuiCallback('applyMaskCustomization', {
      type: localMaskDrawable.value,
      variant: newVal
    })
  } catch (error) {
    console.error('Failed to apply mask texture:', error)
  }
})

const updateTorsoTypeLimit = async () => {
  try {
    const response = await sendNuiCallback<{ component: number; drawable: number }, { limit: number }>('getClothingTextureLimit', { component: 11, drawable: localTorsoDrawable.value })
    if (response && typeof response.limit === 'number') {
      maxTorsoVariants.value = response.limit
      if (localTorsoTexture.value > response.limit) {
        localTorsoTexture.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get torso texture limit:', error)
  }
}

watch(localTorsoDrawable, async (newVal) => {
  appearanceStore.setTorsoSection({ torsoDrawable: newVal, torsoTexture: localTorsoTexture.value })
  try {
    await sendNuiCallback('applyTorsoCustomization', { type: newVal, variant: localTorsoTexture.value })
    await updateTorsoTypeLimit()
  } catch (error) {
    console.error('Failed to apply torso drawable:', error)
  }
})

watch(localTorsoTexture, async (newVal) => {
  appearanceStore.setTorsoSection({ torsoDrawable: localTorsoDrawable.value, torsoTexture: newVal })
  try {
    await sendNuiCallback('applyTorsoCustomization', { type: localTorsoDrawable.value, variant: newVal })
  } catch (error) {
    console.error('Failed to apply torso texture:', error)
  }
})

const updateUndershirtTypeLimit = async () => {
  try {
    const response = await sendNuiCallback<{ component: number; drawable: number }, { limit: number }>('getClothingTextureLimit', { component: 8, drawable: localUndershirtDrawable.value })
    if (response && typeof response.limit === 'number') {
      maxUndershirtVariants.value = response.limit
      if (localUndershirtTexture.value > response.limit) {
        localUndershirtTexture.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get undershirt texture limit:', error)
  }
}

watch(localUndershirtDrawable, async (newVal) => {
  appearanceStore.setUndershirtSection({ undershirtDrawable: newVal, undershirtTexture: localUndershirtTexture.value })
  try {
    await sendNuiCallback('applyUndershirtsCustomization', { type: newVal, variant: localUndershirtTexture.value })
    await updateUndershirtTypeLimit()
  } catch (error) {
    console.error('Failed to apply undershirt drawable:', error)
  }
})

watch(localUndershirtTexture, async (newVal) => {
  appearanceStore.setUndershirtSection({ undershirtDrawable: localUndershirtDrawable.value, undershirtTexture: newVal })
  try {
    await sendNuiCallback('applyUndershirtsCustomization', { type: localUndershirtDrawable.value, variant: newVal })
  } catch (error) {
    console.error('Failed to apply undershirt texture:', error)
  }
})

const updateArmsTypeLimit = async () => {
  try {
    const response = await sendNuiCallback<{ component: number; drawable: number }, { limit: number }>('getClothingTextureLimit', { component: 11, drawable: localArmsDrawable.value })
    if (response && typeof response.limit === 'number') {
      maxArmsVariants.value = response.limit
      if (localArmsTexture.value > response.limit) {
        localArmsTexture.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get arms texture limit:', error)
  }
}

watch(localArmsDrawable, async (newVal) => {
  appearanceStore.setArmsSection({ armsDrawable: newVal, armsTexture: localArmsTexture.value })
  try {
    await sendNuiCallback('applyTorsoCustomization', { type: newVal, variant: localArmsTexture.value })
    await updateArmsTypeLimit()
  } catch (error) {
    console.error('Failed to apply arms drawable:', error)
  }
})

watch(localArmsTexture, async (newVal) => {
  appearanceStore.setArmsSection({ armsDrawable: localArmsDrawable.value, armsTexture: newVal })
  try {
    await sendNuiCallback('applyTorsoCustomization', { type: localArmsDrawable.value, variant: newVal })
  } catch (error) {
    console.error('Failed to apply arms texture:', error)
  }
})

const updateBodyArmorTypeLimit = async () => {
  try {
    const response = await sendNuiCallback<{ component: number; drawable: number }, { limit: number }>('getClothingTextureLimit', { component: 9, drawable: localBodyArmorDrawable.value })
    if (response && typeof response.limit === 'number') {
      maxBodyArmorVariants.value = response.limit
      if (localBodyArmorTexture.value > response.limit) {
        localBodyArmorTexture.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get body armor texture limit:', error)
  }
}

watch(localBodyArmorDrawable, async (newVal) => {
  appearanceStore.setBodyArmorSection({ bodyArmorDrawable: newVal, bodyArmorTexture: localBodyArmorTexture.value })
  try {
    await sendNuiCallback('applyArmorCustomization', { type: newVal, variant: localBodyArmorTexture.value })
    await updateBodyArmorTypeLimit()
  } catch (error) {
    console.error('Failed to apply body armor drawable:', error)
  }
})

watch(localBodyArmorTexture, async (newVal) => {
  appearanceStore.setBodyArmorSection({ bodyArmorDrawable: localBodyArmorDrawable.value, bodyArmorTexture: newVal })
  try {
    await sendNuiCallback('applyArmorCustomization', { type: localBodyArmorDrawable.value, variant: newVal })
  } catch (error) {
    console.error('Failed to apply body armor texture:', error)
  }
})

const updateDecalsTypeLimit = async () => {
  try {
    const response = await sendNuiCallback<{ component: number; drawable: number }, { limit: number }>('getClothingTextureLimit', { component: 10, drawable: localDecalsDrawable.value })
    if (response && typeof response.limit === 'number') {
      maxDecalsVariants.value = response.limit
      if (localDecalsTexture.value > response.limit) {
        localDecalsTexture.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get decals texture limit:', error)
  }
}

watch(localDecalsDrawable, async (newVal) => {
  appearanceStore.setDecalsSection({ decalsDrawable: newVal, decalsTexture: localDecalsTexture.value })
  try {
    await sendNuiCallback('applyDecalsCustomization', { type: newVal, variant: localDecalsTexture.value })
    await updateDecalsTypeLimit()
  } catch (error) {
    console.error('Failed to apply decals drawable:', error)
  }
})

watch(localDecalsTexture, async (newVal) => {
  appearanceStore.setDecalsSection({ decalsDrawable: localDecalsDrawable.value, decalsTexture: newVal })
  try {
    await sendNuiCallback('applyDecalsCustomization', { type: localDecalsDrawable.value, variant: newVal })
  } catch (error) {
    console.error('Failed to apply decals texture:', error)
  }
})

const updatePantsTypeLimit = async () => {
  try {
    const response = await sendNuiCallback<{ component: number; drawable: number }, { limit: number }>('getClothingTextureLimit', { component: 4, drawable: localPantsDrawable.value })
    if (response && typeof response.limit === 'number') {
      maxPantsVariants.value = response.limit
      if (localPantsTexture.value > response.limit) {
        localPantsTexture.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get pants texture limit:', error)
  }
}

watch(localPantsDrawable, async (newVal) => {
  appearanceStore.setPantsSection({ pantsDrawable: newVal, pantsTexture: localPantsTexture.value })
  try {
    await sendNuiCallback('applyLegsCustomization', { type: newVal, variant: localPantsTexture.value })
    await updatePantsTypeLimit()
  } catch (error) {
    console.error('Failed to apply pants drawable:', error)
  }
})

watch(localPantsTexture, async (newVal) => {
  appearanceStore.setPantsSection({ pantsDrawable: localPantsDrawable.value, pantsTexture: newVal })
  try {
    await sendNuiCallback('applyLegsCustomization', { type: localPantsDrawable.value, variant: newVal })
  } catch (error) {
    console.error('Failed to apply pants texture:', error)
  }
})

const updateShoesTypeLimit = async () => {
  try {
    const response = await sendNuiCallback<{ component: number; drawable: number }, { limit: number }>('getClothingTextureLimit', { component: 6, drawable: localShoesDrawable.value })
    if (response && typeof response.limit === 'number') {
      maxShoesVariants.value = response.limit
      if (localShoesTexture.value > response.limit) {
        localShoesTexture.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get shoes texture limit:', error)
  }
}

watch(localShoesDrawable, async (newVal) => {
  appearanceStore.setShoesSection({ shoesDrawable: newVal, shoesTexture: localShoesTexture.value })
  try {
    await sendNuiCallback('applyShoesCustomization', { type: newVal, variant: localShoesTexture.value })
    await updateShoesTypeLimit()
  } catch (error) {
    console.error('Failed to apply shoes drawable:', error)
  }
})

watch(localShoesTexture, async (newVal) => {
  appearanceStore.setShoesSection({ shoesDrawable: localShoesDrawable.value, shoesTexture: newVal })
  try {
    await sendNuiCallback('applyShoesCustomization', { type: localShoesDrawable.value, variant: newVal })
  } catch (error) {
    console.error('Failed to apply shoes texture:', error)
  }
})

const updateBackpackTypeLimit = async () => {
  try {
    const response = await sendNuiCallback<{ component: number; drawable: number }, { limit: number }>('getClothingTextureLimit', { component: 5, drawable: localBackpackDrawable.value })
    if (response && typeof response.limit === 'number') {
      maxBackpackVariants.value = response.limit
      if (localBackpackTexture.value > response.limit) {
        localBackpackTexture.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get backpack texture limit:', error)
  }
}

watch(localBackpackDrawable, async (newVal) => {
  appearanceStore.setBackpackSection({ backpackDrawable: newVal, backpackTexture: localBackpackTexture.value })
  try {
    await sendNuiCallback('applyBagsCustomization', { type: newVal, variant: localBackpackTexture.value })
    await updateBackpackTypeLimit()
  } catch (error) {
    console.error('Failed to apply backpack drawable:', error)
  }
})

watch(localBackpackTexture, async (newVal) => {
  appearanceStore.setBackpackSection({ backpackDrawable: localBackpackDrawable.value, backpackTexture: newVal })
  try {
    await sendNuiCallback('applyBagsCustomization', { type: localBackpackDrawable.value, variant: newVal })
  } catch (error) {
    console.error('Failed to apply backpack texture:', error)
  }
})

onMounted(async () => {
  try {
    const limits = await sendNuiCallback<{}, { masks: number; torsos: number; undershirts: number; legs: number; bags: number; shoes: number; accessories: number; armor: number; decals: number }>('getClothingLimits', {})
    if (limits) {
      if (typeof limits.masks === 'number') maxMaskTypes.value = limits.masks
      if (typeof limits.torsos === 'number') maxTorsoTypes.value = limits.torsos
      if (typeof limits.undershirts === 'number') maxUndershirtTypes.value = limits.undershirts
      if (typeof limits.legs === 'number') maxPantsTypes.value = limits.legs
      if (typeof limits.bags === 'number') maxBackpackTypes.value = limits.bags
      if (typeof limits.shoes === 'number') maxShoesTypes.value = limits.shoes
      if (typeof limits.armor === 'number') maxBodyArmorTypes.value = limits.armor
      if (typeof limits.decals === 'number') maxDecalsTypes.value = limits.decals
      if (typeof limits.torsos === 'number') maxArmsTypes.value = limits.torsos
    }

    await updateMaskTypeLimit()
    await updateTorsoTypeLimit()
    await updateUndershirtTypeLimit()
    await updateArmsTypeLimit()
    await updateBodyArmorTypeLimit()
    await updateDecalsTypeLimit()
    await updatePantsTypeLimit()
    await updateShoesTypeLimit()
    await updateBackpackTypeLimit()
  } catch (error) {
    console.error('Failed to get clothing limits:', error)
  }
})

const handleContinue = () => {
  // Save current section before validating
  saveSectionData(selectedCategory.value)

  // Save ALL clothing data to AppearanceStore (to be sure)
  const clothingData = {
    maskDrawable: localMaskDrawable.value,
    maskTexture: localMaskTexture.value,
    torsoDrawable: localTorsoDrawable.value,
    torsoTexture: localTorsoTexture.value,
    undershirtDrawable: localUndershirtDrawable.value,
    undershirtTexture: localUndershirtTexture.value,
    armsDrawable: localArmsDrawable.value,
    armsTexture: localArmsTexture.value,
    jacketDrawable: localJacketDrawable.value,
    jacketTexture: localJacketTexture.value,
    bodyArmorDrawable: localBodyArmorDrawable.value,
    bodyArmorTexture: localBodyArmorTexture.value,
    decalsDrawable: localDecalsDrawable.value,
    decalsTexture: localDecalsTexture.value,
    pantsDrawable: localPantsDrawable.value,
    pantsTexture: localPantsTexture.value,
    shoesDrawable: localShoesDrawable.value,
    shoesTexture: localShoesTexture.value,
    backpackDrawable: localBackpackDrawable.value,
    backpackTexture: localBackpackTexture.value,
  }

  appearanceStore.setClothing(clothingData)

  // Update ONLY clothing section in character store
  characterStore.setClothing(clothingData)

  emit('update:maskDrawable', localMaskDrawable.value)
  emit('update:maskTexture', localMaskTexture.value)
  emit('update:torsoDrawable', localTorsoDrawable.value)
  emit('update:torsoTexture', localTorsoTexture.value)
  emit('update:undershirtDrawable', localUndershirtDrawable.value)
  emit('update:undershirtTexture', localUndershirtTexture.value)
  emit('update:armsDrawable', localArmsDrawable.value)
  emit('update:armsTexture', localArmsTexture.value)
  emit('update:jacketDrawable', localJacketDrawable.value)
  emit('update:jacketTexture', localJacketTexture.value)
  emit('update:bodyArmorDrawable', localBodyArmorDrawable.value)
  emit('update:bodyArmorTexture', localBodyArmorTexture.value)
  emit('update:decalsDrawable', localDecalsDrawable.value)
  emit('update:decalsTexture', localDecalsTexture.value)
  emit('update:pantsDrawable', localPantsDrawable.value)
  emit('update:pantsTexture', localPantsTexture.value)
  emit('update:shoesDrawable', localShoesDrawable.value)
  emit('update:shoesTexture', localShoesTexture.value)
  emit('update:backpackDrawable', localBackpackDrawable.value)
  emit('update:backpackTexture', localBackpackTexture.value)

  emit('continue')
}
</script>

<template>
  <div class="space-y-6">
    <!-- Menu for Clothing Categories -->
    <ClothingNavigation
      v-model="selectedCategory"
      :categories="clothingCategories"
    />

    <!-- Content Container -->
    <div class="h-[60vh] overflow-y-scroll pr-2 pb-32">
      <!-- Mask -->
      <div v-if="selectedCategory === 0">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.mask.drawable.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localMaskDrawable }}/{{ maxMaskTypes }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.mask.drawable.description') }}
            </p>
            <VSlider
              v-model="localMaskDrawable"
              :min="0"
              :max="maxMaskTypes"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.mask.texture.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localMaskTexture }}/{{ maxMaskVariants }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.mask.texture.description') }}
            </p>
            <VSlider
              v-model="localMaskTexture"
              :min="0"
              :max="maxMaskVariants"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Torso -->
      <div v-if="selectedCategory === 1">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.torso.drawable.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localTorsoDrawable }}/{{ maxTorsoTypes }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.torso.drawable.description') }}
            </p>
            <VSlider
              v-model="localTorsoDrawable"
              :min="0"
              :max="maxTorsoTypes"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.torso.texture.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localTorsoTexture }}/{{ maxTorsoVariants }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.torso.texture.description') }}
            </p>
            <VSlider
              v-model="localTorsoTexture"
              :min="0"
              :max="maxTorsoVariants"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Undershirt -->
      <div v-if="selectedCategory === 2">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.undershirt.drawable.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localUndershirtDrawable }}/{{ maxUndershirtTypes }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.undershirt.drawable.description') }}
            </p>
            <VSlider
              v-model="localUndershirtDrawable"
              :min="0"
              :max="maxUndershirtTypes"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.undershirt.texture.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localUndershirtTexture }}/{{ maxUndershirtVariants }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.undershirt.texture.description') }}
            </p>
            <VSlider
              v-model="localUndershirtTexture"
              :min="0"
              :max="maxUndershirtVariants"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Arms -->
      <div v-if="selectedCategory === 3">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.arms.drawable.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localArmsDrawable }}/{{ maxArmsTypes }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.arms.drawable.description') }}
            </p>
            <VSlider
              v-model="localArmsDrawable"
              :min="0"
              :max="maxArmsTypes"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.arms.texture.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localArmsTexture }}/{{ maxArmsVariants }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.arms.texture.description') }}
            </p>
            <VSlider
              v-model="localArmsTexture"
              :min="0"
              :max="maxArmsVariants"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Body Armor -->
      <div v-if="selectedCategory === 4">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.bodyArmor.drawable.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localBodyArmorDrawable }}/{{ maxBodyArmorTypes }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.bodyArmor.drawable.description') }}
            </p>
            <VSlider
              v-model="localBodyArmorDrawable"
              :min="0"
              :max="maxBodyArmorTypes"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.bodyArmor.texture.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localBodyArmorTexture }}/{{ maxBodyArmorVariants }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.bodyArmor.texture.description') }}
            </p>
            <VSlider
              v-model="localBodyArmorTexture"
              :min="0"
              :max="maxBodyArmorVariants"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Decals -->
      <div v-if="selectedCategory === 5">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.decals.drawable.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localDecalsDrawable }}/{{ maxDecalsTypes }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.decals.drawable.description') }}
            </p>
            <VSlider
              v-model="localDecalsDrawable"
              :min="0"
              :max="maxDecalsTypes"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.decals.texture.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localDecalsTexture }}/{{ maxDecalsVariants }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.decals.texture.description') }}
            </p>
            <VSlider
              v-model="localDecalsTexture"
              :min="0"
              :max="maxDecalsVariants"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Pants -->
      <div v-if="selectedCategory === 6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.pants.drawable.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localPantsDrawable }}/{{ maxPantsTypes }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.pants.drawable.description') }}
            </p>
            <VSlider
              v-model="localPantsDrawable"
              :min="0"
              :max="maxPantsTypes"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.pants.texture.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localPantsTexture }}/{{ maxPantsVariants }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.pants.texture.description') }}
            </p>
            <VSlider
              v-model="localPantsTexture"
              :min="0"
              :max="maxPantsVariants"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Shoes -->
      <div v-if="selectedCategory === 7">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.shoes.drawable.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localShoesDrawable }}/{{ maxShoesTypes }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.shoes.drawable.description') }}
            </p>
            <VSlider
              v-model="localShoesDrawable"
              :min="0"
              :max="maxShoesTypes"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.shoes.texture.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localShoesTexture }}/{{ maxShoesVariants }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.shoes.texture.description') }}
            </p>
            <VSlider
              v-model="localShoesTexture"
              :min="0"
              :max="maxShoesVariants"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Backpack -->
      <div v-if="selectedCategory === 8">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.backpack.drawable.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localBackpackDrawable }}/{{ maxBackpackTypes }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.backpack.drawable.description') }}
            </p>
            <VSlider
              v-model="localBackpackDrawable"
              :min="0"
              :max="maxBackpackTypes"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.backpack.texture.title') }}
              <span class="text-slate-500 text-xs ml-2">({{ localBackpackTexture }}/{{ maxBackpackVariants }})</span>
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.backpack.texture.description') }}
            </p>
            <VSlider
              v-model="localBackpackTexture"
              :min="0"
              :max="maxBackpackVariants"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Continue Button for Clothing -->
      <div class="mt-6 flex justify-center">
        <VBtn
          variant="outlined"
          size="large"
          class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
          elevation="0"
          @click="handleContinue"
        >
          <span class="text-base tracking-wide uppercase">
            {{ t('characterCreation.clothing.validateButton') }}
          </span>
        </VBtn>
      </div>
    </div>
  </div>
</template>
