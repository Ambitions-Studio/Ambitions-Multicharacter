<script setup lang="ts">
import { ref, computed } from 'vue'
import { useI18n } from 'vue-i18n'
import { mdiFaceMan, mdiPalette } from '@/icons'
import { useAppearanceStore } from '@/stores/useAppearanceStore'
import { useCharacterStore } from '@/stores/useCharacterStore'

const { t } = useI18n()
const appearanceStore = useAppearanceStore()
const characterStore = useCharacterStore()

export interface ParentOption {
  id: number
  name: string
  photo?: string
}

interface Props {
  fatherOptions?: ParentOption[]
  motherOptions?: ParentOption[]
  selectedFather?: number
  selectedMother?: number
  faceResemblance?: number
  skinResemblance?: number
}

const props = withDefaults(defineProps<Props>(), {
  fatherOptions: () => [],
  motherOptions: () => [],
  selectedFather: 0,
  selectedMother: 0,
  faceResemblance: 0.5,
  skinResemblance: 0.5,
})

const emit = defineEmits<{
  'update:selectedFather': [value: number]
  'update:selectedMother': [value: number]
  'update:faceResemblance': [value: number]
  'update:skinResemblance': [value: number]
  continue: []
}>()

// Initialize from store if available, otherwise use props or first item
const localSelectedFather = ref(
  appearanceStore.selectedFather ?? props.selectedFather ?? props.fatherOptions[0]?.id ?? 0
)
const localSelectedMother = ref(
  appearanceStore.selectedMother ?? props.selectedMother ?? props.motherOptions[0]?.id ?? 21
)
const localFaceResemblance = ref(
  appearanceStore.faceResemblance ?? props.faceResemblance
)
const localSkinResemblance = ref(
  appearanceStore.skinResemblance ?? props.skinResemblance
)

// Get portrait image URL from public directory (no hashing)
const getPortraitUrl = (photoFilename: string) => {
  return `images/parent_portrait/${photoFilename}`
}

// Computed refs for selected parents to avoid multiple .find() calls
const selectedFatherData = computed(() =>
  props.fatherOptions.find((f) => f.id === localSelectedFather.value)
)

const selectedMotherData = computed(() =>
  props.motherOptions.find((m) => m.id === localSelectedMother.value)
)

const handleContinue = () => {
  // Save to AppearanceStore
  appearanceStore.setSelectedFather(localSelectedFather.value)
  appearanceStore.setSelectedMother(localSelectedMother.value)
  appearanceStore.setFaceResemblance(localFaceResemblance.value)
  appearanceStore.setSkinResemblance(localSkinResemblance.value)

  // Update ONLY heritage in character store
  characterStore.setHeritage({
    father: localSelectedFather.value,
    mother: localSelectedMother.value,
    faceResemblance: localFaceResemblance.value,
    skinResemblance: localSkinResemblance.value,
  })

  emit('update:selectedFather', localSelectedFather.value)
  emit('update:selectedMother', localSelectedMother.value)
  emit('update:faceResemblance', localFaceResemblance.value)
  emit('update:skinResemblance', localSkinResemblance.value)
  emit('continue')
}
</script>

