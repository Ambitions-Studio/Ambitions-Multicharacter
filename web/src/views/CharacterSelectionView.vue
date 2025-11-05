<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useI18n } from 'vue-i18n'
import { mdiArrowLeft, mdiAccountPlus, mdiPlay, mdiTrashCan } from '@/icons'
import CharacterSlot, { type Character } from '@/components/characterSelection/CharacterSlot.vue'
import CharacterDetails from '@/components/characterSelection/CharacterDetails.vue'
import CustomButton from '@/components/CustomButton.vue'
import { sendNuiEvent } from '@/utils/nui'

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

const characterDataDev: Record<number, Character> = {
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
    licenses: [
      t('characterSelection.licenseTypes.driving'),
      t('characterSelection.licenseTypes.motorcycle'),
      t('characterSelection.licenseTypes.truck'),
      t('characterSelection.licenseTypes.weapon'),
    ],
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

const characterData = ref<Record<number, Character>>(
  props.forceVisible ? characterDataDev : {}
)

const allSlots = computed(() => {
  const slots = []
  for (let i = 1; i <= characterSlots.value; i++) {
    const hasCharacter = characterData.value[i] !== undefined
    slots.push({
      id: i,
      isEmpty: !hasCharacter,
      character: hasCharacter ? characterData.value[i] : null,
    })
  }
  return slots
})

const selectSlot = (slotId: number, isEmpty: boolean) => {
  const wasSlotSelected = selectedSlot.value !== null

  if (wasSlotSelected) {
    sendNuiEvent('deselectSlot')
  }

  selectedSlot.value = slotId
  isSlotEmpty.value = isEmpty

  if (isEmpty) {
    sendNuiEvent('selectEmptySlot', { slotIndex: slotId })
  }
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
  sendNuiEvent('closeCharacterSelection')
}

const formatPlaytime = (seconds: number): string => {
  const hours = Math.floor(seconds / 3600)
  const minutes = Math.floor((seconds % 3600) / 60)
  return `${hours}h ${minutes}m`
}

const formatLastPlayed = (timestamp: string): string => {
  const now = new Date()
  const lastPlayed = new Date(timestamp)
  const diffMs = now.getTime() - lastPlayed.getTime()
  const diffMins = Math.floor(diffMs / 60000)
  const diffHours = Math.floor(diffMs / 3600000)
  const diffDays = Math.floor(diffMs / 86400000)

  if (diffMins < 60) {
    return t('characterSelection.timeAgo.minutes', { count: diffMins })
  } else if (diffHours < 24) {
    return t('characterSelection.timeAgo.hours', { count: diffHours })
  } else {
    return t('characterSelection.timeAgo.days', { count: diffDays })
  }
}

onMounted(() => {
  window.addEventListener('message', (event) => {
    if (event.data.action === 'showCharacterSelection') {
      isVisible.value = true
      if (event.data.maxSlots !== undefined) {
        characterSlots.value = event.data.maxSlots
      }
      if (event.data.canDelete !== undefined) {
        playerCanDeleteCharacter.value = event.data.canDelete
      }
      if (event.data.characters !== undefined && Array.isArray(event.data.characters)) {
        const receivedCharacters: Record<number, Character> = {}
        const maxCharsToDisplay = Math.min(event.data.characters.length, event.data.maxSlots || characterSlots.value)

        for (let i = 0; i < maxCharsToDisplay; i++) {
          const char = event.data.characters[i]
          receivedCharacters[i + 1] = {
            firstName: char.firstname || '',
            lastName: char.lastname || '',
            job: null,
            jobGrade: null,
            crew: null,
            crewGrade: null,
            cash: 0,
            bank: 0,
            dirtyMoney: 0,
            licenses: [],
            totalPlaytime: formatPlaytime(char.playtime || 0),
            lastPlayed: formatLastPlayed(char.lastPlayed || char.createdAt),
          }
        }
        characterData.value = receivedCharacters
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
    <div
      v-if="selectedSlot && !isSlotEmpty"
      class="absolute inset-0 w-full h-full pointer-events-none"
      style="
        background: linear-gradient(
          to left,
          rgba(15, 23, 42, 1) 0%,
          rgba(15, 23, 42, 0.7) 15%,
          rgba(15, 23, 42, 0.4) 33%,
          transparent 100%
        );
      "
    ></div>
    <Transition name="fade-in" appear>
      <div
        class="absolute left-16 top-16 w-[30rem] fhd:w-[26rem] 2k:w-[40rem] max-h-[85vh] fhd:max-h-[80vh] 2k:max-h-[95vh] overflow-hidden"
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
            class="text-4xl fhd:text-3xl 2k:text-4xl font-black text-white leading-tight tracking-wide"
          >
            {{ t('characterSelection.title') }}
            <span class="text-3xl fhd:text-2xl 2k:text-3xl font-light text-blue-200/80">{{
              t('characterSelection.subtitle')
            }}</span>
          </h1>
        </div>

        <div
          class="space-y-8 overflow-y-auto max-h-[calc(85vh-180px)] fhd:max-h-[calc(80vh-160px)] 2k:max-h-[calc(90vh-200px)] pr-3 pb-8 2k:pb-16 scrollbar-thin scrollbar-track-slate-800/50 scrollbar-thumb-blue-600/40 hover:scrollbar-thumb-blue-500/60"
        >
          <div class="space-y-4">
            <div class="flex items-center space-x-3 mb-6">
              <div
                class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center"
              >
                <span class="text-blue-300 text-sm font-bold">01</span>
              </div>
              <span
                class="text-slate-300 text-sm 2k:text-xl font-medium uppercase tracking-widest"
                >{{ t('characterSelection.categories.characters') }}</span
              >
            </div>

            <div class="space-y-6 2k:space-y-8 ml-6">
              <CharacterSlot
                v-for="slot in allSlots"
                :key="slot.id"
                :slot-id="slot.id"
                :is-empty="slot.isEmpty"
                :character="slot.character ?? undefined"
                :is-selected="selectedSlot === slot.id"
                @click="selectSlot"
              />
            </div>
          </div>
        </div>
      </div>
    </Transition>

    <CharacterDetails
      v-if="selectedSlot && !isSlotEmpty && characterData[selectedSlot]"
      :character="characterData[selectedSlot]"
    />

    <div class="absolute bottom-24 right-24 z-50">
      <div v-if="selectedSlot && isSlotEmpty">
        <CustomButton
          variant="success"
          size="large"
          :icon="mdiAccountPlus"
          width="w-80 2k:w-96"
          @click="createCharacter"
        >
          {{ t('characterSelection.actions.create') }}
        </CustomButton>
      </div>

      <div v-if="selectedSlot && !isSlotEmpty" class="space-y-3 flex flex-col">
        <CustomButton
          variant="success"
          size="large"
          :icon="mdiPlay"
          width="w-80 2k:w-96"
          @click="playCharacter"
        >
          {{ t('characterSelection.actions.play') }}
        </CustomButton>

        <CustomButton
          v-if="playerCanDeleteCharacter"
          variant="danger"
          size="large"
          :icon="mdiTrashCan"
          width="w-80 2k:w-96"
          @click="deleteCharacter"
        >
          {{ t('characterSelection.actions.delete') }}
        </CustomButton>
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
