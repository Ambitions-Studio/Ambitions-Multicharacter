<script setup lang="ts">
import { ref, onMounted } from 'vue'

const props = defineProps<{
  forceVisible?: boolean
}>()

const emit = defineEmits<{
  backToMenu: []
}>()

const selectedSlot = ref<number | null>(null)
const isSlotEmpty = ref<boolean>(false)
const isVisible = ref<boolean>(false)

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
    licenses: ['Permis voiture', 'Permis moto', 'Permis camion', 'PPA'],
    totalPlaytime: '156h 32m',
    lastPlayed: 'Il y a 2 heures',
  },
  2: {
    firstName: 'Jane',
    lastName: 'Smith',
    job: 'Médecin',
    jobGrade: 'Praticien',
    crew: null,
    crewGrade: null,
    cash: 850,
    bank: 22000,
    dirtyMoney: 0,
    licenses: [],
    totalPlaytime: '89h 14m',
    lastPlayed: 'Il y a 1 jour',
  },
}

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
  }).catch(() => {
    // Ignore fetch errors in dev mode
  })
}

onMounted(() => {
  window.addEventListener('message', (event) => {
    if (event.data.action === 'showCharacterSelection') {
      isVisible.value = true
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
  <div v-if="isVisible || props.forceVisible" class="fixed inset-0 w-full h-full z-10">
    <!-- Section gauche - Liste des personnages -->
    <div
      class="absolute left-8 lg:left-4 xl:left-8 2xl:left-12 fhd:left-12 2k:left-16 4k:left-48 top-8 lg:top-12 xl:top-16 2xl:top-16 fhd:top-16 2k:top-16 4k:top-48 w-80 lg:w-72 xl:w-80 2xl:w-80 fhd:w-96 2k:w-[35rem] 4k:w-[60rem] h-3/4 xl:h-2/3 2xl:h-2/3 fhd:h-[70%] flex flex-col"
    >
      <!-- Header -->
      <div
        class="bg-charcoal-elegant border border-slate-400/30 rounded-xl p-4 lg:p-6 xl:p-4 2xl:p-6 fhd:p-6 2k:p-8 4k:p-24 mb-4 lg:mb-6 xl:mb-4 2xl:mb-6 fhd:mb-6 2k:mb-16 4k:mb-24"
      >
        <div class="flex items-center justify-between 2xl:justify-center">
          <VBtn
            v-if="props.forceVisible"
            icon
            :size="'x-small'"
            color="transparent"
            class="bg-charcoal-elegant-gray lg:!w-8 lg:!h-8 xl:!w-10 xl:!h-10 2xl:!w-8 2xl:!h-8 2k:!w-16 2k:!h-16 mr-2 lg:mr-4 2xl:mr-12"
            @click="emit('backToMenu')"
          >
            <VIcon icon="mdi-arrow-left" color="white" class="2k:!text-4xl" />
          </VBtn>
          <div v-else class="w-8 lg:w-10 mr-2 lg:mr-4"></div>
          <h1
            class="text-2xl lg:text-lg xl:text-2xl 2xl:text-2xl fhd:text-3xl 2k:text-5xl 4k:text-8xl font-bold bg-gradient-to-r from-white to-blue-400 bg-clip-text text-transparent text-center flex-1 whitespace-nowrap"
          >
            Character Selection
          </h1>
          <div class="w-10"></div>
        </div>
      </div>

      <!-- Characters List - prend l'espace restant -->
      <div
        class="bg-charcoal-elegant border border-slate-400/30 shadow-2xl rounded-xl p-4 lg:p-6 xl:p-8 2xl:p-10 fhd:p-12 2k:p-16 4k:p-24 overflow-y-auto scrollbar-hide flex-1"
      >
        <div class="space-y-4">
          <!-- Character Slot 1 -->
          <div
            class="character-slot bg-charcoal-elegant-gray rounded-lg p-4 cursor-pointer hover:scale-102 hover:shadow-lg hover:shadow-gray-400/30 hover:bg-gray-600/60 transition-all duration-200 ease-out hover:border-gray-400/70 flex flex-col justify-center items-center text-center"
            :class="{
              'border-gray-300/80 bg-gradient-to-br from-gray-600/90 via-gray-500/80 to-gray-600/90':
                selectedSlot === 1,
            }"
            @click="selectSlot(1, false)"
          >
            <div
              class="w-12 h-12 2k:w-20 2k:h-20 bg-gray-600/30 rounded-full mx-auto mb-3 2k:mb-6 flex items-center justify-center border-2 border-dashed border-gray-500/50"
            >
              <VIcon icon="mdi-account" class="text-gray-300 2k:!text-4xl" />
            </div>
            <h3 class="text-lg 2k:text-3xl font-medium text-gray-100 mb-2 2k:mb-4 truncate w-full">
              John Doe
            </h3>
            <p class="text-sm 2k:text-xl text-gray-500 mb-1 2k:mb-2 truncate w-full">Sans emploi</p>
            <p class="text-sm 2k:text-xl text-gray-400 mb-1 2k:mb-2 truncate w-full">
              Los Santos Cartel - Lieutenant
            </p>
            <p class="text-xs 2k:text-lg text-gray-500 truncate w-full">Il y a 2 heures</p>
          </div>

          <!-- Character Slot 2 -->
          <div
            class="character-slot bg-charcoal-elegant-gray rounded-lg p-4 cursor-pointer hover:scale-102 hover:shadow-lg hover:shadow-gray-400/30 hover:bg-gray-600/60 transition-all duration-200 ease-out hover:border-gray-400/70 flex flex-col justify-center items-center text-center"
            :class="{
              'border-gray-300/80 bg-gradient-to-br from-gray-600/90 via-gray-500/80 to-gray-600/90':
                selectedSlot === 2,
            }"
            @click="selectSlot(2, false)"
          >
            <div
              class="w-12 h-12 2k:w-20 2k:h-20 bg-gray-600/30 rounded-full mx-auto mb-3 2k:mb-6 flex items-center justify-center border-2 border-dashed border-gray-500/50"
            >
              <VIcon icon="mdi-account" class="text-gray-300 2k:!text-4xl" />
            </div>
            <h3 class="text-lg 2k:text-3xl font-medium text-gray-100 mb-2 2k:mb-4 truncate w-full">
              Jane Smith
            </h3>
            <p class="text-sm 2k:text-xl text-gray-400 mb-1 2k:mb-2 truncate w-full">
              Médecin - Praticien
            </p>
            <p class="text-sm 2k:text-xl text-gray-500 mb-1 2k:mb-2 truncate w-full">Aucun crew</p>
            <p class="text-xs 2k:text-lg text-gray-500 truncate w-full">Il y a 1 jour</p>
          </div>

          <!-- Empty Slots -->
          <div
            v-for="slotId in [3, 4, 5]"
            :key="slotId"
            class="character-slot bg-charcoal-elegant-gray rounded-lg p-4 cursor-pointer hover:scale-102 hover:shadow-lg hover:shadow-gray-400/30 hover:bg-gray-600/60 transition-all duration-200 ease-out hover:border-gray-400/70 flex flex-col justify-center items-center text-center"
            :class="{
              'border-gray-300/80 bg-gradient-to-br from-gray-600/90 via-gray-500/80 to-gray-600/90':
                selectedSlot === slotId,
            }"
            @click="selectSlot(slotId, true)"
          >
            <div
              class="w-12 h-12 2k:w-20 2k:h-20 bg-gray-600/30 rounded-full mx-auto mb-3 2k:mb-6 flex items-center justify-center border-2 border-dashed border-gray-500/50"
            >
              <VIcon icon="mdi-plus" class="text-gray-400 2k:!text-4xl" />
            </div>
            <h3 class="text-lg 2k:text-3xl font-medium text-gray-400 mb-1 2k:mb-2">Slot vide</h3>
            <p class="text-sm 2k:text-xl text-gray-500">Créer un personnage</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Section droite - Détails du personnage -->
    <div
      v-if="selectedSlot && !isSlotEmpty"
      class="absolute right-8 lg:right-12 xl:right-8 2xl:right-12 fhd:right-16 2k:right-16 4k:right-48 top-8 lg:top-12 xl:top-16 2xl:top-16 fhd:top-16 2k:top-16 4k:top-48 w-80 lg:w-72 xl:w-80 2xl:w-80 fhd:w-96 2k:w-[36rem] 4k:w-[60rem] h-3/4 lg:h-[70%] xl:h-2/3 2xl:h-2/3 2k:h-[73%] bg-charcoal-elegant border border-slate-400/30 shadow-2xl rounded-xl p-4 lg:p-6 xl:p-8 2xl:p-10 fhd:p-12 2k:p-16 4k:p-24 flex flex-col"
    >
      <div
        class="text-center mb-6 2k:mb-8 2k:p-0 2k:m-0 2k:h-20 2k:flex 2k:items-start 2k:justify-center 2k:pt-0"
      >
        <h2
          class="text-2xl lg:text-lg xl:text-2xl 2xl:text-xl fhd:text-2xl 2k:text-5xl font-bold bg-gradient-to-r from-white to-blue-400 bg-clip-text text-transparent whitespace-nowrap 2k:p-0 2k:m-0 2k:leading-normal 2k:h-auto 2k:-mt-2"
        >
          Détails du personnage
        </h2>
      </div>

      <div class="space-y-4 2k:space-y-8 overflow-y-auto scrollbar-hide flex-1">
        <!-- Identity -->
        <div
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4 2k:p-8"
        >
          <h3
            class="text-lg lg:text-base xl:text-lg 2xl:text-base 2k:text-4xl font-semibold text-gray-100 mb-3 2k:mb-6 flex items-center gap-2 2k:gap-4"
          >
            <VIcon icon="mdi-account-outline" class="text-blue-400 2k:!text-4xl" />
            Identité
          </h3>
          <div class="space-y-2 2k:space-y-4 text-sm lg:text-xs xl:text-sm 2xl:text-xs 2k:text-2xl">
            <div>
              <span class="text-gray-400">Prénom :</span>
              <p class="text-gray-100 font-medium">
                {{ characterData[selectedSlot]?.firstName || 'Inconnu' }}
              </p>
            </div>
            <div>
              <span class="text-gray-400">Nom :</span>
              <p class="text-gray-100 font-medium">
                {{ characterData[selectedSlot]?.lastName || 'Inconnu' }}
              </p>
            </div>
          </div>
        </div>

        <!-- Job -->
        <div
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4 2k:p-8"
        >
          <h3
            class="text-lg lg:text-base xl:text-lg 2xl:text-base 2k:text-4xl font-semibold text-gray-100 mb-3 2k:mb-6 flex items-center gap-2 2k:gap-4"
          >
            <VIcon icon="mdi-briefcase-outline" class="text-green-400 2k:!text-4xl" />
            Emploi
          </h3>
          <div
            v-if="characterData[selectedSlot]?.job"
            class="space-y-2 2k:space-y-4 text-sm lg:text-xs xl:text-sm 2xl:text-xs 2k:text-2xl"
          >
            <div>
              <span class="text-gray-400">Métier :</span>
              <p class="text-gray-100 font-medium">{{ characterData[selectedSlot]?.job }}</p>
            </div>
            <div>
              <span class="text-gray-400">Grade :</span>
              <p class="text-gray-100 font-medium">{{ characterData[selectedSlot]?.jobGrade }}</p>
            </div>
          </div>
          <div v-else class="text-gray-500 text-sm lg:text-xs xl:text-sm 2xl:text-xs 2k:text-2xl">
            Aucun emploi
          </div>
        </div>

        <!-- Crew -->
        <div
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4 2k:p-8"
        >
          <h3
            class="text-lg lg:text-base xl:text-lg 2xl:text-base 2k:text-4xl font-semibold text-gray-100 mb-3 2k:mb-6 flex items-center gap-2 2k:gap-4"
          >
            <VIcon icon="mdi-account-group-outline" class="text-red-400 2k:!text-4xl" />
            Crew
          </h3>
          <div
            v-if="characterData[selectedSlot]?.crew"
            class="space-y-2 2k:space-y-4 text-sm lg:text-xs xl:text-sm 2xl:text-xs 2k:text-2xl"
          >
            <div>
              <span class="text-gray-400">Organisation :</span>
              <p class="text-gray-100 font-medium">{{ characterData[selectedSlot]?.crew }}</p>
            </div>
            <div>
              <span class="text-gray-400">Grade :</span>
              <p class="text-gray-100 font-medium">
                {{ characterData[selectedSlot]?.crewGrade }}
              </p>
            </div>
          </div>
          <div v-else class="text-gray-500 text-sm lg:text-xs xl:text-sm 2xl:text-xs 2k:text-2xl">
            Aucun crew
          </div>
        </div>

        <!-- Finances -->
        <div
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4 2k:p-8"
        >
          <h3
            class="text-lg lg:text-base xl:text-lg 2xl:text-base 2k:text-4xl font-semibold text-gray-100 mb-3 2k:mb-6 flex items-center gap-2 2k:gap-4"
          >
            <VIcon icon="mdi-cash-multiple" class="text-green-400 2k:!text-4xl" />
            Finances
          </h3>
          <div class="space-y-2 2k:space-y-4 text-sm lg:text-xs xl:text-sm 2xl:text-xs 2k:text-2xl">
            <div>
              <span class="text-gray-400">Argent liquide :</span>
              <p class="text-green-400 font-medium">
                {{ characterData[selectedSlot]?.cash?.toLocaleString() || '0' }}$
              </p>
            </div>
            <div>
              <span class="text-gray-400">Compte bancaire :</span>
              <p class="text-blue-400 font-medium">
                {{ characterData[selectedSlot]?.bank?.toLocaleString() || '0' }}$
              </p>
            </div>
            <div>
              <span class="text-gray-400">Argent sale :</span>
              <p class="text-red-400 font-medium">
                {{ characterData[selectedSlot]?.dirtyMoney?.toLocaleString() || '0' }}$
              </p>
            </div>
          </div>
        </div>

        <!-- Licenses -->
        <div
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4 2k:p-8"
        >
          <h3
            class="text-lg lg:text-base xl:text-lg 2xl:text-base 2k:text-4xl font-semibold text-gray-100 mb-3 2k:mb-6 flex items-center gap-2 2k:gap-4"
          >
            <VIcon icon="mdi-card-account-details-outline" class="text-purple-400 2k:!text-4xl" />
            Licenses et Permis
          </h3>
          <div v-if="characterData[selectedSlot]?.licenses?.length" class="space-y-1 2k:space-y-3">
            <div
              v-for="license in characterData[selectedSlot]?.licenses"
              :key="license"
              class="flex items-center gap-2 2k:gap-4 text-sm lg:text-xs xl:text-sm 2xl:text-xs 2k:text-2xl"
            >
              <VIcon icon="mdi-check-circle" class="text-green-400 text-xs 2k:!text-2xl" />
              <span class="text-gray-100">{{ license }}</span>
            </div>
          </div>
          <div v-else class="text-gray-500 text-sm lg:text-xs xl:text-sm 2xl:text-xs 2k:text-2xl">
            Aucune license
          </div>
        </div>

        <!-- Stats -->
        <div
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4 2k:p-8"
        >
          <h3
            class="text-lg lg:text-base xl:text-lg 2xl:text-base 2k:text-4xl font-semibold text-gray-100 mb-3 2k:mb-6 flex items-center gap-2 2k:gap-4"
          >
            <VIcon icon="mdi-chart-line-variant" class="text-yellow-400 2k:!text-4xl" />
            Statistiques
          </h3>
          <div class="space-y-2 2k:space-y-4 text-sm lg:text-xs xl:text-sm 2xl:text-xs 2k:text-2xl">
            <div>
              <span class="text-gray-400">Temps de jeu total :</span>
              <p class="text-gray-100 font-medium">
                {{ characterData[selectedSlot]?.totalPlaytime || '0h 0m' }}
              </p>
            </div>
            <div>
              <span class="text-gray-400">Dernière connexion :</span>
              <p class="text-gray-100 font-medium">
                {{ characterData[selectedSlot]?.lastPlayed || 'Jamais' }}
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Action Buttons - Positionnés en bas du container de droite -->
    <div
      class="absolute bottom-8 lg:bottom-12 xl:bottom-24 2xl:bottom-20 fhd:bottom-24 2k:bottom-24 4k:bottom-48 right-8 lg:right-12 xl:right-16 2xl:right-20 fhd:right-24 2k:right-32 4k:right-48 z-50"
    >
      <!-- Bouton pour slot vide -->
      <div v-if="selectedSlot && isSlotEmpty">
        <VBtn
          :size="'large'"
          color="transparent"
          class="bg-charcoal-elegant-forest hover:bg-green-600/95 transition-all duration-300 ease-out hover:scale-105 hover:shadow-xl hover:shadow-green-500/30 !px-4 lg:!px-3 xl:!px-6 2xl:!px-10 fhd:!px-8 2k:!px-10 4k:!px-24 !py-3 lg:!py-2 xl:!py-4 2xl:!py-8 fhd:!py-6 2k:!py-6 4k:!py-16 text-sm lg:!text-[10px] xl:text-lg 2xl:text-xl fhd:!text-lg 2k:!text-2xl 4k:text-4xl font-medium !flex !items-center !justify-center text-white w-64 lg:w-48 xl:w-64 2xl:w-64 fhd:w-80 2k:w-[28rem] 4k:w-[54rem] h-12 lg:h-8 xl:h-12 2xl:h-20 fhd:h-18 2k:!h-24 4k:h-48"
          elevation="0"
          @click="createCharacter"
        >
          <VIcon
            start
            icon="mdi-account-plus"
            class="text-lg lg:text-sm xl:text-lg 2xl:text-3xl fhd:text-4xl 2k:!text-4xl 4k:text-6xl"
          />
          Créer un personnage
        </VBtn>
      </div>

      <!-- Boutons pour personnage existant -->
      <div v-if="selectedSlot && !isSlotEmpty" class="space-y-3 flex flex-col">
        <VBtn
          :size="'large'"
          color="transparent"
          class="bg-charcoal-elegant-forest hover:bg-green-600/95 transition-all duration-300 ease-out hover:scale-105 hover:shadow-xl hover:shadow-green-500/30 !px-4 lg:!px-3 xl:!px-6 2xl:!px-10 fhd:!px-8 2k:!px-10 4k:!px-24 !py-3 lg:!py-2 xl:!py-4 2xl:!py-8 fhd:!py-6 2k:!py-6 4k:!py-16 text-sm lg:!text-[10px] xl:text-lg 2xl:text-xl fhd:!text-lg 2k:!text-2xl 4k:text-4xl font-medium !flex !items-center !justify-center text-white w-64 lg:w-48 xl:w-64 2xl:w-64 fhd:w-80 2k:w-[28rem] 4k:w-[54rem] h-12 lg:h-8 xl:h-12 2xl:h-20 fhd:h-18 2k:!h-24 4k:h-48"
          elevation="0"
          @click="playCharacter"
        >
          <VIcon
            start
            icon="mdi-play"
            class="text-lg lg:text-sm xl:text-lg 2xl:text-3xl fhd:text-4xl 2k:!text-4xl 4k:text-6xl"
          />
          Jouer ce personnage
        </VBtn>

        <VBtn
          :size="'large'"
          color="transparent"
          class="bg-charcoal-elegant-blood hover:bg-red-600/95 transition-all duration-300 ease-out hover:scale-105 hover:shadow-xl hover:shadow-red-500/30 !px-4 lg:!px-3 xl:!px-6 2xl:!px-10 fhd:!px-8 2k:!px-10 4k:!px-24 !py-3 lg:!py-2 xl:!py-4 2xl:!py-8 fhd:!py-6 2k:!py-6 4k:!py-16 text-sm lg:!text-[9px] xl:text-lg 2xl:text-xl fhd:!text-base 2k:!text-2xl 4k:text-4xl font-medium !flex !items-center !justify-center text-white w-64 lg:w-48 xl:w-64 2xl:w-64 fhd:w-80 2k:w-[28rem] 4k:w-[54rem] h-12 lg:h-8 xl:h-12 2xl:h-20 fhd:h-18 2k:!h-24 4k:h-48"
          elevation="0"
          @click="deleteCharacter"
        >
          <VIcon
            start
            icon="mdi-trash-can"
            class="text-lg lg:text-sm xl:text-lg 2xl:text-3xl fhd:text-4xl 2k:!text-4xl 4k:text-6xl"
          />
          Supprimer ce personnage
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
</style>
