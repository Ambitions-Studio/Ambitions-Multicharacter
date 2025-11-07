<script setup lang="ts">
import { ref, watch } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider } from 'vuetify/components'
import HAIR_COLORS from '@/data/hairColors'
import { sendNuiEvent } from '@/utils/nui'

const { t } = useI18n()

const props = withDefaults(
  defineProps<{
    beardStyle?: number
    beardColor?: number
    beardSecondaryColor?: number
    beardOpacity?: number
  }>(),
  {
    beardStyle: 0,
    beardColor: 0,
    beardSecondaryColor: 0,
    beardOpacity: 1,
  },
)

const emit = defineEmits<{
  'update:beardStyle': [value: number]
  'update:beardColor': [value: number]
  'update:beardSecondaryColor': [value: number]
  'update:beardOpacity': [value: number]
}>()

const localBeardStyle = ref(props.beardStyle)
const localBeardColor = ref(props.beardColor)
const localBeardSecondaryColor = ref(props.beardSecondaryColor)
const localBeardOpacity = ref(props.beardOpacity)

watch([localBeardStyle, localBeardColor, localBeardSecondaryColor, localBeardOpacity], ([style, color, secondaryColor, opacity]) => {
  sendNuiEvent('applyBeardCustomization', {
    style,
    color,
    secondaryColor,
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
        <span class="text-blue-300 text-sm font-bold">03</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{ t('characterCreation.physicalCustomization.beard.category') }}</span>
    </div>

    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.beard.style.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.beard.style.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localBeardStyle }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localBeardStyle"
          :min="0"
          :max="28"
          :step="1"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:beardStyle', $event)"
        />
      </div>
    </div>

    <!-- Beard Color -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.beard.color.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.beard.color.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localBeardColor }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2 flex flex-wrap gap-2">
        <button
          v-for="(color, index) in HAIR_COLORS"
          :key="index"
          class="w-6 h-6 rounded-full border-2 transition-all duration-200 hover:scale-110"
          :class="localBeardColor === index ? 'border-white shadow-lg shadow-white/50' : 'border-slate-600 hover:border-slate-400'"
          :style="{ backgroundColor: color }"
          @click="localBeardColor = index; emit('update:beardColor', index)"
        />
      </div>
    </div>

    <!-- Beard Secondary Color -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.beard.secondaryColor.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.beard.secondaryColor.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localBeardSecondaryColor }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2 flex flex-wrap gap-2">
        <button
          v-for="(color, index) in HAIR_COLORS"
          :key="index"
          class="w-6 h-6 rounded-full border-2 transition-all duration-200 hover:scale-110"
          :class="localBeardSecondaryColor === index ? 'border-white shadow-lg shadow-white/50' : 'border-slate-600 hover:border-slate-400'"
          :style="{ backgroundColor: color }"
          @click="localBeardSecondaryColor = index; emit('update:beardSecondaryColor', index)"
        />
      </div>
    </div>

    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.beard.opacity.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.beard.opacity.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localBeardOpacity.toFixed(2) }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localBeardOpacity"
          :min="0"
          :max="1"
          :step="0.01"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:beardOpacity', $event)"
        >
          <template #prepend>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.beard.opacity.min') }}</span>
          </template>
          <template #append>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.beard.opacity.max') }}</span>
          </template>
        </VSlider>
      </div>
    </div>
  </div>
</template>
