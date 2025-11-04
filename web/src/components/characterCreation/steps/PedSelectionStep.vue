<script setup lang="ts">
import { ref } from 'vue'
import { useI18n } from 'vue-i18n'
import { useAppearanceStore } from '@/stores/useAppearanceStore'
import { useCharacterStore } from '@/stores/useCharacterStore'

const { t } = useI18n()
const appearanceStore = useAppearanceStore()
const characterStore = useCharacterStore()

export interface PedModel {
  title: string
  value: string
  category: string
}

interface Props {
  pedModels: PedModel[]
  modelValue?: string | null
}

const props = withDefaults(defineProps<Props>(), {
  modelValue: null,
})

const emit = defineEmits<{
  'update:modelValue': [value: string | null]
  continue: []
}>()

// Initialize from store if available, otherwise use props or null
const selectedPed = ref<string | null>(
  appearanceStore.selectedPed ?? props.modelValue ?? null
)
const pedSelectionError = ref('')

const validatePedSelection = (): boolean => {
  pedSelectionError.value = ''
  if (!selectedPed.value) {
    pedSelectionError.value = 'Please select a ped model to continue'
    return false
  }
  return true
}

const handleContinue = () => {
  if (!validatePedSelection()) {
    return
  }

  // Save to appearance store
  appearanceStore.setSelectedPed(selectedPed.value)

  // Update ONLY ped selection in character store
  characterStore.setPedSelection({ selectedPed: selectedPed.value })

  emit('update:modelValue', selectedPed.value)
  emit('continue')
}

const handlePedChange = (value: string | null) => {
  selectedPed.value = value
  pedSelectionError.value = ''
  emit('update:modelValue', value)
}
</script>

<template>
  <div class="space-y-6">
    <div class="flex items-center space-x-3 mb-6">
      <div
        class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center"
      >
        <span class="text-blue-300 text-sm font-bold">01</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{
        t('characterCreation.pedSelection.title')
      }}</span>
    </div>

    <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
      <VSelect
        :model-value="selectedPed"
        :items="pedModels"
        :label="t('characterCreation.pedSelection.selectPed')"
        item-title="title"
        item-value="value"
        variant="outlined"
        density="comfortable"
        class="text-white"
        color="blue"
        base-color="blue-300"
        bg-color="rgba(30, 41, 59, 0.4)"
        hide-details
        clearable
        @update:model-value="handlePedChange"
      >
        <template #item="{ props: itemProps, item }">
          <VListItem
            v-bind="itemProps"
            :title="item.raw.title"
            :subtitle="item.raw.category"
            class="!bg-slate-800/80 hover:!bg-slate-700/80 !text-white border-b border-slate-600/20"
          >
            <template #prepend>
              <div class="w-3 h-3 rounded-full bg-blue-400/60 mr-3"></div>
            </template>
          </VListItem>
        </template>
      </VSelect>

      <div
        v-if="selectedPed"
        class="mt-4 p-4 bg-slate-700/50 rounded-lg border border-blue-500/20"
      >
        <div class="flex items-center justify-between">
          <div>
            <p class="text-white font-medium">
              {{ t('characterCreation.pedSelection.selectedModel') }}
            </p>
            <p class="text-slate-300 text-sm">
              {{ pedModels.find((p) => p.value === selectedPed)?.title }}
            </p>
          </div>
          <div class="text-right">
            <p class="text-slate-400 text-xs">{{ t('characterCreation.pedSelection.category') }}</p>
            <p class="text-blue-300 text-sm font-medium">
              {{ pedModels.find((p) => p.value === selectedPed)?.category }}
            </p>
          </div>
        </div>
      </div>

      <p v-if="pedSelectionError" class="text-xs text-red-400 ml-2 mt-2">
        {{ pedSelectionError }}
      </p>
    </div>

    <div class="mt-8 flex justify-end pr-6">
      <VBtn
        variant="outlined"
        size="large"
        class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
        elevation="0"
        @click="handleContinue"
      >
        <span class="text-base tracking-wide uppercase">{{
          t('characterCreation.pedSelection.continue')
        }}</span>
      </VBtn>
    </div>
  </div>
</template>
