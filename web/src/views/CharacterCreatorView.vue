<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { mdiArrowLeft, mdiChevronRight } from '../icons'

const currentStep = ref(0)

const steps = ref([
  { title: 'Ped Selection', key: 'ped' },
  { title: 'Heritage', key: 'heritage' },
  { title: 'Face Customization', key: 'face' },
  { title: 'Physical Customization', key: 'physical' },
  { title: 'Clothing', key: 'clothing' },
  { title: 'Accessories', key: 'accessories' },
  { title: 'Tattoos', key: 'tattoos' },
  { title: 'Confirmation', key: 'confirmation' },
])

interface PedModel {
  title: string
  value: string
  category: string
}

const selectedPed = ref<string | null>(null)
const authorizePedwhileInCreator = ref(false)

const pedModels = ref<PedModel[]>([])

const props = defineProps<{
  forceVisible?: boolean
}>()

const emit = defineEmits<{
  backToMenu: []
}>()

const isVisible = ref<boolean>(false)

const closeInterface = () => {
  isVisible.value = false
  fetch('https://Ambitions-Multicharacter/closeCharacterCreator', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({}),
  }).catch(() => {})
}

onMounted(() => {
  window.addEventListener('message', (event) => {
    if (event.data.action === 'showCharacterCreator') {
      isVisible.value = true
      if (event.data.config) {
        authorizePedwhileInCreator.value = event.data.config.authorizePedwhileInCreator
        pedModels.value = event.data.config.pedModels
      }
    } else if (event.data.action === 'hideCharacterCreator') {
      isVisible.value = false
    }
  })

  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape' && isVisible.value) {
      closeInterface()
    }
  })
})
</script>

<template>
  <div
    v-if="isVisible || props.forceVisible"
    class="fixed inset-0 w-full h-full z-10"
    style="
      background: linear-gradient(
        to right,
        rgba(15, 23, 42, 1) 0%,
        rgba(15, 23, 42, 0.7) 15%,
        rgba(15, 23, 42, 0.4) 33%,
        transparent 100%
      );
    "
  >
    <Transition name="fade-in" appear>
      <div
        class="absolute left-16 top-16 w-[32rem] fhd:w-[28rem] 2k:w-[40rem] max-h-[85vh] overflow-hidden"
      >
        <div class="mb-8">
          <VBtn
            v-if="props.forceVisible"
            icon
            size="small"
            color="transparent"
            class="bg-slate-800/60 border border-blue-500/30 mb-6 hover:bg-slate-700/80 hover:border-blue-400/50 transition-all"
            @click="emit('backToMenu')"
          >
            <VIcon :icon="mdiArrowLeft" color="white" />
          </VBtn>

          <div class="w-16 h-0.5 bg-gradient-to-r from-blue-500 to-cyan-400 mb-4"></div>

          <h1
            class="text-4xl fhd:text-3xl 2k:text-6xl font-black text-white leading-tight tracking-wide"
          >
            Character
            <span class="text-3xl fhd:text-2xl 2k:text-5xl font-light text-blue-200/80"
              >Creator</span
            >
          </h1>
        </div>

        <div class="mb-8 overflow-x-auto">
          <div class="flex items-center space-x-2 text-sm min-w-max">
            <template v-for="(step, index) in steps" :key="step.key">
              <template v-if="index <= currentStep">
                <span
                  :class="{
                    'text-blue-300 font-semibold': index === currentStep,
                    'text-slate-400 opacity-60': index < currentStep,
                  }"
                >
                  {{ step.title }}
                </span>
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

        <div v-if="currentStep === 0" class="space-y-6">
          <div class="flex items-center space-x-3 mb-6">
            <div
              class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center"
            >
              <span class="text-blue-300 text-sm font-bold">01</span>
            </div>
            <span class="text-slate-300 text-sm font-medium uppercase tracking-widest"
              >Ped Model Selection</span
            >
          </div>

          <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
            <VSelect
              v-model="selectedPed"
              :items="pedModels"
              label="Select a ped model"
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
            >
              <template #item="{ props, item }">
                <VListItem
                  v-bind="props"
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
                  <p class="text-white font-medium">Selected Model</p>
                  <p class="text-slate-300 text-sm">
                    {{ pedModels.find((p) => p.value === selectedPed)?.title }}
                  </p>
                </div>
                <div class="text-right">
                  <p class="text-slate-400 text-xs">Category</p>
                  <p class="text-blue-300 text-sm font-medium">
                    {{ pedModels.find((p) => p.value === selectedPed)?.category }}
                  </p>
                </div>
              </div>
            </div>
          </div>

          <div v-if="selectedPed" class="mt-8 flex justify-end pr-6">
            <VBtn
              variant="outlined"
              size="large"
              class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
              elevation="0"
              @click="currentStep++"
            >
              <span class="text-base tracking-wide uppercase">Continue</span>
            </VBtn>
          </div>
        </div>
      </div>
    </Transition>

    <div class="absolute right-0 top-0 w-3/5 h-full pointer-events-none"></div>
  </div>
</template>

<style scoped>
.fade-in-enter-active {
  transition: all 0.6s ease-out;
}

.fade-in-enter-from {
  opacity: 0;
  transform: translateX(-30px);
}

.fade-in-enter-to {
  opacity: 1;
  transform: translateX(0);
}
</style>
