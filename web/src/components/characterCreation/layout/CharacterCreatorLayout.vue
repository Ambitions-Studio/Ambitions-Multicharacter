<script setup lang="ts">
import { mdiArrowLeft } from '@/icons'
import { useI18n } from 'vue-i18n'

const { t } = useI18n()

interface Props {
  forceVisible?: boolean
  isVisible?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  forceVisible: false,
  isVisible: true,
})

const emit = defineEmits<{
  backToMenu: []
}>()
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
    <Transition name="fade-in" appear>
      <div
        class="absolute left-16 top-16 w-[32rem] fhd:w-[28rem] 2k:w-[40rem] max-h-[85vh] overflow-hidden"
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
            class="text-4xl fhd:text-3xl 2k:text-6xl font-black text-white leading-tight tracking-wide"
          >
            {{ t('characterCreation.title.main') }}
            <span class="text-3xl fhd:text-2xl 2k:text-5xl font-light text-blue-200/80">{{
              t('characterCreation.title.sub')
            }}</span>
          </h1>
        </div>

        <slot />
      </div>
    </Transition>

    <slot name="outside-transition" />
  </div>
</template>
