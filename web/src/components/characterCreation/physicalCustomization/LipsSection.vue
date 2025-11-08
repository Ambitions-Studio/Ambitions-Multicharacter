<script setup lang="ts">
import { ref, watch, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider } from 'vuetify/components'
import MAKEUP_COLORS from '@/data/makeupColors'
import { sendNuiCallback, sendNuiEvent } from '@/utils/nui'

const { t } = useI18n()

const props = withDefaults(
  defineProps<{
    lipThickness?: number
    lipstickStyle?: number
    lipstickColor?: number
    lipstickOpacity?: number
  }>(),
  {
    lipThickness: 0,
    lipstickStyle: 0,
    lipstickColor: 0,
    lipstickOpacity: 0,
  },
)

const emit = defineEmits<{
  'update:lipThickness': [value: number]
  'update:lipstickStyle': [value: number]
  'update:lipstickColor': [value: number]
  'update:lipstickOpacity': [value: number]
}>()

const localLipThickness = ref(props.lipThickness)
const localLipstickStyle = ref(props.lipstickStyle)
const localLipstickColor = ref(props.lipstickColor)
const localLipstickOpacity = ref(props.lipstickOpacity)
const maxLipstickStyles = ref(9) // Default fallback

// Get customization limits from game
onMounted(async () => {
  const limits = await sendNuiCallback<undefined, { hairStyles: number; hairTextures: number; eyebrowsStyles: number; beardStyles: number; lipstickStyles: number }>('getCustomizationLimits')
  if (limits) {
    maxLipstickStyles.value = limits.lipstickStyles
  }
})

watch([localLipThickness, localLipstickStyle, localLipstickColor, localLipstickOpacity], ([thickness, style, color, opacity]) => {
  sendNuiEvent('applyLipsCustomization', {
    thickness,
    style,
    color,
    opacity,
  })
})
</script>

<template>
  <div class="space-y-6 fhd:space-y-5 2k:space-y-8">
    <div class="flex items-center space-x-3 mb-8 fhd:mb-6">
      <div
        class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center"
      >
        <span class="text-blue-300 text-sm font-bold">08</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{ t('characterCreation.physicalCustomization.lips.category') }}</span>
    </div>

    <!-- Lip Thickness (Facial Feature) -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.lips.thickness.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.lips.thickness.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localLipThickness.toFixed(2) }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localLipThickness"
          :min="-1"
          :max="1"
          :step="0.01"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:lipThickness', $event)"
        >
          <template #prepend>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.lips.thickness.min') }}</span>
          </template>
          <template #append>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.lips.thickness.max') }}</span>
          </template>
        </VSlider>
      </div>
    </div>

    <!-- Lipstick Style (Overlay) -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.lips.lipstickStyle.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.lips.lipstickStyle.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localLipstickStyle }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localLipstickStyle"
          :min="0"
          :max="maxLipstickStyles"
          :step="1"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:lipstickStyle', $event)"
        />
      </div>
    </div>

    <!-- Lipstick Color (Overlay) -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.lips.lipstickColor.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.lips.lipstickColor.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localLipstickColor }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2 flex flex-wrap gap-2">
        <button
          v-for="(color, index) in MAKEUP_COLORS"
          :key="index"
          class="w-6 h-6 rounded-full border-2 transition-all duration-200 hover:scale-110"
          :class="localLipstickColor === index ? 'border-white shadow-lg shadow-white/50' : 'border-slate-600 hover:border-slate-400'"
          :style="{ backgroundColor: color }"
          @click="localLipstickColor = index; emit('update:lipstickColor', index)"
        />
      </div>
    </div>

    <!-- Lipstick Opacity (Overlay) -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.lips.lipstickOpacity.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.lips.lipstickOpacity.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localLipstickOpacity.toFixed(2) }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localLipstickOpacity"
          :min="0"
          :max="1"
          :step="0.01"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:lipstickOpacity', $event)"
        >
          <template #prepend>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.lips.lipstickOpacity.min') }}</span>
          </template>
          <template #append>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.lips.lipstickOpacity.max') }}</span>
          </template>
        </VSlider>
      </div>
    </div>
  </div>
</template>
