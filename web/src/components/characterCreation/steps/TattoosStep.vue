<script setup lang="ts">
import { ref, watch, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider, VBtn } from 'vuetify/components'
import { useAppearanceStore } from '@/stores/useAppearanceStore'
import { useCharacterStore } from '@/stores/useCharacterStore'
import { sendNuiCallback } from '@/utils/nui'
import TattoosNavigation from '@/components/characterCreation/layout/TattoosNavigation.vue'

const { t } = useI18n()
const appearanceStore = useAppearanceStore()
const characterStore = useCharacterStore()

const selectedCategory = ref(0)
const previousCategory = ref(0)

const collectionsLimit = ref(100)
const headTattooHashLimit = ref(50)
const neckTattooHashLimit = ref(50)
const torsoTattooHashLimit = ref(50)
const backTattooHashLimit = ref(50)
const leftArmTattooHashLimit = ref(50)
const rightArmTattooHashLimit = ref(50)
const leftLegTattooHashLimit = ref(50)
const rightLegTattooHashLimit = ref(50)

const tattoosCategories = ref([
  { titleKey: 'characterCreation.tattoos.categories.head', key: 'head' },
  { titleKey: 'characterCreation.tattoos.categories.neck', key: 'neck' },
  { titleKey: 'characterCreation.tattoos.categories.torso', key: 'torso' },
  { titleKey: 'characterCreation.tattoos.categories.back', key: 'back' },
  { titleKey: 'characterCreation.tattoos.categories.leftArm', key: 'leftArm' },
  { titleKey: 'characterCreation.tattoos.categories.rightArm', key: 'rightArm' },
  { titleKey: 'characterCreation.tattoos.categories.leftLeg', key: 'leftLeg' },
  { titleKey: 'characterCreation.tattoos.categories.rightLeg', key: 'rightLeg' },
])

const props = withDefaults(
  defineProps<{
    headTattooCollection?: number
    headTattooHash?: number
    neckTattooCollection?: number
    neckTattooHash?: number
    torsoTattooCollection?: number
    torsoTattooHash?: number
    backTattooCollection?: number
    backTattooHash?: number
    leftArmTattooCollection?: number
    leftArmTattooHash?: number
    rightArmTattooCollection?: number
    rightArmTattooHash?: number
    leftLegTattooCollection?: number
    leftLegTattooHash?: number
    rightLegTattooCollection?: number
    rightLegTattooHash?: number
  }>(),
  {
    headTattooCollection: 0,
    headTattooHash: 0,
    neckTattooCollection: 0,
    neckTattooHash: 0,
    torsoTattooCollection: 0,
    torsoTattooHash: 0,
    backTattooCollection: 0,
    backTattooHash: 0,
    leftArmTattooCollection: 0,
    leftArmTattooHash: 0,
    rightArmTattooCollection: 0,
    rightArmTattooHash: 0,
    leftLegTattooCollection: 0,
    leftLegTattooHash: 0,
    rightLegTattooCollection: 0,
    rightLegTattooHash: 0,
  },
)

const emit = defineEmits<{
  'update:headTattooCollection': [value: number]
  'update:headTattooHash': [value: number]
  'update:neckTattooCollection': [value: number]
  'update:neckTattooHash': [value: number]
  'update:torsoTattooCollection': [value: number]
  'update:torsoTattooHash': [value: number]
  'update:backTattooCollection': [value: number]
  'update:backTattooHash': [value: number]
  'update:leftArmTattooCollection': [value: number]
  'update:leftArmTattooHash': [value: number]
  'update:rightArmTattooCollection': [value: number]
  'update:rightArmTattooHash': [value: number]
  'update:leftLegTattooCollection': [value: number]
  'update:leftLegTattooHash': [value: number]
  'update:rightLegTattooCollection': [value: number]
  'update:rightLegTattooHash': [value: number]
  continue: []
}>()

