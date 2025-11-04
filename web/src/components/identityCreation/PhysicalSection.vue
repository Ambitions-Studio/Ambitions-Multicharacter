<script setup lang="ts">
import { useI18n } from 'vue-i18n'

const { t } = useI18n()

const props = defineProps<{
  height: number
}>()

const emit = defineEmits<{
  'update:height': [value: number]
}>()

const validate = () => {
  return true
}

defineExpose({
  validate,
})
</script>

<template>
  <div class="space-y-4 fhd:space-y-3 2k:space-y-6">
    <div class="flex items-center space-x-3 mb-6 fhd:mb-4">
      <div
        class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-slate-500/40 flex items-center justify-center"
      >
        <span class="text-slate-300 text-sm font-bold">04</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{
        t('identityCreation.sections.physical')
      }}</span>
    </div>

    <div class="space-y-4 fhd:space-y-3 2k:space-y-6">
      <div class="flex items-center justify-between px-2">
        <span class="text-slate-200 text-sm font-medium">{{
          t('identityCreation.fields.height')
        }}</span>
        <span class="text-blue-300 text-lg font-bold">{{ props.height }} cm</span>
      </div>
      <VSlider
        :model-value="props.height"
        :min="120"
        :max="220"
        :step="1"
        thumb-label="always"
        track-color="rgba(71, 85, 105, 0.6)"
        color="blue"
        class="w-full"
        @update:model-value="emit('update:height', $event)"
      />
    </div>
  </div>
</template>
