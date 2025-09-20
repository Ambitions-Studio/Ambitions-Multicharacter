<script setup lang="ts">
import { ref } from 'vue'
import CharacterSelectionView from './CharacterSelectionView.vue'
import IdentityCreatorView from './IdentityCreatorView.vue'
import CharacterCreatorView from './CharacterCreatorView.vue'
import {
  mdiMenu,
  mdiInformation,
  mdiCheck,
  mdiWrench,
  mdiNodejs,
  mdiVuejs,
  mdiClose,
  mdiAccountMultiple,
  mdiCardAccountDetails,
  mdiAccountPlus,
} from '../icons'

const showSettingsCard = ref(false)
const currentView = ref('menu') // 'menu', 'character-selection', 'identity-creator', 'character-creator'

const handleSettingsClick = () => {
  showSettingsCard.value = true
}

const closeSettingsCard = () => {
  showSettingsCard.value = false
}

const handleCharacterSelection = () => {
  showSettingsCard.value = false
  currentView.value = 'character-selection'
}

const handleIdentityCreator = () => {
  showSettingsCard.value = false
  currentView.value = 'identity-creator'
}

const handleCharacterCreator = () => {
  showSettingsCard.value = false
  currentView.value = 'character-creator'
}

const backToMenu = () => {
  currentView.value = 'menu'
}
</script>

