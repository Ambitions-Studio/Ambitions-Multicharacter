<script setup lang="ts">
import { ref } from 'vue'
import CharacterSelectionView from './CharacterSelectionView.vue'
import IdentityCreatorView from './IdentityCreatorView.vue'
import CharacterCreatorView from './CharacterCreatorView.vue'
import DevInfoMenu from '@/components/boilerplate/DevInfoMenu.vue'
import DevStatusBar from '@/components/boilerplate/DevStatusBar.vue'
import InterfaceSelectionFAB from '@/components/boilerplate/InterfaceSelectionFAB.vue'
import InterfaceSelectionDialog from '@/components/boilerplate/InterfaceSelectionDialog.vue'

const showSelectionDialog = ref(false)
const currentView = ref('menu')

const handleFABClick = () => {
  showSelectionDialog.value = true
}

const handleCharacterSelection = () => {
  currentView.value = 'character-selection'
}

const handleIdentityCreator = () => {
  currentView.value = 'identity-creator'
}

const handleCharacterCreator = () => {
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

    <DevInfoMenu :current-view="currentView" />

    <DevStatusBar />

    <div class="relative z-10 w-full h-full"></div>

    <InterfaceSelectionFAB @click="handleFABClick" />

    <InterfaceSelectionDialog
      v-if="currentView === 'menu'"
      v-model="showSelectionDialog"
      @select-character-selection="handleCharacterSelection"
      @select-identity-creator="handleIdentityCreator"
      @select-character-creator="handleCharacterCreator"
    />

    <CharacterSelectionView
      v-if="currentView === 'character-selection'"
      :force-visible="true"
      @back-to-menu="backToMenu"
    />

    <IdentityCreatorView
      v-if="currentView === 'identity-creator'"
      :force-visible="true"
      @back-to-menu="backToMenu"
    />

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
