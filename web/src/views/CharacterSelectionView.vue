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
      class="absolute left-4 sm:left-6 lg:left-8 top-4 sm:top-6 lg:top-8 w-80 sm:w-96 h-3/4 flex flex-col"
    >
      <!-- Header -->
      <div class="bg-charcoal-elegant border border-slate-400/30 rounded-xl p-4 mb-4 sm:mb-6">
        <div class="flex items-center justify-between">
          <VBtn
            v-if="props.forceVisible"
            icon
            size="small"
            color="transparent"
            class="bg-charcoal-elegant-gray"
            @click="emit('backToMenu')"
          >
            <VIcon icon="mdi-arrow-left" color="white" />
          </VBtn>
          <div v-else class="w-10"></div>
          <h1
            class="text-2xl sm:text-3xl font-bold bg-gradient-to-r from-white to-blue-400 bg-clip-text text-transparent text-center flex-1"
          >
            Character Selection
          </h1>
          <div class="w-10"></div>
        </div>
      </div>

      <!-- Characters List - prend l'espace restant -->
      <div
        class="bg-charcoal-elegant border border-slate-400/30 shadow-2xl rounded-xl p-4 sm:p-6 overflow-y-auto scrollbar-hide flex-1"
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
              class="w-12 h-12 bg-gray-600/30 rounded-full mx-auto mb-3 flex items-center justify-center border-2 border-dashed border-gray-500/50"
            >
              <VIcon icon="mdi-account" class="text-gray-300" />
            </div>
            <h3 class="text-lg font-medium text-gray-100 mb-2 truncate w-full">John Doe</h3>
            <p class="text-sm text-gray-500 mb-1 truncate w-full">Sans emploi</p>
            <p class="text-sm text-gray-400 mb-1 truncate w-full">Los Santos Cartel - Lieutenant</p>
            <p class="text-xs text-gray-500 truncate w-full">Il y a 2 heures</p>
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
              class="w-12 h-12 bg-gray-600/30 rounded-full mx-auto mb-3 flex items-center justify-center border-2 border-dashed border-gray-500/50"
            >
              <VIcon icon="mdi-account" class="text-gray-300" />
            </div>
            <h3 class="text-lg font-medium text-gray-100 mb-2 truncate w-full">Jane Smith</h3>
            <p class="text-sm text-gray-400 mb-1 truncate w-full">Médecin - Praticien</p>
            <p class="text-sm text-gray-500 mb-1 truncate w-full">Aucun crew</p>
            <p class="text-xs text-gray-500 truncate w-full">Il y a 1 jour</p>
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
              class="w-12 h-12 bg-gray-600/30 rounded-full mx-auto mb-3 flex items-center justify-center border-2 border-dashed border-gray-500/50"
            >
              <VIcon icon="mdi-plus" class="text-gray-400" />
            </div>
            <h3 class="text-lg font-medium text-gray-400 mb-1">Slot vide</h3>
            <p class="text-sm text-gray-500">Créer un personnage</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Section droite - Détails du personnage -->
    <div
      v-if="selectedSlot && !isSlotEmpty"
      class="absolute right-4 sm:right-6 lg:right-8 top-4 sm:top-6 lg:top-8 w-80 sm:w-96 h-3/4 bg-charcoal-elegant border border-slate-400/30 shadow-2xl rounded-xl p-4 sm:p-6 overflow-y-auto scrollbar-hide"
    >
      <div class="text-center mb-6">
        <h2
          class="text-2xl font-bold bg-gradient-to-r from-white to-blue-400 bg-clip-text text-transparent"
        >
          Détails du personnage
        </h2>
      </div>

      <div class="space-y-4">
        <!-- Identity -->
        <div
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4"
        >
          <h3 class="text-lg font-semibold text-gray-100 mb-3 flex items-center gap-2">
            <VIcon icon="mdi-account-outline" class="text-blue-400" />
            Identité
          </h3>
          <div class="space-y-2 text-sm">
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
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4"
        >
          <h3 class="text-lg font-semibold text-gray-100 mb-3 flex items-center gap-2">
            <VIcon icon="mdi-briefcase-outline" class="text-green-400" />
            Emploi
          </h3>
          <div v-if="characterData[selectedSlot]?.job" class="space-y-2 text-sm">
            <div>
              <span class="text-gray-400">Métier :</span>
              <p class="text-gray-100 font-medium">{{ characterData[selectedSlot]?.job }}</p>
            </div>
            <div>
              <span class="text-gray-400">Grade :</span>
              <p class="text-gray-100 font-medium">{{ characterData[selectedSlot]?.jobGrade }}</p>
            </div>
          </div>
          <div v-else class="text-gray-500 text-sm">Aucun emploi</div>
        </div>

        <!-- Crew -->
        <div
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4"
        >
          <h3 class="text-lg font-semibold text-gray-100 mb-3 flex items-center gap-2">
            <VIcon icon="mdi-account-group-outline" class="text-red-400" />
            Crew
          </h3>
          <div v-if="characterData[selectedSlot]?.crew" class="space-y-2 text-sm">
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
          <div v-else class="text-gray-500 text-sm">Aucun crew</div>
        </div>

        <!-- Finances -->
        <div
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4"
        >
          <h3 class="text-lg font-semibold text-gray-100 mb-3 flex items-center gap-2">
            <VIcon icon="mdi-cash-multiple" class="text-green-400" />
            Finances
          </h3>
          <div class="space-y-2 text-sm">
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
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4"
        >
          <h3 class="text-lg font-semibold text-gray-100 mb-3 flex items-center gap-2">
            <VIcon icon="mdi-card-account-details-outline" class="text-purple-400" />
            Licenses et Permis
          </h3>
          <div v-if="characterData[selectedSlot]?.licenses?.length" class="space-y-1">
            <div
              v-for="license in characterData[selectedSlot]?.licenses"
              :key="license"
              class="flex items-center gap-2 text-sm"
            >
              <VIcon icon="mdi-check-circle" class="text-green-400 text-xs" />
              <span class="text-gray-100">{{ license }}</span>
            </div>
          </div>
          <div v-else class="text-gray-500 text-sm">Aucune license</div>
        </div>

        <!-- Stats -->
        <div
          class="bg-gradient-to-br from-gray-800/60 via-gray-700/50 to-gray-800/60 border border-gray-600/30 rounded-lg p-4"
        >
          <h3 class="text-lg font-semibold text-gray-100 mb-3 flex items-center gap-2">
            <VIcon icon="mdi-chart-line-variant" class="text-yellow-400" />
            Statistiques
          </h3>
          <div class="space-y-2 text-sm">
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
    <div class="absolute bottom-4 sm:bottom-6 lg:bottom-8 right-4 sm:right-6 lg:right-8 z-50">
      <!-- Bouton pour slot vide -->
      <div v-if="selectedSlot && isSlotEmpty">
        <VBtn
          :size="'large'"
          color="transparent"
          class="bg-charcoal-elegant-forest hover:bg-green-600/95 transition-all duration-300 ease-out hover:scale-105 hover:shadow-xl hover:shadow-green-500/30 !px-4 sm:!px-6 lg:!px-8 xl:!px-10 !py-3 sm:!py-4 lg:!py-6 xl:!py-8 text-sm sm:text-base lg:text-lg xl:text-xl font-medium !flex !items-center !justify-center text-white w-64 sm:w-72 lg:w-80 xl:w-96 h-12 sm:h-14 lg:h-16 xl:h-20"
          elevation="0"
          @click="createCharacter"
        >
          <VIcon start icon="mdi-account-plus" class="text-lg sm:text-xl lg:text-2xl xl:text-3xl" />
          Créer un personnage
        </VBtn>
      </div>

      <!-- Boutons pour personnage existant -->
      <div v-if="selectedSlot && !isSlotEmpty" class="space-y-3 flex flex-col">
        <VBtn
          :size="'large'"
          color="transparent"
          class="bg-charcoal-elegant-forest hover:bg-green-600/95 transition-all duration-300 ease-out hover:scale-105 hover:shadow-xl hover:shadow-green-500/30 !px-4 sm:!px-6 lg:!px-8 xl:!px-10 !py-3 sm:!py-4 lg:!py-6 xl:!py-8 text-sm sm:text-base lg:text-lg xl:text-xl font-medium !flex !items-center !justify-center text-white w-64 sm:w-72 lg:w-80 xl:w-96 h-12 sm:h-14 lg:h-16 xl:h-20"
          elevation="0"
          @click="playCharacter"
        >
          <VIcon start icon="mdi-play" class="text-lg sm:text-xl lg:text-2xl xl:text-3xl" />
          Jouer ce personnage
        </VBtn>

        <VBtn
          :size="'large'"
          color="transparent"
          class="bg-charcoal-elegant-blood hover:bg-red-600/95 transition-all duration-300 ease-out hover:scale-105 hover:shadow-xl hover:shadow-red-500/30 !px-4 sm:!px-6 lg:!px-8 xl:!px-10 !py-3 sm:!py-4 lg:!py-6 xl:!py-8 text-sm sm:text-base lg:text-lg xl:text-xl font-medium !flex !items-center !justify-center text-white w-64 sm:w-72 lg:w-80 xl:w-96 h-12 sm:h-14 lg:h-16 xl:h-20"
          elevation="0"
          @click="deleteCharacter"
        >
          <VIcon start icon="mdi-trash-can" class="text-lg sm:text-xl lg:text-2xl xl:text-3xl" />
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