<template>
  <div
    class="fixed inset-0 w-full h-full bg-contain bg-center bg-no-repeat bg-gray-900 sm:bg-contain md:bg-cover lg:bg-cover xl:bg-cover 2xl:bg-cover bg-[url('/boilerplate-background.jpg')] transition-all duration-300"
  >
    <div class="absolute inset-0 bg-black/20"></div>

    <!-- Development Info Panel (Burger Menu) -->
    <div class="absolute top-4 right-4 z-50">
      <VMenu
        open-on-hover
        :close-delay="200"
        :open-delay="100"
        location="bottom end"
        transition="scale-transition"
      >
        <template #activator="{ props }">
          <VBtn
            v-bind="props"
            icon
            size="small"
            color="transparent"
            elevation="0"
            class="bg-charcoal-elegant !border border-gray-400/30 hover:scale-105 transition-transform duration-300 2k:!w-20 2k:!h-20 2k:!min-w-0"
          >
            <VIcon :icon="mdiMenu" color="white" class="2k:!text-3xl" />
          </VBtn>
        </template>

        <VCard
          width="280"
          elevation="0"
          class="bg-charcoal-elegant !border border-gray-400/30 !shadow-2xl"
        >
          <VCardTitle
            class="!text-white !text-sm !font-semibold !py-3 !px-4 flex items-center gap-2 !border-b border-gray-600/30"
          >
            <VIcon :icon="mdiInformation" class="text-blue-400" size="small" />
            Informations Dev
          </VCardTitle>

          <VCardText class="!p-4">
            <div class="space-y-3">
              <div class="flex justify-between items-center">
                <span class="text-gray-300 text-xs">Mode:</span>
                <VChip
                  size="x-small"
                  class="!bg-green-500/20 !text-green-400 !border border-green-500/30"
                  variant="outlined"
                >
                  Development
                </VChip>
              </div>

              <div class="flex justify-between items-center">
                <span class="text-gray-300 text-xs">Vue actuelle:</span>
                <VChip
                  size="x-small"
                  class="!bg-blue-500/20 !text-blue-400 !border border-blue-500/30 !font-mono"
                  variant="outlined"
                >
                  boilerplate
                </VChip>
              </div>

              <div class="flex justify-between items-center">
                <span class="text-gray-300 text-xs">Vuetify:</span>
                <VChip
                  size="x-small"
                  class="!bg-green-500/20 !text-green-400 !border border-green-500/30"
                  variant="outlined"
                  :prepend-icon="mdiCheck"
                >
                  Activé
                </VChip>
              </div>

              <div class="flex justify-between items-center">
                <span class="text-gray-300 text-xs">Tailwind:</span>
                <VChip
                  size="x-small"
                  class="!bg-green-500/20 !text-green-400 !border border-green-500/30"
                  variant="outlined"
                  :prepend-icon="mdiCheck"
                >
                  Activé
                </VChip>
              </div>
            </div>

            <VDivider class="!my-3 !border-gray-600/30" />

            <p class="text-xs text-gray-400">
              Cette interface n'apparaît qu'en mode développement.
            </p>
          </VCardText>
        </VCard>
      </VMenu>
    </div>

    <!-- Content Area -->
    <div class="relative z-10 w-full h-full"></div>

    <!-- FAB Button (Bottom Right) -->
    <div class="absolute bottom-6 right-6 z-50">
      <VBtn
        icon
        elevation="0"
        class="bg-charcoal-elegant !border border-gray-400/30 hover:scale-105 transition-transform duration-300 !shadow-2xl !rounded-full !w-16 !h-16 2k:!w-24 2k:!h-24 !min-w-0"
        @click="handleSettingsClick"
      >
        <VIcon :icon="mdiWrench" color="white" size="large" class="2k:!text-4xl" />
      </VBtn>
    </div>

    <!-- Development Status Bar -->
    <div class="absolute top-4 left-1/2 transform -translate-x-1/2 z-50">
      <div
        class="bg-charcoal-elegant border border-gray-400/30 rounded-full px-6 py-2 2k:px-32 2k:py-10"
      >
        <div
          class="flex items-center justify-center gap-4 2k:gap-16 text-xs 2k:text-2xl text-gray-300"
        >
          <div class="flex items-center justify-center gap-1 2k:gap-4">
            <div class="w-2 h-2 2k:w-8 2k:h-8 bg-green-400 rounded-full animate-pulse"></div>
            <span>Dev Mode Active</span>
          </div>
          <div class="w-px h-4 2k:h-12 bg-gray-600"></div>
          <div class="flex items-center justify-center gap-1 2k:gap-4">
            <VIcon :icon="mdiNodejs" class="text-green-500 text-sm 2k:text-3xl" />
            <span>Vite HMR</span>
          </div>
          <div class="w-px h-4 2k:h-12 bg-gray-600"></div>
          <div class="flex items-center justify-center gap-1 2k:gap-4">
            <VIcon :icon="mdiVuejs" class="text-green-500 text-sm 2k:text-3xl" />
            <span>Vue 3</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Settings Card Modal -->
    <VDialog v-if="currentView === 'menu'" v-model="showSettingsCard" persistent>
      <div class="flex justify-center">
        <VCard
          elevation="0"
          color="transparent"
          class="bg-charcoal-elegant !border border-slate-400/30 !rounded-xl !p-4 lg:!p-5 xl:!p-6 fhd:!p-10 2k:!p-12 w-80 xl:w-80 2xl:w-80 fhd:w-[32rem] 2k:w-[45rem] !shadow-2xl"
        >
          <VCardTitle
            class="!text-white !text-lg lg:!text-xl xl:!text-2xl fhd:!text-3xl 2k:!text-4xl !font-semibold !py-3 lg:!py-4 fhd:!py-6 2k:!py-6 !px-4 lg:!px-5 xl:!px-6 fhd:!px-10 2k:!px-12 text-center !border-b border-slate-600/30"
          >
            <div class="flex items-center justify-between w-full">
              <div></div>
              <span>Interface Selection</span>
              <VBtn
                icon
                size="x-small"
                color="transparent"
                class="bg-charcoal-elegant-gray xl:ml-4 fhd:!w-10 fhd:!h-10 2k:!w-14 2k:!h-14"
                @click="closeSettingsCard"
              >
                <VIcon
                  :icon="mdiClose"
                  color="white"
                  size="small"
                  class="fhd:!text-lg 2k:!text-xl"
                />
              </VBtn>
            </div>
          </VCardTitle>

          <VCardText class="!p-4 lg:!p-5 xl:!p-6 fhd:!p-10 2k:!p-12">
            <div class="space-y-3 lg:space-y-4 fhd:space-y-6 2k:space-y-8">
              <VBtn
                block
                :size="'default'"
                variant="outlined"
                class="bg-charcoal-elegant-gray !text-gray-200 hover:!bg-gray-500/50 !text-xs lg:!text-sm xl:!text-sm fhd:!text-xl 2k:!text-2xl !py-2 lg:!py-3 xl:!py-4 fhd:!py-8 2k:!py-10"
                @click="handleCharacterSelection"
              >
                <VIcon
                  :icon="mdiAccountMultiple"
                  class="mr-2 !text-gray-200 !text-base lg:!text-lg xl:!text-xl 2k:!text-3xl"
                />
                Character Selection
              </VBtn>

              <VBtn
                block
                :size="'default'"
                variant="outlined"
                class="bg-charcoal-elegant-gray !text-gray-200 hover:!bg-gray-500/50 !text-xs lg:!text-sm xl:!text-sm fhd:!text-xl 2k:!text-2xl !py-2 lg:!py-3 xl:!py-4 fhd:!py-8 2k:!py-10"
                @click="handleIdentityCreator"
              >
                <VIcon
                  :icon="mdiCardAccountDetails"
                  class="mr-2 !text-gray-200 !text-base lg:!text-lg xl:!text-xl 2k:!text-3xl"
                />
                Identity Creator
              </VBtn>

              <VBtn
                block
                :size="'default'"
                variant="outlined"
                class="bg-charcoal-elegant-gray !text-gray-200 hover:!bg-gray-500/50 !text-xs lg:!text-sm xl:!text-sm fhd:!text-xl 2k:!text-2xl !py-2 lg:!py-3 xl:!py-4 fhd:!py-8 2k:!py-10"
                @click="handleCharacterCreator"
              >
                <VIcon
                  :icon="mdiAccountPlus"
                  class="mr-2 !text-gray-200 !text-base lg:!text-lg xl:!text-xl 2k:!text-3xl"
                />
                Character Creator
              </VBtn>
            </div>
          </VCardText>
        </VCard>
      </div>
    </VDialog>

    <!-- Character Selection View -->
    <CharacterSelectionView
      v-if="currentView === 'character-selection'"
      :force-visible="true"
      @back-to-menu="backToMenu"
    />

    <!-- Identity Creator View -->
    <IdentityCreatorView
      v-if="currentView === 'identity-creator'"
      :force-visible="true"
      @back-to-menu="backToMenu"
    />

    <!-- Character Creator View -->
    <CharacterCreatorView
      v-if="currentView === 'character-creator'"
      :force-visible="true"
      @back-to-menu="backToMenu"
    />
  </div>
</template>

<style scoped>
.v-enter-active,
.v-leave-active {
  transition: opacity 0.3s ease;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
</style>
