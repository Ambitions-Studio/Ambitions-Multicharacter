<script setup lang="ts">
import { ref, watch, nextTick } from 'vue'
import { useI18n } from 'vue-i18n'
import { mdiChevronRight } from '@/icons'

const { t } = useI18n()

export interface Step {
  key: string
  titleKey?: string
  title?: string
}

interface Props {
  steps: Step[]
  currentStep: number
  autoScroll?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  autoScroll: true,
})

const emit = defineEmits<{
  'update:currentStep': [value: number]
  stepChange: [newStep: number, oldStep: number]
}>()

const breadcrumbContainer = ref<HTMLElement | null>(null)

const handleStepClick = (index: number) => {
  if (index < props.currentStep) {
    const oldStep = props.currentStep
    emit('update:currentStep', index)
    emit('stepChange', index, oldStep)
  }
}

const getStepTitle = (step: Step): string => {
  if (step.titleKey) {
    return t(step.titleKey)
  }
  return step.title || step.key
}

watch(
  () => props.currentStep,
  async () => {
    if (props.autoScroll && breadcrumbContainer.value) {
      await nextTick()
      const container = breadcrumbContainer.value
      const currentButton = container.querySelector('.step-current')
      if (currentButton) {
        currentButton.scrollIntoView({
          behavior: 'smooth',
          block: 'nearest',
          inline: 'center',
        })
      }
    }
  },
)
</script>

<template>
  <div ref="breadcrumbContainer" class="mb-8 overflow-x-auto">
    <div class="flex items-center space-x-2 text-base min-w-max">
      <template v-for="(step, index) in steps" :key="step.key">
        <template v-if="index <= currentStep">
          <button
            :class="[
              'transition-all py-1.5 px-1',
              {
                'text-blue-300 font-bold text-lg step-current': index === currentStep,
                'text-slate-400 opacity-60 hover:text-slate-300 hover:opacity-80 cursor-pointer':
                  index < currentStep,
              },
            ]"
            @click="handleStepClick(index)"
          >
            {{ getStepTitle(step) }}
          </button>
          <VIcon
            v-if="index < currentStep"
            :icon="mdiChevronRight"
            class="text-slate-500 opacity-60"
            size="small"
          />
        </template>
      </template>
    </div>
  </div>
</template>