<template>
  <div class="space-y-6 h-[73vh] overflow-y-scroll pr-2 pb-20">
    <div class="flex items-center space-x-3 mb-6">
      <div
        class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center"
      >
        <span class="text-blue-300 text-sm font-bold">02</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{
        t('characterCreation.heritage.title')
      }}</span>
    </div>

    <!-- Parents Selection Section -->
    <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
      <div class="text-center mb-4">
        <h3 class="text-white text-xl font-bold mb-2">
          {{ t('characterCreation.heritage.parentSelection') }}
        </h3>
        <p class="text-slate-400 text-sm">
          {{ t('characterCreation.heritage.parentSelectionDescription') }}
        </p>
      </div>

      <!-- Father and Mother Selection -->
      <div class="grid grid-cols-2 gap-8">
        <!-- Father Selection -->
        <div class="space-y-4">
          <div class="text-center">
            <!-- Father Portrait -->
            <div
              class="w-16 h-16 mx-auto mb-3 rounded-full border-2 border-blue-400/50 overflow-hidden bg-slate-700/50"
            >
              <img
                v-if="selectedFatherData?.photo"
                :src="getPortraitUrl(selectedFatherData.photo)"
                :alt="selectedFatherData.name"
                class="w-full h-full object-cover"
              />
              <div
                v-else
                class="w-full h-full bg-gradient-to-br from-blue-600/20 to-blue-800/20 flex items-center justify-center"
              >
                <span class="text-blue-400 text-xs font-medium">Photo</span>
              </div>
            </div>

            <h4 class="text-white text-lg font-semibold">
              {{ t('characterCreation.heritage.father') }}
            </h4>
          </div>
          <VSelect
            v-model="localSelectedFather"
            :items="fatherOptions"
            item-title="name"
            item-value="id"
            variant="outlined"
            density="compact"
            class="text-white"
            color="blue"
            base-color="blue-300"
            bg-color="rgba(30, 41, 59, 0.4)"
            hide-details
          />
        </div>

        <!-- Mother Selection -->
        <div class="space-y-4">
          <div class="text-center">
            <!-- Mother Portrait -->
            <div
              class="w-16 h-16 mx-auto mb-3 rounded-full border-2 border-pink-400/50 overflow-hidden bg-slate-700/50"
            >
              <img
                v-if="selectedMotherData?.photo"
                :src="getPortraitUrl(selectedMotherData.photo)"
                :alt="selectedMotherData.name"
                class="w-full h-full object-cover"
              />
              <div
                v-else
                class="w-full h-full bg-gradient-to-br from-pink-600/20 to-pink-800/20 flex items-center justify-center"
              >
                <span class="text-pink-400 text-xs font-medium">Photo</span>
              </div>
            </div>

            <h4 class="text-white text-lg font-semibold">
              {{ t('characterCreation.heritage.mother') }}
            </h4>
          </div>
          <VSelect
            v-model="localSelectedMother"
            :items="motherOptions"
            item-title="name"
            item-value="id"
            variant="outlined"
            density="compact"
            class="text-white"
            color="blue"
            base-color="blue-300"
            bg-color="rgba(30, 41, 59, 0.4)"
            hide-details
          />
        </div>
      </div>
    </div>

    <!-- Resemblance Controls -->
    <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-8">
      <div class="text-center mb-6">
        <h3 class="text-white text-xl font-bold mb-2">
          {{ t('characterCreation.heritage.geneticResemblance') }}
        </h3>
        <p class="text-slate-400 text-sm">
          {{ t('characterCreation.heritage.geneticResemblanceDescription') }}
        </p>
      </div>

      <!-- Face Resemblance Slider -->
      <div class="space-y-4">
        <div class="flex items-center justify-between">
          <div class="flex items-center space-x-2">
            <span class="text-white text-base font-semibold">{{
              t('characterCreation.heritage.resemblance.face')
            }}</span>
            <VIcon :icon="mdiFaceMan" class="text-blue-400" size="small" />
          </div>
          <span
            class="text-blue-300 text-sm font-bold bg-blue-500/20 px-3 py-1 rounded-full border border-blue-500/30"
          >
            {{
              t('characterCreation.heritage.resemblance.percentageFather', {
                father: Math.round((1 - localFaceResemblance) * 100),
              })
            }}
            {{ t('characterCreation.heritage.resemblance.percentageSeparator') }}
            {{
              t('characterCreation.heritage.resemblance.percentageMother', {
                mother: Math.round(localFaceResemblance * 100),
              })
            }}
          </span>
        </div>
        <div class="relative bg-slate-700/30 rounded-lg p-4">
          <div class="flex items-center justify-between text-xs text-slate-400 mb-3">
            <div class="flex items-center space-x-1">
              <div class="w-3 h-3 rounded-full bg-blue-500"></div>
              <span>{{ t('characterCreation.heritage.resemblance.fatherDominant') }}</span>
            </div>
            <span class="text-slate-300 font-medium">{{
              t('characterCreation.heritage.resemblance.balanced')
            }}</span>
            <div class="flex items-center space-x-1">
              <span>{{ t('characterCreation.heritage.resemblance.motherDominant') }}</span>
              <div class="w-3 h-3 rounded-full bg-pink-500"></div>
            </div>
          </div>
          <VSlider
            v-model="localFaceResemblance"
            :min="0"
            :max="1"
            :step="0.01"
            track-color="rgba(71, 85, 105, 0.6)"
            color="blue"
            class="w-full"
            hide-details
          />
        </div>
      </div>

      <!-- Skin Tone Resemblance Slider -->
      <div class="space-y-4">
        <div class="flex items-center justify-between">
          <div class="flex items-center space-x-2">
            <span class="text-white text-base font-semibold">{{
              t('characterCreation.heritage.resemblance.skin')
            }}</span>
            <VIcon :icon="mdiPalette" class="text-pink-400" size="small" />
          </div>
          <span
            class="text-pink-300 text-sm font-bold bg-pink-500/20 px-3 py-1 rounded-full border border-pink-500/30"
          >
            {{
              t('characterCreation.heritage.resemblance.percentageFather', {
                father: Math.round((1 - localSkinResemblance) * 100),
              })
            }}
            {{ t('characterCreation.heritage.resemblance.percentageSeparator') }}
            {{
              t('characterCreation.heritage.resemblance.percentageMother', {
                mother: Math.round(localSkinResemblance * 100),
              })
            }}
          </span>
        </div>
        <div class="relative bg-slate-700/30 rounded-lg p-4">
          <div class="flex items-center justify-between text-xs text-slate-400 mb-3">
            <div class="flex items-center space-x-1">
              <div class="w-3 h-3 rounded-full bg-blue-500"></div>
              <span>{{ t('characterCreation.heritage.resemblance.fatherTone') }}</span>
            </div>
            <span class="text-slate-300 font-medium">{{
              t('characterCreation.heritage.resemblance.blended')
            }}</span>
            <div class="flex items-center space-x-1">
              <span>{{ t('characterCreation.heritage.resemblance.motherTone') }}</span>
              <div class="w-3 h-3 rounded-full bg-pink-500"></div>
            </div>
          </div>
          <VSlider
            v-model="localSkinResemblance"
            :min="0"
            :max="1"
            :step="0.01"
            track-color="rgba(71, 85, 105, 0.6)"
            color="pink"
            class="w-full"
            hide-details
          />
        </div>
      </div>
    </div>

    <!-- Continue Button for Heritage -->
    <div class="mt-8 flex justify-end pr-6">
      <VBtn
        variant="outlined"
        size="large"
        class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
        elevation="0"
        @click="handleContinue"
      >
        <span class="text-base tracking-wide uppercase">{{
          t('characterCreation.heritage.continue')
        }}</span>
      </VBtn>
    </div>
  </div>
</template>
