<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider } from 'vuetify/components'
import HAIR_COLORS from '@/data/hairColors'
import { sendNuiCallback, sendNuiEvent } from '@/utils/nui'

const { t } = useI18n()

const props = withDefaults(
  defineProps<{
    hairStyle?: number
    hairColor?: number
    hairHighlight?: number
  }>(),
  {
    hairStyle: 0,
    hairColor: 0,
    hairHighlight: 0,
  },
)

const emit = defineEmits<{
  'update:hairStyle': [value: number]
  'update:hairColor': [value: number]
  'update:hairHighlight': [value: number]
}>()

const localHairStyle = ref(props.hairStyle)
const localHairColor = ref(props.hairColor)
const localHairHighlight = ref(props.hairHighlight)
const maxHairStyles = ref(78) // Default fallback

// Get customization limits from game
onMounted(async () => {
  const limits = await sendNuiCallback<undefined, { hairStyles: number; hairTextures: number }>('getCustomizationLimits')
  if (limits) {
    maxHairStyles.value = limits.hairStyles
  }
})

// Watch for hair changes and apply in real-time
watch([localHairStyle, localHairColor, localHairHighlight], ([style, color, highlight]) => {
  sendNuiEvent('applyHairStyle', {
    style,
    color,
    highlight,
  })
})
</script>

<template>
  <div class="space-y-6 fhd:space-y-5 2k:space-y-8">
    <div class="flex items-center space-x-3 mb-8 fhd:mb-6">
      <div
        class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center"
      >
        <span class="text-blue-300 text-sm font-bold">01</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{ t('characterCreation.physicalCustomization.hair.category') }}</span>
    </div>

    <!-- Hair Style -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.hair.style.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.hair.style.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localHairStyle }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localHairStyle"
          :min="0"
          :max="maxHairStyles"
          :step="1"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:hairStyle', $event)"
        />
      </div>
    </div>

    <!-- Hair Color (Primary) -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.hair.color.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.hair.color.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localHairColor }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2 flex flex-wrap gap-2">
        <button
          v-for="(color, index) in HAIR_COLORS"
          :key="index"
          class="w-6 h-6 rounded-full border-2 transition-all duration-200 hover:scale-110"
          :class="localHairColor === index ? 'border-white shadow-lg shadow-white/50' : 'border-slate-600 hover:border-slate-400'"
          :style="{ backgroundColor: color }"
          @click="localHairColor = index; emit('update:hairColor', index)"
        />
      </div>
    </div>

    <!-- Hair Highlight (Secondary Color) -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.hair.highlight.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.hair.highlight.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localHairHighlight }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2 flex flex-wrap gap-2">
        <button
          v-for="(color, index) in HAIR_COLORS"
          :key="index"
          class="w-6 h-6 rounded-full border-2 transition-all duration-200 hover:scale-110"
          :class="localHairHighlight === index ? 'border-white shadow-lg shadow-white/50' : 'border-slate-600 hover:border-slate-400'"
          :style="{ backgroundColor: color }"
          @click="localHairHighlight = index; emit('update:hairHighlight', index)"
        />
      </div>
    </div>
  </div>
</template>