const localHeadTattooCollection = ref(
  appearanceStore.headTattooCollection ?? props.headTattooCollection
)
const localHeadTattooHash = ref(appearanceStore.headTattooHash ?? props.headTattooHash)
const localNeckTattooCollection = ref(
  appearanceStore.neckTattooCollection ?? props.neckTattooCollection
)
const localNeckTattooHash = ref(appearanceStore.neckTattooHash ?? props.neckTattooHash)
const localTorsoTattooCollection = ref(
  appearanceStore.torsoTattooCollection ?? props.torsoTattooCollection
)
const localTorsoTattooHash = ref(appearanceStore.torsoTattooHash ?? props.torsoTattooHash)
const localBackTattooCollection = ref(
  appearanceStore.backTattooCollection ?? props.backTattooCollection
)
const localBackTattooHash = ref(appearanceStore.backTattooHash ?? props.backTattooHash)
const localLeftArmTattooCollection = ref(
  appearanceStore.leftArmTattooCollection ?? props.leftArmTattooCollection
)
const localLeftArmTattooHash = ref(appearanceStore.leftArmTattooHash ?? props.leftArmTattooHash)
const localRightArmTattooCollection = ref(
  appearanceStore.rightArmTattooCollection ?? props.rightArmTattooCollection
)
const localRightArmTattooHash = ref(
  appearanceStore.rightArmTattooHash ?? props.rightArmTattooHash
)
const localLeftLegTattooCollection = ref(
  appearanceStore.leftLegTattooCollection ?? props.leftLegTattooCollection
)
const localLeftLegTattooHash = ref(appearanceStore.leftLegTattooHash ?? props.leftLegTattooHash)
const localRightLegTattooCollection = ref(
  appearanceStore.rightLegTattooCollection ?? props.rightLegTattooCollection
)
const localRightLegTattooHash = ref(
  appearanceStore.rightLegTattooHash ?? props.rightLegTattooHash
)

// Save current section when switching categories
const saveSectionData = (categoryIndex: number) => {
  switch (categoryIndex) {
    case 0: // Head
      appearanceStore.setHeadTattooSection({
        headTattooCollection: localHeadTattooCollection.value,
        headTattooHash: localHeadTattooHash.value,
      })
      break
    case 1: // Neck
      appearanceStore.setNeckTattooSection({
        neckTattooCollection: localNeckTattooCollection.value,
        neckTattooHash: localNeckTattooHash.value,
      })
      break
    case 2: // Torso
      appearanceStore.setTorsoTattooSection({
        torsoTattooCollection: localTorsoTattooCollection.value,
        torsoTattooHash: localTorsoTattooHash.value,
      })
      break
    case 3: // Back
      appearanceStore.setBackTattooSection({
        backTattooCollection: localBackTattooCollection.value,
        backTattooHash: localBackTattooHash.value,
      })
      break
    case 4: // Left Arm
      appearanceStore.setLeftArmTattooSection({
        leftArmTattooCollection: localLeftArmTattooCollection.value,
        leftArmTattooHash: localLeftArmTattooHash.value,
      })
      break
    case 5: // Right Arm
      appearanceStore.setRightArmTattooSection({
        rightArmTattooCollection: localRightArmTattooCollection.value,
        rightArmTattooHash: localRightArmTattooHash.value,
      })
      break
    case 6: // Left Leg
      appearanceStore.setLeftLegTattooSection({
        leftLegTattooCollection: localLeftLegTattooCollection.value,
        leftLegTattooHash: localLeftLegTattooHash.value,
      })
      break
    case 7: // Right Leg
      appearanceStore.setRightLegTattooSection({
        rightLegTattooCollection: localRightLegTattooCollection.value,
        rightLegTattooHash: localRightLegTattooHash.value,
      })
      break
  }
}

// Watch for category changes and save previous section
watch(selectedCategory, (newCategory, oldCategory) => {
  saveSectionData(oldCategory)
  previousCategory.value = oldCategory
})

