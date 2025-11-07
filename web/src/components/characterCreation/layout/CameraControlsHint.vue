<script setup lang="ts">
import { useI18n } from 'vue-i18n'

const { t } = useI18n()
</script>

<template>
  <div class="fixed top-6 left-1/2 transform -translate-x-1/2 z-50 pointer-events-none">
    <div class="bg-slate-900/90 backdrop-blur-sm rounded-lg border border-slate-700/50 shadow-2xl px-4 py-2.5">
      <div class="flex items-center gap-4">
        <!-- Left Click - Pan Camera -->
        <div class="flex items-center gap-2">
          <div
            class="w-10 h-14 flex items-center justify-center"
            :style="{
              backgroundImage: 'url(/images/tips/tips_icon.png)',
              backgroundSize: '300% auto',
              backgroundPosition: '0% center',
              backgroundRepeat: 'no-repeat'
            }"
          />
          <div class="flex flex-col">
            <span class="text-white text-xs font-semibold">{{ t('characterCreation.cameraControls.leftClick') }}</span>
            <span class="text-slate-400 text-[10px]">{{ t('characterCreation.cameraControls.leftClickDescription') }}</span>
          </div>
        </div>

        <!-- Separator -->
        <div class="w-px h-12 bg-slate-700/50"></div>

        <!-- Mouse Wheel - Zoom -->
        <div class="flex items-center gap-2">
          <div
            class="w-10 h-14 flex items-center justify-center"
            :style="{
              backgroundImage: 'url(/images/tips/tips_icon.png)',
              backgroundSize: '300% auto',
              backgroundPosition: '50% center',
              backgroundRepeat: 'no-repeat'
            }"
          />
          <div class="flex flex-col">
            <span class="text-white text-xs font-semibold">{{ t('characterCreation.cameraControls.wheel') }}</span>
            <span class="text-slate-400 text-[10px]">{{ t('characterCreation.cameraControls.wheelDescription') }}</span>
          </div>
        </div>

        <!-- Separator -->
        <div class="w-px h-12 bg-slate-700/50"></div>

        <!-- Right Click - Rotate Character -->
        <div class="flex items-center gap-2">
          <div
            class="w-10 h-14 flex items-center justify-center"
            :style="{
              backgroundImage: 'url(/images/tips/tips_icon.png)',
              backgroundSize: '300% auto',
              backgroundPosition: '100% center',
              backgroundRepeat: 'no-repeat'
            }"
          />
          <div class="flex flex-col">
            <span class="text-white text-xs font-semibold">{{ t('characterCreation.cameraControls.rightClick') }}</span>
            <span class="text-slate-400 text-[10px]">{{ t('characterCreation.cameraControls.rightClickDescription') }}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
