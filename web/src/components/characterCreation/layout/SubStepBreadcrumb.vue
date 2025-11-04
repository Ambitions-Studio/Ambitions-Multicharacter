<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import { mdiChevronRight } from '@/icons'

const { t } = useI18n()

export interface SubStep {
  key: string
  titleKey?: string
  title?: string
}

interface Props {
  subSteps: SubStep[]
  currentSubStep: number
}

const props = defineProps<Props>()

const emit = defineEmits<{
  'update:currentSubStep': [value: number]
  subStepChange: [newSubStep: number, oldSubStep: number]
}>()

const handleSubStepClick = (index: number) => {
  if (index < props.currentSubStep) {
    const oldSubStep = props.currentSubStep
    emit('update:currentSubStep', index)
    emit('subStepChange', index, oldSubStep)
  }
}

const getSubStepTitle = (subStep: SubStep): string => {
  if (subStep.titleKey) {
    return t(subStep.titleKey)
  }
  return subStep.title || subStep.key
}
</script>

<template>
  <div class="mb-8">
    <div
      class="flex flex-wrap items-center gap-x-2 gap-y-2 text-xs pl-4 border-l-2 border-blue-500/30"
    >
      <template v-for="(subStep, index) in subSteps" :key="subStep.key">
        <template v-if="index <= currentSubStep">
          <button
            :class="[
              'transition-all',
              {
                'text-blue-400 font-semibold': index === currentSubStep,
                'text-slate-500 opacity-60 hover:text-slate-400 hover:opacity-80 cursor-pointer':
                  index < currentSubStep,
              },
            ]"
            @click="handleSubStepClick(index)"
          >
            {{ getSubStepTitle(subStep) }}
          </button>
          <VIcon
            v-if="index < currentSubStep"
            :icon="mdiChevronRight"
            class="text-slate-600 opacity-60"
            size="x-small"
          />
        </template>
      </template>
    </div>
  </div>
</template>
