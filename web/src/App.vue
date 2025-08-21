<script setup lang="ts">
import BoilerplateView from './views/BoilerplateView.vue'
import CharacterSelectionView from './views/CharacterSelectionView.vue'

const isDevelopment = import.meta.env.DEV
</script>

<template>
  <VApp>
    <BoilerplateView v-if="isDevelopment" />
    <CharacterSelectionView />
  </VApp>
</template>
