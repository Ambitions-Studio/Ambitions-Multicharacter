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

const tattooLimit = ref(60)

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
    headTattooIndex?: number
    neckTattooIndex?: number
    torsoTattooIndex?: number
    backTattooIndex?: number
    leftArmTattooIndex?: number
    rightArmTattooIndex?: number
    leftLegTattooIndex?: number
    rightLegTattooIndex?: number
  }>(),
  {
    headTattooIndex: 0,
    neckTattooIndex: 0,
    torsoTattooIndex: 0,
    backTattooIndex: 0,
    leftArmTattooIndex: 0,
    rightArmTattooIndex: 0,
    leftLegTattooIndex: 0,
    rightLegTattooIndex: 0,
  },
)

const emit = defineEmits<{
  'update:headTattooIndex': [value: number]
  'update:neckTattooIndex': [value: number]
  'update:torsoTattooIndex': [value: number]
  'update:backTattooIndex': [value: number]
  'update:leftArmTattooIndex': [value: number]
  'update:rightArmTattooIndex': [value: number]
  'update:leftLegTattooIndex': [value: number]
  'update:rightLegTattooIndex': [value: number]
  continue: []
}>()

const localHeadTattooIndex = ref(appearanceStore.headTattooIndex ?? props.headTattooIndex)
const localNeckTattooIndex = ref(appearanceStore.neckTattooIndex ?? props.neckTattooIndex)
const localTorsoTattooIndex = ref(appearanceStore.torsoTattooIndex ?? props.torsoTattooIndex)
const localBackTattooIndex = ref(appearanceStore.backTattooIndex ?? props.backTattooIndex)
const localLeftArmTattooIndex = ref(appearanceStore.leftArmTattooIndex ?? props.leftArmTattooIndex)
const localRightArmTattooIndex = ref(appearanceStore.rightArmTattooIndex ?? props.rightArmTattooIndex)
const localLeftLegTattooIndex = ref(appearanceStore.leftLegTattooIndex ?? props.leftLegTattooIndex)
const localRightLegTattooIndex = ref(appearanceStore.rightLegTattooIndex ?? props.rightLegTattooIndex)

const saveSectionData = (categoryIndex: number) => {
  switch (categoryIndex) {
    case 0:
      appearanceStore.setHeadTattooSection({ headTattooIndex: localHeadTattooIndex.value })
      break
    case 1:
      appearanceStore.setNeckTattooSection({ neckTattooIndex: localNeckTattooIndex.value })
      break
    case 2:
      appearanceStore.setTorsoTattooSection({ torsoTattooIndex: localTorsoTattooIndex.value })
      break
    case 3:
      appearanceStore.setBackTattooSection({ backTattooIndex: localBackTattooIndex.value })
      break
    case 4:
      appearanceStore.setLeftArmTattooSection({ leftArmTattooIndex: localLeftArmTattooIndex.value })
      break
    case 5:
      appearanceStore.setRightArmTattooSection({ rightArmTattooIndex: localRightArmTattooIndex.value })
      break
    case 6:
      appearanceStore.setLeftLegTattooSection({ leftLegTattooIndex: localLeftLegTattooIndex.value })
      break
    case 7:
      appearanceStore.setRightLegTattooSection({ rightLegTattooIndex: localRightLegTattooIndex.value })
      break
  }
}

// Watch for category changes and save previous section
watch(selectedCategory, (newCategory, oldCategory) => {
  saveSectionData(oldCategory)
  previousCategory.value = oldCategory
})

watch(localHeadTattooIndex, async (newVal) => {
  appearanceStore.setHeadTattooSection({ headTattooIndex: newVal })
  try {
    await sendNuiCallback('applyHeadTattoo', { tattooIndex: newVal })
  } catch (error) {
    console.error('Failed to apply head tattoo:', error)
  }
})

watch(localNeckTattooIndex, async (newVal) => {
  appearanceStore.setNeckTattooSection({ neckTattooIndex: newVal })
  try {
    await sendNuiCallback('applyNeckTattoo', { tattooIndex: newVal })
  } catch (error) {
    console.error('Failed to apply neck tattoo:', error)
  }
})

watch(localTorsoTattooIndex, async (newVal) => {
  appearanceStore.setTorsoTattooSection({ torsoTattooIndex: newVal })
  try {
    await sendNuiCallback('applyTorsoTattoo', { tattooIndex: newVal })
  } catch (error) {
    console.error('Failed to apply torso tattoo:', error)
  }
})

watch(localBackTattooIndex, async (newVal) => {
  appearanceStore.setBackTattooSection({ backTattooIndex: newVal })
  try {
    await sendNuiCallback('applyBackTattoo', { tattooIndex: newVal })
  } catch (error) {
    console.error('Failed to apply back tattoo:', error)
  }
})