const updateHeadTattooHashLimit = async () => {
  try {
    const response = (await sendNuiCallback('getTattooHashLimit', {
      collection: localHeadTattooCollection.value,
      zone: 'head'
    })) as { limit: number }
    if (response?.limit !== undefined) {
      headTattooHashLimit.value = response.limit
      if (localHeadTattooHash.value > response.limit) {
        localHeadTattooHash.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get head tattoo hash limit:', error)
  }
}

const updateNeckTattooHashLimit = async () => {
  try {
    const response = (await sendNuiCallback('getTattooHashLimit', {
      collection: localNeckTattooCollection.value,
      zone: 'neck'
    })) as { limit: number }
    if (response?.limit !== undefined) {
      neckTattooHashLimit.value = response.limit
      if (localNeckTattooHash.value > response.limit) {
        localNeckTattooHash.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get neck tattoo hash limit:', error)
  }
}

const updateTorsoTattooHashLimit = async () => {
  try {
    const response = (await sendNuiCallback('getTattooHashLimit', {
      collection: localTorsoTattooCollection.value,
      zone: 'torso'
    })) as { limit: number }
    if (response?.limit !== undefined) {
      torsoTattooHashLimit.value = response.limit
      if (localTorsoTattooHash.value > response.limit) {
        localTorsoTattooHash.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get torso tattoo hash limit:', error)
  }
}

const updateBackTattooHashLimit = async () => {
  try {
    const response = (await sendNuiCallback('getTattooHashLimit', {
      collection: localBackTattooCollection.value,
      zone: 'back'
    })) as { limit: number }
    if (response?.limit !== undefined) {
      backTattooHashLimit.value = response.limit
      if (localBackTattooHash.value > response.limit) {
        localBackTattooHash.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get back tattoo hash limit:', error)
  }
}

const updateLeftArmTattooHashLimit = async () => {
  try {
    const response = (await sendNuiCallback('getTattooHashLimit', {
      collection: localLeftArmTattooCollection.value,
      zone: 'leftArm'
    })) as { limit: number }
    if (response?.limit !== undefined) {
      leftArmTattooHashLimit.value = response.limit
      if (localLeftArmTattooHash.value > response.limit) {
        localLeftArmTattooHash.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get left arm tattoo hash limit:', error)
  }
}

const updateRightArmTattooHashLimit = async () => {
  try {
    const response = (await sendNuiCallback('getTattooHashLimit', {
      collection: localRightArmTattooCollection.value,
      zone: 'rightArm'
    })) as { limit: number }
    if (response?.limit !== undefined) {
      rightArmTattooHashLimit.value = response.limit
      if (localRightArmTattooHash.value > response.limit) {
        localRightArmTattooHash.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get right arm tattoo hash limit:', error)
  }
}

const updateLeftLegTattooHashLimit = async () => {
  try {
    const response = (await sendNuiCallback('getTattooHashLimit', {
      collection: localLeftLegTattooCollection.value,
      zone: 'leftLeg'
    })) as { limit: number }
    if (response?.limit !== undefined) {
      leftLegTattooHashLimit.value = response.limit
      if (localLeftLegTattooHash.value > response.limit) {
        localLeftLegTattooHash.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get left leg tattoo hash limit:', error)
  }
}

const updateRightLegTattooHashLimit = async () => {
  try {
    const response = (await sendNuiCallback('getTattooHashLimit', {
      collection: localRightLegTattooCollection.value,
      zone: 'rightLeg'
    })) as { limit: number }
    if (response?.limit !== undefined) {
      rightLegTattooHashLimit.value = response.limit
      if (localRightLegTattooHash.value > response.limit) {
        localRightLegTattooHash.value = response.limit
      }
    }
  } catch (error) {
    console.error('Failed to get right leg tattoo hash limit:', error)
  }
}

watch(localHeadTattooCollection, async (newVal) => {
  appearanceStore.setHeadTattooSection({ headTattooCollection: newVal, headTattooHash: localHeadTattooHash.value })
  try {
    await sendNuiCallback('applyHeadTattoo', {
      collection: newVal,
      hash: localHeadTattooHash.value
    })
    await updateHeadTattooHashLimit()
  } catch (error) {
    console.error('Failed to apply head tattoo collection:', error)
  }
})

watch(localHeadTattooHash, async (newVal) => {
  appearanceStore.setHeadTattooSection({ headTattooCollection: localHeadTattooCollection.value, headTattooHash: newVal })
  try {
    await sendNuiCallback('applyHeadTattoo', {
      collection: localHeadTattooCollection.value,
      hash: newVal
    })
  } catch (error) {
    console.error('Failed to apply head tattoo hash:', error)
  }
})

watch(localNeckTattooCollection, async (newVal) => {
  appearanceStore.setNeckTattooSection({ neckTattooCollection: newVal, neckTattooHash: localNeckTattooHash.value })
  try {
    await sendNuiCallback('applyNeckTattoo', {
      collection: newVal,
      hash: localNeckTattooHash.value
    })
    await updateNeckTattooHashLimit()
  } catch (error) {
    console.error('Failed to apply neck tattoo collection:', error)
  }
})

watch(localNeckTattooHash, async (newVal) => {
  appearanceStore.setNeckTattooSection({ neckTattooCollection: localNeckTattooCollection.value, neckTattooHash: newVal })
  try {
    await sendNuiCallback('applyNeckTattoo', {
      collection: localNeckTattooCollection.value,
      hash: newVal
    })
  } catch (error) {
    console.error('Failed to apply neck tattoo hash:', error)
  }
})

watch(localTorsoTattooCollection, async (newVal) => {
  appearanceStore.setTorsoTattooSection({ torsoTattooCollection: newVal, torsoTattooHash: localTorsoTattooHash.value })
  try {
    await sendNuiCallback('applyTorsoTattoo', {
      collection: newVal,
      hash: localTorsoTattooHash.value
    })
    await updateTorsoTattooHashLimit()
  } catch (error) {
    console.error('Failed to apply torso tattoo collection:', error)
  }
})

watch(localTorsoTattooHash, async (newVal) => {
  appearanceStore.setTorsoTattooSection({ torsoTattooCollection: localTorsoTattooCollection.value, torsoTattooHash: newVal })
  try {
    await sendNuiCallback('applyTorsoTattoo', {
      collection: localTorsoTattooCollection.value,
      hash: newVal
    })
  } catch (error) {
    console.error('Failed to apply torso tattoo hash:', error)
  }
})

watch(localBackTattooCollection, async (newVal) => {
  appearanceStore.setBackTattooSection({ backTattooCollection: newVal, backTattooHash: localBackTattooHash.value })
  try {
    await sendNuiCallback('applyBackTattoo', {
      collection: newVal,
      hash: localBackTattooHash.value
    })
    await updateBackTattooHashLimit()
  } catch (error) {
    console.error('Failed to apply back tattoo collection:', error)
  }
})

watch(localBackTattooHash, async (newVal) => {
  appearanceStore.setBackTattooSection({ backTattooCollection: localBackTattooCollection.value, backTattooHash: newVal })
  try {
    await sendNuiCallback('applyBackTattoo', {
      collection: localBackTattooCollection.value,
      hash: newVal
    })
  } catch (error) {
    console.error('Failed to apply back tattoo hash:', error)
  }
})

watch(localLeftArmTattooCollection, async (newVal) => {
  appearanceStore.setLeftArmTattooSection({ leftArmTattooCollection: newVal, leftArmTattooHash: localLeftArmTattooHash.value })
  try {
    await sendNuiCallback('applyLeftArmTattoo', {
      collection: newVal,
      hash: localLeftArmTattooHash.value
    })
    await updateLeftArmTattooHashLimit()
  } catch (error) {
    console.error('Failed to apply left arm tattoo collection:', error)
  }
})

watch(localLeftArmTattooHash, async (newVal) => {
  appearanceStore.setLeftArmTattooSection({ leftArmTattooCollection: localLeftArmTattooCollection.value, leftArmTattooHash: newVal })
  try {
    await sendNuiCallback('applyLeftArmTattoo', {
      collection: localLeftArmTattooCollection.value,
      hash: newVal
    })
  } catch (error) {
    console.error('Failed to apply left arm tattoo hash:', error)
  }
})

watch(localRightArmTattooCollection, async (newVal) => {
  appearanceStore.setRightArmTattooSection({ rightArmTattooCollection: newVal, rightArmTattooHash: localRightArmTattooHash.value })
  try {
    await sendNuiCallback('applyRightArmTattoo', {
      collection: newVal,
      hash: localRightArmTattooHash.value
    })
    await updateRightArmTattooHashLimit()
  } catch (error) {
    console.error('Failed to apply right arm tattoo collection:', error)
  }
})

watch(localRightArmTattooHash, async (newVal) => {
  appearanceStore.setRightArmTattooSection({ rightArmTattooCollection: localRightArmTattooCollection.value, rightArmTattooHash: newVal })
  try {
    await sendNuiCallback('applyRightArmTattoo', {
      collection: localRightArmTattooCollection.value,
      hash: newVal
    })
  } catch (error) {
    console.error('Failed to apply right arm tattoo hash:', error)
  }
})

watch(localLeftLegTattooCollection, async (newVal) => {
  appearanceStore.setLeftLegTattooSection({ leftLegTattooCollection: newVal, leftLegTattooHash: localLeftLegTattooHash.value })
  try {
    await sendNuiCallback('applyLeftLegTattoo', {
      collection: newVal,
      hash: localLeftLegTattooHash.value
    })
    await updateLeftLegTattooHashLimit()
  } catch (error) {
    console.error('Failed to apply left leg tattoo collection:', error)
  }
})

watch(localLeftLegTattooHash, async (newVal) => {
  appearanceStore.setLeftLegTattooSection({ leftLegTattooCollection: localLeftLegTattooCollection.value, leftLegTattooHash: newVal })
  try {
    await sendNuiCallback('applyLeftLegTattoo', {
      collection: localLeftLegTattooCollection.value,
      hash: newVal
    })
  } catch (error) {
    console.error('Failed to apply left leg tattoo hash:', error)
  }
})

watch(localRightLegTattooCollection, async (newVal) => {
  appearanceStore.setRightLegTattooSection({ rightLegTattooCollection: newVal, rightLegTattooHash: localRightLegTattooHash.value })
  try {
    await sendNuiCallback('applyRightLegTattoo', {
      collection: newVal,
      hash: localRightLegTattooHash.value
    })
    await updateRightLegTattooHashLimit()
  } catch (error) {
    console.error('Failed to apply right leg tattoo collection:', error)
  }
})

watch(localRightLegTattooHash, async (newVal) => {
  appearanceStore.setRightLegTattooSection({ rightLegTattooCollection: localRightLegTattooCollection.value, rightLegTattooHash: newVal })
  try {
    await sendNuiCallback('applyRightLegTattoo', {
      collection: localRightLegTattooCollection.value,
      hash: newVal
    })
  } catch (error) {
    console.error('Failed to apply right leg tattoo hash:', error)
  }
})

onMounted(async () => {
  try {
    const limitsResponse = (await sendNuiCallback('getTattoosLimits', {})) as {
      collections: number
      head: number
      neck: number
      torso: number
      back: number
      leftArm: number
      rightArm: number
      leftLeg: number
      rightLeg: number
    }

    if (limitsResponse) {
      collectionsLimit.value = limitsResponse.collections
      headTattooHashLimit.value = limitsResponse.head
      neckTattooHashLimit.value = limitsResponse.neck
      torsoTattooHashLimit.value = limitsResponse.torso
      backTattooHashLimit.value = limitsResponse.back
      leftArmTattooHashLimit.value = limitsResponse.leftArm
      rightArmTattooHashLimit.value = limitsResponse.rightArm
      leftLegTattooHashLimit.value = limitsResponse.leftLeg
      rightLegTattooHashLimit.value = limitsResponse.rightLeg
    }

    await updateHeadTattooHashLimit()
    await updateNeckTattooHashLimit()
    await updateTorsoTattooHashLimit()
    await updateBackTattooHashLimit()
    await updateLeftArmTattooHashLimit()
    await updateRightArmTattooHashLimit()
    await updateLeftLegTattooHashLimit()
    await updateRightLegTattooHashLimit()
  } catch (error) {
    console.error('Failed to get tattoos limits:', error)
  }
})

const handleContinue = () => {
  // Save current section before validating
  saveSectionData(selectedCategory.value)

  // Save ALL tattoos data to AppearanceStore (to be sure)
  const tattoosData = {
    headTattooCollection: localHeadTattooCollection.value,
    headTattooHash: localHeadTattooHash.value,
    neckTattooCollection: localNeckTattooCollection.value,
    neckTattooHash: localNeckTattooHash.value,
    torsoTattooCollection: localTorsoTattooCollection.value,
    torsoTattooHash: localTorsoTattooHash.value,
    backTattooCollection: localBackTattooCollection.value,
    backTattooHash: localBackTattooHash.value,
    leftArmTattooCollection: localLeftArmTattooCollection.value,
    leftArmTattooHash: localLeftArmTattooHash.value,
    rightArmTattooCollection: localRightArmTattooCollection.value,
    rightArmTattooHash: localRightArmTattooHash.value,
    leftLegTattooCollection: localLeftLegTattooCollection.value,
    leftLegTattooHash: localLeftLegTattooHash.value,
    rightLegTattooCollection: localRightLegTattooCollection.value,
    rightLegTattooHash: localRightLegTattooHash.value,
  }

  appearanceStore.setTattoos(tattoosData)

  // Update ONLY tattoos section in character store
  characterStore.setTattoos(tattoosData)
  emit('update:headTattooCollection', localHeadTattooCollection.value)
  emit('update:headTattooHash', localHeadTattooHash.value)
  emit('update:neckTattooCollection', localNeckTattooCollection.value)
  emit('update:neckTattooHash', localNeckTattooHash.value)
  emit('update:torsoTattooCollection', localTorsoTattooCollection.value)
  emit('update:torsoTattooHash', localTorsoTattooHash.value)
  emit('update:backTattooCollection', localBackTattooCollection.value)
  emit('update:backTattooHash', localBackTattooHash.value)
  emit('update:leftArmTattooCollection', localLeftArmTattooCollection.value)
  emit('update:leftArmTattooHash', localLeftArmTattooHash.value)
  emit('update:rightArmTattooCollection', localRightArmTattooCollection.value)
  emit('update:rightArmTattooHash', localRightArmTattooHash.value)
  emit('update:leftLegTattooCollection', localLeftLegTattooCollection.value)
  emit('update:leftLegTattooHash', localLeftLegTattooHash.value)
  emit('update:rightLegTattooCollection', localRightLegTattooCollection.value)
  emit('update:rightLegTattooHash', localRightLegTattooHash.value)

  emit('continue')
}
</script>

<template>
  <div class="space-y-6">
    <TattoosNavigation
      v-model="selectedCategory"
      :categories="tattoosCategories"
    />

    <div class="h-[60vh] overflow-y-scroll pr-2 pb-32">
      <!-- Head -->
      <div v-if="selectedCategory === 0" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.head.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.head.collection.description') }}
            </p>
            <VSlider
              v-model="localHeadTattooCollection"
              :min="0"
              :max="collectionsLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.head.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.head.hash.description') }}
            </p>
            <VSlider
              v-model="localHeadTattooHash"
              :min="0"
              :max="headTattooHashLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Neck -->
      <div v-if="selectedCategory === 1" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.neck.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.neck.collection.description') }}
            </p>
            <VSlider
              v-model="localNeckTattooCollection"
              :min="0"
              :max="collectionsLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.neck.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.neck.hash.description') }}
            </p>
            <VSlider
              v-model="localNeckTattooHash"
              :min="0"
              :max="neckTattooHashLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Torso -->
      <div v-if="selectedCategory === 2" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.torso.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.torso.collection.description') }}
            </p>
            <VSlider
              v-model="localTorsoTattooCollection"
              :min="0"
              :max="collectionsLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.torso.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.torso.hash.description') }}
            </p>
            <VSlider
              v-model="localTorsoTattooHash"
              :min="0"
              :max="torsoTattooHashLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Back -->
      <div v-if="selectedCategory === 3" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.back.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.back.collection.description') }}
            </p>
            <VSlider
              v-model="localBackTattooCollection"
              :min="0"
              :max="collectionsLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.back.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.back.hash.description') }}
            </p>
            <VSlider
              v-model="localBackTattooHash"
              :min="0"
              :max="backTattooHashLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Left Arm -->
      <div v-if="selectedCategory === 4" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.leftArm.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.leftArm.collection.description') }}
            </p>
            <VSlider
              v-model="localLeftArmTattooCollection"
              :min="0"
              :max="collectionsLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.leftArm.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.leftArm.hash.description') }}
            </p>
            <VSlider
              v-model="localLeftArmTattooHash"
              :min="0"
              :max="leftArmTattooHashLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Right Arm -->
      <div v-if="selectedCategory === 5" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.rightArm.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.rightArm.collection.description') }}
            </p>
            <VSlider
              v-model="localRightArmTattooCollection"
              :min="0"
              :max="collectionsLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.rightArm.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.rightArm.hash.description') }}
            </p>
            <VSlider
              v-model="localRightArmTattooHash"
              :min="0"
              :max="rightArmTattooHashLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Left Leg -->
      <div v-if="selectedCategory === 6" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.leftLeg.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.leftLeg.collection.description') }}
            </p>
            <VSlider
              v-model="localLeftLegTattooCollection"
              :min="0"
              :max="collectionsLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.leftLeg.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.leftLeg.hash.description') }}
            </p>
            <VSlider
              v-model="localLeftLegTattooHash"
              :min="0"
              :max="leftLegTattooHashLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Right Leg -->
      <div v-if="selectedCategory === 7" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.rightLeg.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.rightLeg.collection.description') }}
            </p>
            <VSlider
              v-model="localRightLegTattooCollection"
              :min="0"
              :max="collectionsLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.rightLeg.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.rightLeg.hash.description') }}
            </p>
            <VSlider
              v-model="localRightLegTattooHash"
              :min="0"
              :max="rightLegTattooHashLimit"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Continue Button for Tattoos -->
      <div class="mt-6 flex justify-center">
      <VBtn
        variant="outlined"
        size="large"
        class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
        elevation="0"
        @click="handleContinue"
      >
        <span class="text-base tracking-wide uppercase">
          {{ t('characterCreation.tattoos.validateButton') }}
        </span>
      </VBtn>
      </div>
    </div>
  </div>
</template>
