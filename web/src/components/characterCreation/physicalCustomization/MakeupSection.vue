<script setup lang="ts">
import { ref, watch, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider } from 'vuetify/components'
import MAKEUP_COLORS from '@/data/makeupColors'
import { sendNuiCallback, sendNuiEvent } from '@/utils/nui'

const { t } = useI18n()

const props = withDefaults(
  defineProps<{
    makeupStyle?: number
    makeupPrimaryColor?: number
    makeupSecondaryColor?: number
    makeupOpacity?: number
  }>(),
  {
    makeupStyle: 0,
    makeupPrimaryColor: 0,
    makeupSecondaryColor: 0,
    makeupOpacity: 0,
  },
)

const emit = defineEmits<{
  'update:makeupStyle': [value: number]
  'update:makeupPrimaryColor': [value: number]
  'update:makeupSecondaryColor': [value: number]
  'update:makeupOpacity': [value: number]
}>()

const localMakeupStyle = ref(props.makeupStyle)
const localMakeupPrimaryColor = ref(props.makeupPrimaryColor)
const localMakeupSecondaryColor = ref(props.makeupSecondaryColor)
const localMakeupOpacity = ref(props.makeupOpacity)
const maxMakeupStyles = ref(74)

onMounted(async () => {
  const limits = await sendNuiCallback<undefined, { hairStyles: number; hairTextures: number; eyebrowsStyles: number; beardStyles: number; lipstickStyles: number; ageingStyles: number; makeupStyles: number }>('getCustomizationLimits')
  if (limits) {
    maxMakeupStyles.value = limits.makeupStyles
  }
})

watch([localMakeupStyle, localMakeupPrimaryColor, localMakeupSecondaryColor, localMakeupOpacity], ([style, primaryColor, secondaryColor, opacity]) => {
  sendNuiEvent('applyMakeupCustomization', {
    style,
    primaryColor,
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
        <span class="text-blue-300 text-sm font-bold">05</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{ t('characterCreation.physicalCustomization.makeup.category') }}</span>
    </div>

    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.makeup.style.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.makeup.style.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localMakeupStyle }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localMakeupStyle"
          :min="0"
          :max="maxMakeupStyles"
          :step="1"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:makeupStyle', $event)"
        />
      </div>
    </div>

    <!-- Makeup Primary Color -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.makeup.primaryColor.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.makeup.primaryColor.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localMakeupPrimaryColor }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2 flex flex-wrap gap-2">
        <button
          v-for="(color, index) in MAKEUP_COLORS"
          :key="index"
          class="w-6 h-6 rounded-full border-2 transition-all duration-200 hover:scale-110"
          :class="localMakeupPrimaryColor === index ? 'border-white shadow-lg shadow-white/50' : 'border-slate-600 hover:border-slate-400'"
          :style="{ backgroundColor: color }"
          @click="localMakeupPrimaryColor = index; emit('update:makeupPrimaryColor', index)"
        />
      </div>
    </div>

    <!-- Makeup Secondary Color -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.makeup.secondaryColor.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.makeup.secondaryColor.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localMakeupSecondaryColor }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2 flex flex-wrap gap-2">
        <button
          v-for="(color, index) in MAKEUP_COLORS"
          :key="index"
          class="w-6 h-6 rounded-full border-2 transition-all duration-200 hover:scale-110"
          :class="localMakeupSecondaryColor === index ? 'border-white shadow-lg shadow-white/50' : 'border-slate-600 hover:border-slate-400'"
          :style="{ backgroundColor: color }"
          @click="localMakeupSecondaryColor = index; emit('update:makeupSecondaryColor', index)"
        />
      </div>
    </div>

    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.makeup.opacity.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.makeup.opacity.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localMakeupOpacity.toFixed(2) }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localMakeupOpacity"
          :min="0"
          :max="1"
          :step="0.01"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:makeupOpacity', $event)"
        >
          <template #prepend>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.makeup.opacity.min') }}</span>
          </template>
          <template #append>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.makeup.opacity.max') }}</span>
          </template>
        </VSlider>
      </div>
    </div>
  </div>
</template>
