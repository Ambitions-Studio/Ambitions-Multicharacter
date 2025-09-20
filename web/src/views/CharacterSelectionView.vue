<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useI18n } from 'vue-i18n'
import {
  mdiArrowLeft,
  mdiAccount,
  mdiPlus,
  mdiAccountOutline,
  mdiBriefcaseOutline,
  mdiAccountGroupOutline,
  mdiCashMultiple,
  mdiCardAccountDetailsOutline,
  mdiCheckCircle,
  mdiChartLineVariant,
  mdiAccountPlus,
  mdiPlay,
  mdiTrashCan,
} from '../icons'

const { t } = useI18n()

const props = defineProps<{
  forceVisible?: boolean
}>()

const emit = defineEmits<{
  backToMenu: []
}>()

const selectedSlot = ref<number | null>(null)
const isSlotEmpty = ref<boolean>(false)
const isVisible = ref<boolean>(false)
const characterSlots = ref<number>(5)
const playerCanDeleteCharacter = ref<boolean>(true)

type Character = {
  firstName: string
  lastName: string
  job: string | null
  jobGrade: string | null
  crew: string | null
  crewGrade: string | null
  cash: number
  bank: number
  dirtyMoney: number
  licenses: string[]
  totalPlaytime: string
  lastPlayed: string
}

const characterData: Record<number, Character> = {
  1: {
    firstName: 'John',
    lastName: 'Doe',
    job: null,
    jobGrade: null,
    crew: 'Los Santos Cartel',
    crewGrade: 'Lieutenant',
    cash: 2500,
    bank: 15000,
    dirtyMoney: 8500,
    licenses: [t('characterSelection.licenseTypes.driving'), t('characterSelection.licenseTypes.motorcycle'), t('characterSelection.licenseTypes.truck'), t('characterSelection.licenseTypes.weapon')],
    totalPlaytime: '156h 32m',
    lastPlayed: t('characterSelection.timeAgo.hours', { count: 2 }),
  },
  2: {
    firstName: 'Jane',
    lastName: 'Smith',
    job: t('characterSelection.jobs.doctor'),
    jobGrade: t('characterSelection.jobGrades.practitioner'),
    crew: null,
    crewGrade: null,
    cash: 850,
    bank: 22000,
    dirtyMoney: 0,
    licenses: [],
    totalPlaytime: '89h 14m',
    lastPlayed: t('characterSelection.timeAgo.days', { count: 1 }),
  },
}

const allSlots = computed(() => {
  const slots = []
  for (let i = 1; i <= characterSlots.value; i++) {
    const hasCharacter = characterData[i] !== undefined
    slots.push({
      id: i,
      isEmpty: !hasCharacter,
      character: hasCharacter ? characterData[i] : null
    })
  }
  return slots
})

const selectSlot = (slotId: number, isEmpty: boolean) => {
  selectedSlot.value = slotId
  isSlotEmpty.value = isEmpty
}

const createCharacter = () => {
  console.log('Créer un personnage pour le slot:', selectedSlot.value)
}

const playCharacter = () => {
  console.log('Jouer le personnage du slot:', selectedSlot.value)
}

const deleteCharacter = () => {
  console.log('Supprimer le personnage du slot:', selectedSlot.value)
}

const closeInterface = () => {
  isVisible.value = false
  fetch('https://Ambitions-Multicharacter/closeCharacterSelection', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({}),
  }).catch(() => {})
}

