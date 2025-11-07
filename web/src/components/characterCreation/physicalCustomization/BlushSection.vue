<script setup lang="ts">
import { ref, watch, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider } from 'vuetify/components'
import MAKEUP_COLORS from '@/data/makeupColors'
import { sendNuiCallback, sendNuiEvent } from '@/utils/nui'

const { t } = useI18n()

const props = withDefaults(
  defineProps<{
    blushStyle?: number
    blushColor?: number
    blushOpacity?: number
  }>(),
  {
    blushStyle: 0,
    blushColor: 0,
    blushOpacity: 0,
  },
)

const emit = defineEmits<{
  'update:blushStyle': [value: number]
  'update:blushColor': [value: number]
  'update:blushOpacity': [value: number]
}>()

const localBlushStyle = ref(props.blushStyle)
const localBlushColor = ref(props.blushColor)
const localBlushOpacity = ref(props.blushOpacity)
const maxBlushStyles = ref(6) // Default fallback

// Get customization limits from game
onMounted(async () => {
  const limits = await sendNuiCallback<undefined, { hairStyles: number; hairTextures: number; eyebrowsStyles: number; beardStyles: number; lipstickStyles: number; ageingStyles: number; makeupStyles: number; blushStyles: number }>('getCustomizationLimits')
  if (limits) {
    maxBlushStyles.value = limits.blushStyles
  }
})

watch([localBlushStyle, localBlushColor, localBlushOpacity], ([style, color, opacity]) => {
  sendNuiEvent('applyBlushCustomization', {
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
        <span class="text-blue-300 text-sm font-bold">06</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{ t('characterCreation.physicalCustomization.blush.category') }}</span>
    </div>

    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.blush.style.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.blush.style.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localBlushStyle }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localBlushStyle"
          :min="0"
          :max="maxBlushStyles"
          :step="1"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:blushStyle', $event)"
        />
      </div>
    </div>

    <!-- Blush Color -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.blush.color.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.blush.color.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localBlushColor }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2 flex flex-wrap gap-2">
        <button
          v-for="(color, index) in MAKEUP_COLORS"
          :key="index"
          class="w-6 h-6 rounded-full border-2 transition-all duration-200 hover:scale-110"
          :class="localBlushColor === index ? 'border-white shadow-lg shadow-white/50' : 'border-slate-600 hover:border-slate-400'"
          :style="{ backgroundColor: color }"
          @click="localBlushColor = index; emit('update:blushColor', index)"
        />
      </div>
    </div>

    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.blush.opacity.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.blush.opacity.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localBlushOpacity.toFixed(2) }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localBlushOpacity"
          :min="0"
          :max="1"
          :step="0.01"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:blushOpacity', $event)"
        >
          <template #prepend>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.blush.opacity.min') }}</span>
          </template>
          <template #append>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.blush.opacity.max') }}</span>
          </template>
        </VSlider>
      </div>
    </div>
  </div>
</template>
