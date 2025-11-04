<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import { VBtn, VIcon } from 'vuetify/components'
import { mdiCheckCircle } from '@/icons'

const { t } = useI18n()

const emit = defineEmits<{
  validate: []
}>()

const handleValidate = () => {
  emit('validate')
}
</script>

<template>
  <div class="absolute bottom-24 right-24 z-50">
    <VBtn
      :size="'large'"
      color="transparent"
      class="bg-charcoal-elegant-forest hover:bg-green-600/95 transition-all duration-300 ease-out hover:scale-105 hover:shadow-xl hover:shadow-green-500/30 !px-6 !py-8 !text-base font-semibold !flex !items-center !justify-center text-white w-96 2k:w-[28rem] h-28"
      elevation="0"
      @click="handleValidate"
    >
      <VIcon start :icon="mdiCheckCircle" class="text-lg" />
      {{ t('characterCreation.recap.buttons.validate') }}
    </VBtn>
  </div>
</template>
