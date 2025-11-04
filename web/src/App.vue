<script setup lang="ts">
import BoilerplateView from './views/BoilerplateView.vue'
import CharacterSelectionView from './views/CharacterSelectionView.vue'
import IdentityCreatorView from './views/IdentityCreatorView.vue'
import CharacterCreatorView from './views/CharacterCreatorView.vue'

const isDevelopment = import.meta.env.DEV
</script>

<template>
  <VApp>
    <BoilerplateView v-if="isDevelopment" />
    <CharacterSelectionView />
    <IdentityCreatorView />
    <CharacterCreatorView />
  </VApp>
</template>