onMounted(() => {
  window.addEventListener('message', (event) => {
    if (event.data.action === 'showCharacterSelection') {
      isVisible.value = true
      if (event.data.config) {
        characterSlots.value = event.data.config.characterSlots
        playerCanDeleteCharacter.value = event.data.config.playerCanDeleteCharacter
      }
    } else if (event.data.action === 'hideCharacterSelection') {
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
  <div v-if="isVisible || props.forceVisible" class="fixed inset-0 w-full h-full z-10" style="background: linear-gradient(to right, rgba(15, 23, 42, 1) 0%, rgba(15, 23, 42, 0.7) 15%, rgba(15, 23, 42, 0.4) 33%, transparent 100%)">
    <div v-if="selectedSlot && !isSlotEmpty" class="absolute inset-0 w-full h-full pointer-events-none" style="background: linear-gradient(to left, rgba(15, 23, 42, 1) 0%, rgba(15, 23, 42, 0.7) 15%, rgba(15, 23, 42, 0.4) 33%, transparent 100%)"></div>
    <Transition
      name="fade-in"
      appear
    >
      <div class="absolute left-16 top-16 w-[30rem] fhd:w-[26rem] 2k:w-[40rem] max-h-[85vh] fhd:max-h-[80vh] 2k:max-h-[90vh] overflow-hidden">

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

        <h1 class="text-4xl fhd:text-3xl 2k:text-5xl font-black text-white leading-tight tracking-wide">
          {{ t('characterSelection.title') }} <span class="text-3xl fhd:text-2xl 2k:text-4xl font-light text-blue-200/80">{{ t('characterSelection.subtitle') }}</span>
        </h1>
      </div>

      <div class="space-y-8 overflow-y-auto max-h-[calc(85vh-180px)] fhd:max-h-[calc(80vh-160px)] 2k:max-h-[calc(90vh-200px)] pr-3 scrollbar-thin scrollbar-track-slate-800/50 scrollbar-thumb-blue-600/40 hover:scrollbar-thumb-blue-500/60">
        <div class="space-y-4 ">
          <div class="flex items-center space-x-3 mb-6 ">
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center">
              <span class="text-blue-300 text-sm font-bold">01</span>
            </div>
            <span class="text-slate-300 text-sm 2k:text-xl font-medium uppercase tracking-widest">{{ t('characterSelection.categories.characters') }}</span>
          </div>

          <div class="space-y-6 2k:space-y-8">
            <div
              v-for="slot in allSlots"
              :key="slot.id"
              class="character-slot cursor-pointer transition-all duration-300 ease-out hover:scale-[1.02] hover:shadow-xl hover:shadow-blue-500/20 p-5 fhd:p-4 2k:p-8 rounded-xl"
              :class="{
                'bg-gradient-to-br from-blue-600/20 via-blue-500/15 to-blue-600/20':
                  selectedSlot === slot.id,
                'bg-gradient-to-br from-slate-800/50 via-slate-700/40 to-slate-800/50':
                  selectedSlot !== slot.id,
              }"
              @click="selectSlot(slot.id, slot.isEmpty)"
            >
              <div class="flex items-center space-x-4">
                <div
                  class="w-12 h-12  rounded-full flex items-center justify-center border-2"
                  :class="{
                    'bg-blue-500/20 border-blue-400/50': selectedSlot === slot.id,
                    'bg-slate-600/30 border-slate-500/50': selectedSlot !== slot.id,
                  }"
                >
                  <VIcon
                    :icon="slot.isEmpty ? mdiPlus : mdiAccount"
                    :class="slot.isEmpty ? 'text-slate-400' : selectedSlot === slot.id ? 'text-blue-300' : 'text-slate-300'"
                    class=""
                  />
                </div>

                <div class="flex-1">
                  <template v-if="!slot.isEmpty && slot.character">
                    <h3 class="text-lg  font-semibold text-white mb-1">
                      {{ slot.character.firstName }} {{ slot.character.lastName }}
                    </h3>
                    <p class="text-sm  text-slate-300 mb-1">
                      {{ slot.character.job || t('characterSelection.values.noJob') }}
                      <template v-if="slot.character.jobGrade"> - {{ slot.character.jobGrade }}</template>
                    </p>
                    <p class="text-sm  text-slate-300 mb-1">
                      <template v-if="slot.character.crew">
                        {{ slot.character.crew }}
                        <template v-if="slot.character.crewGrade">
                          - {{ slot.character.crewGrade }}
                        </template>
                      </template>
                      <template v-else>{{ t('characterSelection.values.noCrew') }}</template>
                    </p>
                    <p class="text-xs  text-slate-400">{{ slot.character.lastPlayed }}</p>
                  </template>
                  <template v-else>
                    <h3 class="text-lg  font-semibold text-slate-400 mb-1">{{ t('characterSelection.slot', { id: slot.id }) }}</h3>
                    <p class="text-sm  text-slate-500">{{ t('characterSelection.createNew') }}</p>
                  </template>
                </div>

                <div class="text-right">
                  <div class="w-6 h-6 rounded-full flex items-center justify-center"
                    :class="{
                      'bg-blue-500/30': selectedSlot === slot.id,
                      'bg-slate-600/30': selectedSlot !== slot.id,
                    }"
                  >
                    <span class="text-xs font-bold"
                      :class="{
                        'text-blue-300': selectedSlot === slot.id,
                        'text-slate-400': selectedSlot !== slot.id,
                      }"
                    >{{ slot.id }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      </div>
    </Transition>

    <Transition
      name="fade-in-right"
      appear
    >
      <div v-if="selectedSlot && !isSlotEmpty" class="absolute right-16 top-16 w-[38rem] fhd:w-[32rem] 2k:w-[45rem] max-h-[76vh] fhd:max-h-[70vh] 2k:max-h-[80vh] overflow-hidden space-y-8">

      <div class="mb-8">
        <div class="w-16 h-0.5 bg-gradient-to-r from-blue-500 to-cyan-400 mb-4 ml-auto"></div>

        <h1 class="text-4xl fhd:text-3xl 2k:text-5xl font-black text-white leading-tight tracking-wide text-right">
          {{ t('characterSelection.details.title') }} <span class="text-3xl fhd:text-2xl 2k:text-4xl font-light text-blue-200/80">{{ t('characterSelection.details.subtitle') }}</span>
        </h1>
      </div>

      <div class="space-y-10 fhd:space-y-5 2k:space-y-8 overflow-y-auto max-h-[calc(76vh-180px)] fhd:max-h-[calc(70vh-150px)] 2k:max-h-[calc(80vh-180px)] pl-3 scrollbar-thin scrollbar-track-slate-800/50 scrollbar-thumb-blue-600/40 hover:scrollbar-thumb-blue-500/60">
        <div class="space-y-4 ">
          <div class="flex items-center space-x-3 mb-6  justify-end">
            <span class="text-slate-300 text-sm 2k:text-xl font-medium uppercase tracking-widest">{{ t('characterSelection.categories.identity') }}</span>
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center">
              <VIcon :icon="mdiAccountOutline" class="text-blue-400 text-sm" />
            </div>
          </div>

          <div class="bg-slate-800/50 rounded-lg p-4 2k:p-6 max-w-sm 2k:max-w-md ml-auto" style="border: 1px solid rgba(255, 255, 255, 0.3);">
            <div class="space-y-3">
              <div class="flex justify-between items-center">
                <span class="text-slate-400 text-sm 2k:text-base font-medium">{{ t('characterSelection.fields.firstName') }}</span>
                <span class="text-white 2k:text-lg font-semibold">{{ characterData[selectedSlot]?.firstName || t('common.unknown') }}</span>
              </div>
              <div class="w-full h-px bg-gradient-to-r from-transparent via-slate-400/70 to-transparent"></div>
              <div class="flex justify-between items-center">
                <span class="text-slate-400 text-sm 2k:text-base font-medium">{{ t('characterSelection.fields.lastName') }}</span>
                <span class="text-white 2k:text-lg font-semibold">{{ characterData[selectedSlot]?.lastName || t('common.unknown') }}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="space-y-4 ">
          <div class="flex items-center space-x-3 mb-6  justify-end">
            <span class="text-slate-300 text-sm 2k:text-xl font-medium uppercase tracking-widest">{{ t('characterSelection.categories.job') }}</span>
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-green-500/40 flex items-center justify-center">
              <VIcon :icon="mdiBriefcaseOutline" class="text-green-400 text-sm" />
            </div>
          </div>

          <div class="bg-slate-800/50 rounded-lg p-4 2k:p-6 max-w-sm 2k:max-w-md ml-auto" style="border: 1px solid rgba(255, 255, 255, 0.3);">
            <div v-if="characterData[selectedSlot]?.job" class="space-y-3">
              <div class="flex justify-between items-center">
                <span class="text-slate-400 text-sm 2k:text-base font-medium">{{ t('characterSelection.fields.profession') }}</span>
                <span class="text-white 2k:text-lg font-semibold">{{ characterData[selectedSlot]?.job }}</span>
              </div>
              <div class="w-full h-px bg-gradient-to-r from-transparent via-slate-400/70 to-transparent"></div>
              <div class="flex justify-between items-center">
                <span class="text-slate-400 text-sm 2k:text-base font-medium">{{ t('characterSelection.fields.grade') }}</span>
                <span class="text-white 2k:text-lg font-semibold">{{ characterData[selectedSlot]?.jobGrade }}</span>
              </div>
            </div>
            <div v-else class="text-slate-500 text-center py-2 italic">
              {{ t('characterSelection.values.noJob') }}
            </div>
          </div>
        </div>

        <div class="space-y-4 ">
          <div class="flex items-center space-x-3 mb-6  justify-end">
            <span class="text-slate-300 text-sm 2k:text-xl font-medium uppercase tracking-widest">{{ t('characterSelection.categories.crew') }}</span>
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-red-500/40 flex items-center justify-center">
              <VIcon :icon="mdiAccountGroupOutline" class="text-red-400 text-sm" />
            </div>
          </div>

          <div class="bg-slate-800/50 rounded-lg p-4 2k:p-6 max-w-sm 2k:max-w-md ml-auto" style="border: 1px solid rgba(255, 255, 255, 0.3);">
            <div v-if="characterData[selectedSlot]?.crew" class="space-y-3">
              <div class="flex justify-between items-center">
                <span class="text-slate-400 text-sm 2k:text-base font-medium">{{ t('characterSelection.fields.crewName') }}</span>
                <span class="text-white 2k:text-lg font-semibold">{{ characterData[selectedSlot]?.crew }}</span>
              </div>
              <div class="w-full h-px bg-gradient-to-r from-transparent via-slate-400/70 to-transparent"></div>
              <div class="flex justify-between items-center">
                <span class="text-slate-400 text-sm 2k:text-base font-medium">{{ t('characterSelection.fields.grade') }}</span>
                <span class="text-white 2k:text-lg font-semibold">{{ characterData[selectedSlot]?.crewGrade }}</span>
              </div>
            </div>
            <div v-else class="text-slate-500 text-center py-2 italic">
              {{ t('characterSelection.values.noCrew') }}
            </div>
          </div>
        </div>

        <div class="space-y-4 ">
          <div class="flex items-center space-x-3 mb-6  justify-end">
            <span class="text-slate-300 text-sm 2k:text-xl font-medium uppercase tracking-widest">{{ t('characterSelection.categories.finances') }}</span>
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-green-500/40 flex items-center justify-center">
              <VIcon :icon="mdiCashMultiple" class="text-green-400 text-sm" />
            </div>
          </div>

          <div class="bg-slate-800/50 rounded-lg p-4 2k:p-6 max-w-sm 2k:max-w-md ml-auto" style="border: 1px solid rgba(255, 255, 255, 0.3);">
            <div class="space-y-3">
              <div class="flex justify-between items-center">
                <span class="text-slate-400 text-sm 2k:text-base font-medium">{{ t('characterSelection.fields.cash') }}</span>
                <span class="text-green-400 2k:text-lg font-semibold">{{ characterData[selectedSlot]?.cash?.toLocaleString() || '0' }}$</span>
              </div>
              <div class="w-full h-px bg-gradient-to-r from-transparent via-slate-400/70 to-transparent"></div>
              <div class="flex justify-between items-center">
                <span class="text-slate-400 text-sm 2k:text-base font-medium">{{ t('characterSelection.fields.bankAccount') }}</span>
                <span class="text-blue-400 2k:text-lg font-semibold">{{ characterData[selectedSlot]?.bank?.toLocaleString() || '0' }}$</span>
              </div>
              <div class="w-full h-px bg-gradient-to-r from-transparent via-slate-400/70 to-transparent"></div>
              <div class="flex justify-between items-center">
                <span class="text-slate-400 text-sm 2k:text-base font-medium">{{ t('characterSelection.fields.dirtyMoney') }}</span>
                <span class="text-red-400 2k:text-lg font-semibold">{{ characterData[selectedSlot]?.dirtyMoney?.toLocaleString() || '0' }}$</span>
              </div>
            </div>
          </div>
        </div>

        <div class="space-y-4 ">
          <div class="flex items-center space-x-3 mb-6  justify-end">
            <span class="text-slate-300 text-sm 2k:text-xl font-medium uppercase tracking-widest">{{ t('characterSelection.categories.licenses') }}</span>
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-purple-500/40 flex items-center justify-center">
              <VIcon :icon="mdiCardAccountDetailsOutline" class="text-purple-400 text-sm" />
            </div>
          </div>

          <div class="bg-slate-800/50 rounded-lg p-4 2k:p-6 max-w-sm 2k:max-w-md ml-auto" style="border: 1px solid rgba(255, 255, 255, 0.3);">
            <div v-if="characterData[selectedSlot]?.licenses?.length" class="space-y-2">
              <div
                v-for="(license, index) in characterData[selectedSlot]?.licenses"
                :key="license"
              >
                <div class="flex items-center justify-between">
                  <span class="text-white text-sm 2k:text-base font-medium">{{ license }}</span>
                  <VIcon :icon="mdiCheckCircle" class="text-green-400 text-sm" />
                </div>
                <div
                  v-if="index < characterData[selectedSlot]?.licenses?.length - 1"
                  class="w-full h-px bg-gradient-to-r from-transparent via-slate-400/70 to-transparent mt-2"
                ></div>
              </div>
            </div>
            <div v-else class="text-slate-500 text-center py-2 italic">
              {{ t('characterSelection.values.noLicenses') }}
            </div>
          </div>
        </div>

        <div class="space-y-4 ">
          <div class="flex items-center space-x-3 mb-6  justify-end">
            <span class="text-slate-300 text-sm 2k:text-xl font-medium uppercase tracking-widest">{{ t('characterSelection.categories.stats') }}</span>
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-yellow-500/40 flex items-center justify-center">
              <VIcon :icon="mdiChartLineVariant" class="text-yellow-400 text-sm" />
            </div>
          </div>

          <div class="bg-slate-800/50 rounded-lg p-4 2k:p-6 max-w-sm 2k:max-w-md ml-auto" style="border: 1px solid rgba(255, 255, 255, 0.3);">
            <div class="space-y-3">
              <div class="flex justify-between items-center">
                <span class="text-slate-400 text-sm 2k:text-base font-medium">{{ t('characterSelection.fields.totalPlaytime') }}</span>
                <span class="text-white 2k:text-lg font-semibold">{{ characterData[selectedSlot]?.totalPlaytime || '0h 0m' }}</span>
              </div>
              <div class="w-full h-px bg-gradient-to-r from-transparent via-slate-400/70 to-transparent"></div>
              <div class="flex justify-between items-center">
                <span class="text-slate-400 text-sm 2k:text-base font-medium">{{ t('characterSelection.fields.lastConnection') }}</span>
                <span class="text-white 2k:text-lg font-semibold">{{ characterData[selectedSlot]?.lastPlayed || t('characterSelection.values.never') }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      </div>
    </Transition>

    <div
      class="absolute bottom-24 right-24 z-50"
    >
      <div v-if="selectedSlot && isSlotEmpty">
        <VBtn
          :size="'large'"
          color="transparent"
          class="bg-charcoal-elegant-forest hover:bg-green-600/95 transition-all duration-300 ease-out hover:scale-105 hover:shadow-xl hover:shadow-green-500/30 !px-6 !py-8 !text-xl font-semibold !flex !items-center !justify-center text-white w-80 2k:w-96 h-24"
          elevation="0"
          @click="createCharacter"
        >
          <VIcon
            start
            :icon="mdiAccountPlus"
            class="text-lg"
          />
          {{ t('characterSelection.actions.create') }}
        </VBtn>
      </div>

      <div v-if="selectedSlot && !isSlotEmpty" class="space-y-3 flex flex-col">
        <VBtn
          :size="'large'"
          color="transparent"
          class="bg-charcoal-elegant-forest hover:bg-green-600/95 transition-all duration-300 ease-out hover:scale-105 hover:shadow-xl hover:shadow-green-500/30 !px-6 !py-8 !text-xl font-semibold !flex !items-center !justify-center text-white w-80 2k:w-96 h-24"
          elevation="0"
          @click="playCharacter"
        >
          <VIcon
            start
            :icon="mdiPlay"
            class="text-lg"
          />
          {{ t('characterSelection.actions.play') }}
        </VBtn>

        <VBtn
          v-if="playerCanDeleteCharacter"
          :size="'large'"
          color="transparent"
          class="bg-charcoal-elegant-blood hover:bg-red-600/95 transition-all duration-300 ease-out hover:scale-105 hover:shadow-xl hover:shadow-red-500/30 !px-6 !py-8 !text-lg font-semibold !flex !items-center !justify-center text-white w-80 2k:w-96 h-24"
          elevation="0"
          @click="deleteCharacter"
        >
          <VIcon
            start
            :icon="mdiTrashCan"
            class="text-lg lg:text-sm xl:text-lg 2xl:text-3xl fhd:text-4xl  4k:text-6xl"
          />
          {{ t('characterSelection.actions.delete') }}
        </VBtn>
      </div>
    </div>
  </div>
</template>

<style scoped>
.scrollbar-hide {
  scrollbar-width: none;
  -ms-overflow-style: none;
}

.scrollbar-hide::-webkit-scrollbar {
  display: none;
}

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

.fade-in-right-enter-active {
  transition: all 0.6s ease-out;
}

.fade-in-right-enter-from {
  opacity: 0;
  transform: translateX(30px);
}

.fade-in-right-enter-to {
  opacity: 1;
  transform: translateX(0);
}

.fade-in-right-leave-active {
  transition: all 0.4s ease-in;
}

.fade-in-right-leave-from {
  opacity: 1;
  transform: translateX(0);
}

.fade-in-right-leave-to {
  opacity: 0;
  transform: translateX(30px);
}
</style>