<script setup lang="ts">
import { mdiWrench } from '@/icons'

defineEmits<{
  click: []
}>()
</script>

<template>
  <div class="absolute bottom-6 right-6 z-50">
    <VBtn
      icon
      elevation="0"
      class="bg-charcoal-elegant !border border-gray-400/30 hover:scale-105 transition-transform duration-300 !shadow-2xl !rounded-full !w-16 !h-16 2k:!w-24 2k:!h-24 !min-w-0"
      @click="$emit('click')"
    >
      <VIcon :icon="mdiWrench" color="white" size="large" class="2k:!text-4xl" />
    </VBtn>
  </div>
</template>