watch(localLeftArmTattooIndex, async (newVal) => {
  appearanceStore.setLeftArmTattooSection({ leftArmTattooIndex: newVal })
  try {
    await sendNuiCallback('applyLeftArmTattoo', { tattooIndex: newVal })
  } catch (error) {
    console.error('Failed to apply left arm tattoo:', error)
  }
})

watch(localRightArmTattooIndex, async (newVal) => {
  appearanceStore.setRightArmTattooSection({ rightArmTattooIndex: newVal })
  try {
    await sendNuiCallback('applyRightArmTattoo', { tattooIndex: newVal })
  } catch (error) {
    console.error('Failed to apply right arm tattoo:', error)
  }
})

watch(localLeftLegTattooIndex, async (newVal) => {
  appearanceStore.setLeftLegTattooSection({ leftLegTattooIndex: newVal })
  try {
    await sendNuiCallback('applyLeftLegTattoo', { tattooIndex: newVal })
  } catch (error) {
    console.error('Failed to apply left leg tattoo:', error)
  }
})

watch(localRightLegTattooIndex, async (newVal) => {
  appearanceStore.setRightLegTattooSection({ rightLegTattooIndex: newVal })
  try {
    await sendNuiCallback('applyRightLegTattoo', { tattooIndex: newVal })
  } catch (error) {
    console.error('Failed to apply right leg tattoo:', error)
  }
})

onMounted(async () => {
  try {
    const limitsResponse = (await sendNuiCallback('getTattoosLimits', {})) as {
      totalTattoos: number
    }

    if (limitsResponse) {
      tattooLimit.value = limitsResponse.totalTattoos
    }
  } catch (error) {
    console.error('Failed to get tattoos limits:', error)
  }
})

const handleContinue = () => {
  saveSectionData(selectedCategory.value)

  const tattoosData = {
    headTattooIndex: localHeadTattooIndex.value,
    neckTattooIndex: localNeckTattooIndex.value,
    torsoTattooIndex: localTorsoTattooIndex.value,
    backTattooIndex: localBackTattooIndex.value,
    leftArmTattooIndex: localLeftArmTattooIndex.value,
    rightArmTattooIndex: localRightArmTattooIndex.value,
    leftLegTattooIndex: localLeftLegTattooIndex.value,
    rightLegTattooIndex: localRightLegTattooIndex.value,
  }

  appearanceStore.setTattoos(tattoosData)
  characterStore.setTattoos(tattoosData)

  emit('update:headTattooIndex', localHeadTattooIndex.value)
  emit('update:neckTattooIndex', localNeckTattooIndex.value)
  emit('update:torsoTattooIndex', localTorsoTattooIndex.value)
  emit('update:backTattooIndex', localBackTattooIndex.value)
  emit('update:leftArmTattooIndex', localLeftArmTattooIndex.value)
  emit('update:rightArmTattooIndex', localRightArmTattooIndex.value)
  emit('update:leftLegTattooIndex', localLeftLegTattooIndex.value)
  emit('update:rightLegTattooIndex', localRightLegTattooIndex.value)

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
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.head.tattoo.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.head.tattoo.description') }}
            </p>
            <VSlider
              v-model="localHeadTattooIndex"
              :min="0"
              :max="tattooLimit"
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
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.neck.tattoo.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.neck.tattoo.description') }}
            </p>
            <VSlider
              v-model="localNeckTattooIndex"
              :min="0"
              :max="tattooLimit"
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
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.torso.tattoo.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.torso.tattoo.description') }}
            </p>
            <VSlider
              v-model="localTorsoTattooIndex"
              :min="0"
              :max="tattooLimit"
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
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.back.tattoo.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.back.tattoo.description') }}
            </p>
            <VSlider
              v-model="localBackTattooIndex"
              :min="0"
              :max="tattooLimit"
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
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.leftArm.tattoo.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.leftArm.tattoo.description') }}
            </p>
            <VSlider
              v-model="localLeftArmTattooIndex"
              :min="0"
              :max="tattooLimit"
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
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.rightArm.tattoo.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.rightArm.tattoo.description') }}
            </p>
            <VSlider
              v-model="localRightArmTattooIndex"
              :min="0"
              :max="tattooLimit"
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
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.leftLeg.tattoo.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.leftLeg.tattoo.description') }}
            </p>
            <VSlider
              v-model="localLeftLegTattooIndex"
              :min="0"
              :max="tattooLimit"
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
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.rightLeg.tattoo.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.rightLeg.tattoo.description') }}
            </p>
            <VSlider
              v-model="localRightLegTattooIndex"
              :min="0"
              :max="tattooLimit"
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
