<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { mdiArrowLeft, mdiChevronRight, mdiFaceMan, mdiPalette } from '../icons'

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
const pedSelectionError = ref('')

const pedModels = ref<PedModel[]>([])

// Heritage step data
const selectedFather = ref<number>(0)
const selectedMother = ref<number>(0)
const faceResemblance = ref<number>(0.5) // 0 = father, 1 = mother
const skinResemblance = ref<number>(0.5) // 0 = father, 1 = mother

// Development mode detection
const isDev = import.meta.env.DEV

// Heritage options
const fatherOptions = ref<{ id: number; name: string; photo?: string }[]>([])
const motherOptions = ref<{ id: number; name: string; photo?: string }[]>([])

const props = defineProps<{
  forceVisible?: boolean
}>()

const emit = defineEmits<{
  backToMenu: []
}>()

const isVisible = ref<boolean>(false)

const validatePedSelection = () => {
  pedSelectionError.value = ''
  if (!selectedPed.value) {
    pedSelectionError.value = 'Please select a ped model to continue'
    return false
  }
  return true
}

const continueToNextStep = () => {
  if (!validatePedSelection()) {
    return
  }
  currentStep.value++
}

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
  // Development mode hardcoded data
  if (import.meta.env.DEV) {
    // Peds list
    pedModels.value = [
      { title: 'Michael De Santa', value: 'player_zero', category: 'Protagonists' },
      { title: 'Franklin Clinton', value: 'player_one', category: 'Protagonists' },
      { title: 'Trevor Philips', value: 'player_two', category: 'Protagonists' },
      { title: 'Police Officer', value: 's_m_y_cop_01', category: 'Emergency Services' },
      { title: 'Sheriff', value: 's_m_y_sheriff_01', category: 'Emergency Services' },
      { title: 'Paramedic', value: 's_m_m_paramedic_01', category: 'Emergency Services' },
      { title: 'Firefighter', value: 's_m_y_fireman_01', category: 'Emergency Services' },
      { title: 'Business Woman', value: 'a_f_m_business_02', category: 'Civilians' },
      { title: 'Business Man', value: 'a_m_m_business_01', category: 'Civilians' },
      { title: 'Tourist Female', value: 'a_f_y_tourist_02', category: 'Civilians' },
      { title: 'Tourist Male', value: 'a_m_y_tourist_01', category: 'Civilians' },
      { title: 'Hipster Female', value: 'a_f_y_hipster_03', category: 'Civilians' },
      { title: 'Hipster Male', value: 'a_m_y_hipster_02', category: 'Civilians' },
      { title: 'Beach Female', value: 'a_f_y_beach_01', category: 'Beach/Casual' },
      { title: 'Surfer', value: 'a_m_y_surfer_01', category: 'Beach/Casual' },
      { title: 'Skater', value: 'a_m_y_skater_02', category: 'Beach/Casual' },
      { title: 'Mechanic', value: 's_m_y_construct_02', category: 'Workers' },
      { title: 'Construction Worker', value: 's_m_y_construct_01', category: 'Workers' },
      { title: 'Dock Worker', value: 's_m_m_dockwork_01', category: 'Workers' },
      { title: 'Security Guard', value: 's_m_m_security_01', category: 'Security' },
      { title: 'Bouncer', value: 's_m_y_bouncer_01', category: 'Security' },
      { title: 'Freemode Male', value: 'mp_m_freemode_01', category: 'Freemode' },
      { title: 'Freemode Female', value: 'mp_f_freemode_01', category: 'Freemode' },
      { title: 'Gang Member Vagos', value: 'g_m_y_mexgang_01', category: 'Gang Members' },
    ]

    // Heritage options (dev only - shorter list for testing)
    fatherOptions.value = [
      { id: 0, name: 'Benjamin Rodriguez' },
      { id: 1, name: 'Marcus Thompson' },
      { id: 2, name: 'David Anderson' },
    ]

    motherOptions.value = [
      { id: 0, name: 'Isabella Garcia' },
      { id: 1, name: 'Sofia Johnson' },
      { id: 2, name: 'Emma Williams' },
    ]
  }

  window.addEventListener('message', (event) => {
    if (event.data.action === 'showCharacterCreator') {
      isVisible.value = true
      if (event.data.config) {
        authorizePedwhileInCreator.value = event.data.config.authorizePedwhileInCreator
        // Only use config data in production mode
        if (!import.meta.env.DEV) {
          if (event.data.config.pedModels) {
            pedModels.value = event.data.config.pedModels
          }
          if (event.data.config.fatherOptions) {
            fatherOptions.value = event.data.config.fatherOptions
          }
          if (event.data.config.motherOptions) {
            motherOptions.value = event.data.config.motherOptions
          }
        }
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
                <button
                  :class="{
                    'text-blue-300 font-semibold': index === currentStep,
                    'text-slate-400 opacity-60 hover:text-slate-300 hover:opacity-80 transition-all cursor-pointer': index < currentStep,
                  }"
                  @click="currentStep = index"
                >
                  {{ step.title }}
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
              @update:modelValue="pedSelectionError = ''"
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

            <p v-if="pedSelectionError" class="text-xs text-red-400 ml-2 mt-2">{{ pedSelectionError }}</p>
          </div>

          <div class="mt-8 flex justify-end pr-6">
            <VBtn
              variant="outlined"
              size="large"
              class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
              elevation="0"
              @click="continueToNextStep"
            >
              <span class="text-base tracking-wide uppercase">Continue</span>
            </VBtn>
          </div>
        </div>

        <!-- Heritage Step -->
        <div v-if="currentStep === 1" class="space-y-6 h-[73vh] overflow-y-scroll pr-2 pb-20">
          <div class="flex items-center space-x-3 mb-6">
            <div
              class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center"
            >
              <span class="text-blue-300 text-sm font-bold">02</span>
            </div>
            <span class="text-slate-300 text-sm font-medium uppercase tracking-widest"
              >Heritage Selection</span
            >
          </div>


          <!-- Parents Selection Section -->
          <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
            <div class="text-center mb-4">
              <h3 class="text-white text-xl font-bold mb-2">Parent Selection</h3>
              <p class="text-slate-400 text-sm">Choose the facial features base for your character</p>
            </div>

            <!-- Father and Mother Selection -->
            <div class="grid grid-cols-2 gap-8">
              <!-- Father Selection -->
              <div class="space-y-4">
                <div class="text-center">
                  <!-- Development Mode: Gender Icon -->
                  <div v-if="isDev" class="w-16 h-16 mx-auto mb-3 rounded-full bg-gradient-to-br from-blue-600 to-blue-800 border-2 border-blue-400/50 flex items-center justify-center">
                    <span class="text-white text-3xl font-bold">♂</span>
                  </div>

                  <!-- Production Mode: Father Photo Placeholder -->
                  <div v-else class="w-16 h-16 mx-auto mb-3 rounded-full border-2 border-blue-400/50 overflow-hidden bg-slate-700/50">
                    <img
                      v-if="selectedFather !== null && fatherOptions[selectedFather]?.photo"
                      :src="fatherOptions[selectedFather].photo"
                      :alt="fatherOptions[selectedFather]?.name"
                      class="w-full h-full object-cover"
                    />
                    <div v-else class="w-full h-full bg-gradient-to-br from-blue-600/20 to-blue-800/20 flex items-center justify-center">
                      <span class="text-blue-400 text-xs font-medium">Photo</span>
                    </div>
                  </div>

                  <h4 class="text-white text-lg font-semibold">Father</h4>
                </div>
                <VSelect
                  v-model="selectedFather"
                  :items="fatherOptions"
                  item-title="name"
                  item-value="id"
                  variant="outlined"
                  density="compact"
                  class="text-white"
                  color="blue"
                  base-color="blue-300"
                  bg-color="rgba(30, 41, 59, 0.4)"
                  hide-details
                />
              </div>

              <!-- Mother Selection -->
              <div class="space-y-4">
                <div class="text-center">
                  <!-- Development Mode: Gender Icon -->
                  <div v-if="isDev" class="w-16 h-16 mx-auto mb-3 rounded-full bg-gradient-to-br from-pink-600 to-pink-800 border-2 border-pink-400/50 flex items-center justify-center">
                    <span class="text-white text-3xl font-bold">♀</span>
                  </div>

                  <!-- Production Mode: Mother Photo Placeholder -->
                  <div v-else class="w-16 h-16 mx-auto mb-3 rounded-full border-2 border-pink-400/50 overflow-hidden bg-slate-700/50">
                    <img
                      v-if="selectedMother !== null && motherOptions[selectedMother]?.photo"
                      :src="motherOptions[selectedMother].photo"
                      :alt="motherOptions[selectedMother]?.name"
                      class="w-full h-full object-cover"
                    />
                    <div v-else class="w-full h-full bg-gradient-to-br from-pink-600/20 to-pink-800/20 flex items-center justify-center">
                      <span class="text-pink-400 text-xs font-medium">Photo</span>
                    </div>
                  </div>

                  <h4 class="text-white text-lg font-semibold">Mother</h4>
                </div>
                <VSelect
                  v-model="selectedMother"
                  :items="motherOptions"
                  item-title="name"
                  item-value="id"
                  variant="outlined"
                  density="compact"
                  class="text-white"
                  color="blue"
                  base-color="blue-300"
                  bg-color="rgba(30, 41, 59, 0.4)"
                  hide-details
                />
              </div>
            </div>
          </div>


          <!-- Resemblance Controls -->
          <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-8">
            <div class="text-center mb-6">
              <h3 class="text-white text-xl font-bold mb-2">Genetic Resemblance</h3>
              <p class="text-slate-400 text-sm">Fine-tune the genetic influence from each parent</p>
            </div>

            <!-- Face Resemblance Slider -->
            <div class="space-y-4">
              <div class="flex items-center justify-between">
                <div class="flex items-center space-x-2">
                  <span class="text-white text-base font-semibold">Face Features</span>
                  <VIcon :icon="mdiFaceMan" class="text-blue-400" size="small" />
                </div>
                <span class="text-blue-300 text-sm font-bold bg-blue-500/20 px-3 py-1 rounded-full border border-blue-500/30">
                  {{ Math.round((1 - faceResemblance) * 100) }}% Father • {{ Math.round(faceResemblance * 100) }}% Mother
                </span>
              </div>
              <div class="relative bg-slate-700/30 rounded-lg p-4">
                <div class="flex items-center justify-between text-xs text-slate-400 mb-3">
                  <div class="flex items-center space-x-1">
                    <div class="w-3 h-3 rounded-full bg-blue-500"></div>
                    <span>Father Dominant</span>
                  </div>
                  <span class="text-slate-300 font-medium">Balanced Mix</span>
                  <div class="flex items-center space-x-1">
                    <span>Mother Dominant</span>
                    <div class="w-3 h-3 rounded-full bg-pink-500"></div>
                  </div>
                </div>
                <VSlider
                  v-model="faceResemblance"
                  :min="0"
                  :max="1"
                  :step="0.01"
                  track-color="rgba(71, 85, 105, 0.6)"
                  color="blue"
                  class="w-full"
                  hide-details
                />
              </div>
            </div>

            <!-- Skin Tone Resemblance Slider -->
            <div class="space-y-4">
              <div class="flex items-center justify-between">
                <div class="flex items-center space-x-2">
                  <span class="text-white text-base font-semibold">Skin Tone</span>
                  <VIcon :icon="mdiPalette" class="text-pink-400" size="small" />
                </div>
                <span class="text-pink-300 text-sm font-bold bg-pink-500/20 px-3 py-1 rounded-full border border-pink-500/30">
                  {{ Math.round((1 - skinResemblance) * 100) }}% Father • {{ Math.round(skinResemblance * 100) }}% Mother
                </span>
              </div>
              <div class="relative bg-slate-700/30 rounded-lg p-4">
                <div class="flex items-center justify-between text-xs text-slate-400 mb-3">
                  <div class="flex items-center space-x-1">
                    <div class="w-3 h-3 rounded-full bg-blue-500"></div>
                    <span>Father Tone</span>
                  </div>
                  <span class="text-slate-300 font-medium">Blended Tone</span>
                  <div class="flex items-center space-x-1">
                    <span>Mother Tone</span>
                    <div class="w-3 h-3 rounded-full bg-pink-500"></div>
                  </div>
                </div>
                <VSlider
                  v-model="skinResemblance"
                  :min="0"
                  :max="1"
                  :step="0.01"
                  track-color="rgba(71, 85, 105, 0.6)"
                  color="pink"
                  class="w-full"
                  hide-details
                />
              </div>
            </div>
          </div>

          <!-- Continue Button for Heritage -->
          <div class="mt-8 flex justify-end pr-6">
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
