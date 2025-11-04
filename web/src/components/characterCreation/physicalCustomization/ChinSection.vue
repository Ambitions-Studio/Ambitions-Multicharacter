<script setup lang="ts">
import { ref } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider } from 'vuetify/components'

const { t } = useI18n()

const props = withDefaults(
  defineProps<{
    chinLowering?: number
    chinLength?: number
    chinWidth?: number
    chinCleft?: number
  }>(),
  {
    chinLowering: 0,
    chinLength: 0,
    chinWidth: 0,
    chinCleft: 0,
  },
)

const emit = defineEmits<{
  'update:chinLowering': [value: number]
  'update:chinLength': [value: number]
  'update:chinWidth': [value: number]
  'update:chinCleft': [value: number]
}>()

const localChinLowering = ref(props.chinLowering)
const localChinLength = ref(props.chinLength)
const localChinWidth = ref(props.chinWidth)
const localChinCleft = ref(props.chinCleft)
</script>

<template>
  <div class="space-y-6 fhd:space-y-5 2k:space-y-8">
    <div class="flex items-center space-x-3 mb-8 fhd:mb-6">
      <div
        class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center"
      >
        <span class="text-blue-300 text-sm font-bold">09</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{ t('characterCreation.physicalCustomization.chin.category') }}</span>
    </div>

    <!-- Chin Lowering -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.chin.lowering.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.chin.lowering.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localChinLowering.toFixed(2) }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localChinLowering"
          :min="-1"
          :max="1"
          :step="0.01"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:chinLowering', $event)"
        >
          <template #prepend>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.chin.lowering.min') }}</span>
          </template>
          <template #append>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.chin.lowering.max') }}</span>
          </template>
        </VSlider>
      </div>
    </div>

    <!-- Chin Length -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.chin.length.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.chin.length.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localChinLength.toFixed(2) }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localChinLength"
          :min="-1"
          :max="1"
          :step="0.01"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:chinLength', $event)"
        >
          <template #prepend>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.chin.length.min') }}</span>
          </template>
          <template #append>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.chin.length.max') }}</span>
          </template>
        </VSlider>
      </div>
    </div>

    <!-- Chin Width -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.chin.width.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.chin.width.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localChinWidth.toFixed(2) }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localChinWidth"
          :min="-1"
          :max="1"
          :step="0.01"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:chinWidth', $event)"
        >
          <template #prepend>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.chin.width.min') }}</span>
          </template>
          <template #append>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.chin.width.max') }}</span>
          </template>
        </VSlider>
      </div>
    </div>

    <!-- Chin Cleft -->
    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.chin.cleft.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.chin.cleft.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localChinCleft.toFixed(2) }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localChinCleft"
          :min="-1"
          :max="1"
          :step="0.01"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:chinCleft', $event)"
        >
          <template #prepend>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.chin.cleft.min') }}</span>
          </template>
          <template #append>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.chin.cleft.max') }}</span>
          </template>
        </VSlider>
      </div>
    </div>
  </div>
</template>
