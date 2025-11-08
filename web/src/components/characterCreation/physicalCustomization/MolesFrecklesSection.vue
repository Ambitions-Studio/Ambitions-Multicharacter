<script setup lang="ts">
import { ref, watch, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider } from 'vuetify/components'
import { sendNuiCallback, sendNuiEvent } from '@/utils/nui'

const { t } = useI18n()

const props = withDefaults(
  defineProps<{
    molesFrecklesStyle?: number
    molesFrecklesOpacity?: number
  }>(),
  {
    molesFrecklesStyle: 0,
    molesFrecklesOpacity: 0,
  },
)

const emit = defineEmits<{
  'update:molesFrecklesStyle': [value: number]
  'update:molesFrecklesOpacity': [value: number]
}>()

const localMolesFrecklesStyle = ref(props.molesFrecklesStyle)
const localMolesFrecklesOpacity = ref(props.molesFrecklesOpacity)
const maxMolesFrecklesStyles = ref(17) // Default fallback

// Get customization limits from game
onMounted(async () => {
  const limits = await sendNuiCallback<undefined, { hairStyles: number; hairTextures: number; eyebrowsStyles: number; beardStyles: number; lipstickStyles: number; ageingStyles: number; makeupStyles: number; blushStyles: number; complexionStyles: number; sunDamageStyles: number; molesFrecklesStyles: number }>('getCustomizationLimits')
  if (limits) {
    maxMolesFrecklesStyles.value = limits.molesFrecklesStyles
  }
})

watch([localMolesFrecklesStyle, localMolesFrecklesOpacity], ([style, opacity]) => {
  sendNuiEvent('applyMolesFrecklesCustomization', {
    style,
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
        <span class="text-blue-300 text-sm font-bold">10</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{ t('characterCreation.physicalCustomization.molesFreckles.category') }}</span>
    </div>

    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.molesFreckles.style.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.molesFreckles.style.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localMolesFrecklesStyle }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localMolesFrecklesStyle"
          :min="0"
          :max="maxMolesFrecklesStyles"
          :step="1"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:molesFrecklesStyle', $event)"
        />
      </div>
    </div>

    <div class="bg-slate-800/80 rounded-xl p-5 border-2 border-solid border-slate-900/30 hover:border-slate-900/50 transition-all duration-300">
      <div class="flex items-start justify-between mb-3">
        <div class="flex-1">
          <h4 class="text-white text-base font-bold mb-1">{{ t('characterCreation.physicalCustomization.molesFreckles.opacity.title') }}</h4>
          <p class="text-slate-400 text-xs leading-relaxed">{{ t('characterCreation.physicalCustomization.molesFreckles.opacity.description') }}</p>
        </div>
        <div class="ml-4">
          <span class="inline-block bg-blue-500/20 text-blue-300 text-sm font-bold px-4 py-1.5 rounded-full border border-blue-500/40">
            {{ localMolesFrecklesOpacity.toFixed(2) }}
          </span>
        </div>
      </div>
      <div class="mt-4 pt-2">
        <VSlider
          v-model="localMolesFrecklesOpacity"
          :min="0"
          :max="1"
          :step="0.01"
          track-color="rgba(71, 85, 105, 0.6)"
          color="blue"
          class="w-full"
          hide-details
          thumb-label
          @update:model-value="emit('update:molesFrecklesOpacity', $event)"
        >
          <template #prepend>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.molesFreckles.opacity.min') }}</span>
          </template>
          <template #append>
            <span class="text-xs text-slate-400 font-medium">{{ t('characterCreation.physicalCustomization.molesFreckles.opacity.max') }}</span>
          </template>
        </VSlider>
      </div>
    </div>
  </div>
</template>
