<script setup lang="ts">
import { ref } from 'vue'
import CharacterSelectionView from './CharacterSelectionView.vue'

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
            class="!bg-gradient-to-br from-gray-900/90 via-gray-800/85 to-gray-900/90 !border border-gray-400/30 hover:scale-105 transition-transform duration-300"
          >
            <VIcon icon="mdi-menu" color="white" />
          </VBtn>
        </template>

        <VCard
          width="280"
          elevation="0"
          class="!bg-gradient-to-br from-gray-900/90 via-gray-800/85 to-gray-900/90 !border border-gray-400/30 !shadow-2xl"
        >
          <VCardTitle
            class="!text-white !text-sm !font-semibold !py-3 !px-4 flex items-center gap-2 !border-b border-gray-600/30"
          >
            <VIcon icon="mdi-information" class="text-blue-400" size="small" />
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
                  prepend-icon="mdi-check"
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
                  prepend-icon="mdi-check"
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
        class="!bg-gradient-to-br from-gray-900/90 via-gray-800/85 to-gray-900/90 !border border-gray-400/30 hover:scale-105 transition-transform duration-300 !shadow-2xl !rounded-full !w-16 !h-16 !min-w-0"
        @click="handleSettingsClick"
      >
        <VIcon icon="mdi-wrench" color="white" size="large" />
      </VBtn>
    </div>

    <!-- Development Status Bar -->
    <div class="absolute top-4 left-1/2 transform -translate-x-1/2 z-50">
      <div
        class="bg-gradient-to-r from-gray-900/90 to-gray-800/85 border border-gray-400/30 rounded-full px-6 py-2"
      >
        <div class="flex items-center gap-4 text-xs text-gray-300">
          <div class="flex items-center gap-1">
            <div class="w-2 h-2 bg-green-400 rounded-full animate-pulse"></div>
            <span>Dev Mode Active</span>
          </div>
          <div class="w-px h-4 bg-gray-600"></div>
          <div class="flex items-center gap-1">
            <VIcon icon="mdi-nodejs" class="text-green-500 text-sm" />
            <span>Vite HMR</span>
          </div>
          <div class="w-px h-4 bg-gray-600"></div>
          <div class="flex items-center gap-1">
            <VIcon icon="mdi-vuejs" class="text-green-500 text-sm" />
            <span>Vue 3</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Settings Card Modal -->
    <VDialog v-if="currentView === 'menu'" v-model="showSettingsCard" max-width="400" persistent>
      <div class="flex justify-center">
        <VCard
          elevation="0"
          color="transparent"
          class="bg-charcoal-elegant !border border-slate-400/30 !rounded-xl !p-6 !w-full !shadow-2xl"
        >
          <VCardTitle
            class="!text-white !text-xl !font-semibold !py-4 !px-6 text-center !border-b border-slate-600/30"
          >
            <div class="flex items-center justify-between w-full">
              <div></div>
              <span>Interface Selection</span>
              <VBtn
                icon
                size="small"
                color="transparent"
                class="bg-charcoal-elegant-gray"
                @click="closeSettingsCard"
              >
                <VIcon icon="mdi-close" color="white" />
              </VBtn>
            </div>
          </VCardTitle>

          <VCardText class="!p-6">
            <div class="space-y-4">
              <VBtn
                block
                size="large"
                variant="outlined"
                class="bg-charcoal-elegant-gray !text-gray-200 hover:!bg-gray-500/50"
                @click="handleCharacterSelection"
              >
                <VIcon icon="mdi-account-multiple" class="mr-2 !text-gray-200" />
                Character Selection
              </VBtn>

              <VBtn
                block
                size="large"
                variant="outlined"
                class="bg-charcoal-elegant-gray !text-gray-200 hover:!bg-gray-500/50"
                @click="handleIdentityCreator"
              >
                <VIcon icon="mdi-card-account-details" class="mr-2 !text-gray-200" />
                Identity Creator
              </VBtn>

              <VBtn
                block
                size="large"
                variant="outlined"
                class="bg-charcoal-elegant-gray !text-gray-200 hover:!bg-gray-500/50"
                @click="handleCharacterCreator"
              >
                <VIcon icon="mdi-account-plus" class="mr-2 !text-gray-200" />
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
    <div
      v-if="currentView === 'identity-creator'"
      class="fixed inset-0 z-50 flex items-center justify-center"
    >
      <VCard
        elevation="0"
        color="transparent"
        class="bg-charcoal-elegant !border border-slate-400/30 !rounded-xl !p-6 !w-96 !shadow-2xl"
      >
        <VCardTitle
          class="!text-white !text-xl !font-semibold !py-4 !px-6 text-center !border-b border-slate-600/30"
        >
          <div class="flex items-center justify-between w-full">
            <VBtn
              icon
              size="small"
              color="transparent"
              class="bg-charcoal-elegant-gray"
              @click="backToMenu"
            >
              <VIcon icon="mdi-arrow-left" color="white" />
            </VBtn>
            <span>Identity Creator</span>
            <div></div>
          </div>
        </VCardTitle>

        <VCardText class="!p-6">
          <p class="text-gray-300 text-center">Interface de création d'identité à implémenter</p>
        </VCardText>
      </VCard>
    </div>

    <!-- Character Creator View -->
    <div
      v-if="currentView === 'character-creator'"
      class="fixed inset-0 z-50 flex items-center justify-center"
    >
      <VCard
        elevation="0"
        color="transparent"
        class="bg-charcoal-elegant !border border-slate-400/30 !rounded-xl !p-6 !w-96 !shadow-2xl"
      >
        <VCardTitle
          class="!text-white !text-xl !font-semibold !py-4 !px-6 text-center !border-b border-slate-600/30"
        >
          <div class="flex items-center justify-between w-full">
            <VBtn
              icon
              size="small"
              color="transparent"
              class="bg-charcoal-elegant-gray"
              @click="backToMenu"
            >
              <VIcon icon="mdi-arrow-left" color="white" />
            </VBtn>
            <span>Character Creator</span>
            <div></div>
          </div>
        </VCardTitle>

        <VCardText class="!p-6">
          <p class="text-gray-300 text-center">Interface de création de personnage à implémenter</p>
        </VCardText>
      </VCard>
    </div>
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
