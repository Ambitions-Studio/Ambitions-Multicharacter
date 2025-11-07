<script setup lang="ts">
import { useI18n } from 'vue-i18n'

const { t } = useI18n()
</script>

<template>
  <div class="fixed top-6 left-1/2 transform -translate-x-1/2 z-50 pointer-events-none">
    <div class="bg-slate-800/60 rounded border border-slate-700/50 shadow-2xl px-2 py-1.5 2k:px-3 2k:py-2 4k:px-4 4k:py-3">
      <div class="flex items-center gap-2 2k:gap-3 4k:gap-4">
        <!-- Left Click - Pan Camera -->
        <div class="flex items-center gap-1 2k:gap-1.5 4k:gap-2">
          <div
            class="w-6 h-8 2k:w-8 2k:h-11 4k:w-10 4k:h-14 flex items-center justify-center"
            :style="{
              backgroundImage: 'url(images/tips/tips_icon.png)',
              backgroundSize: '300% auto',
              backgroundPosition: '0% center',
              backgroundRepeat: 'no-repeat'
            }"
          />
          <div class="flex flex-col">
            <span class="text-white text-[9px] 2k:text-[10px] 4k:text-xs font-semibold">{{ t('characterCreation.cameraControls.leftClick') }}</span>
            <span class="text-slate-400 text-[7px] 2k:text-[8px] 4k:text-[10px]">{{ t('characterCreation.cameraControls.leftClickDescription') }}</span>
          </div>
        </div>

        <!-- Separator -->
        <div class="w-px h-8 2k:h-10 4k:h-12 bg-slate-700/50"></div>

        <!-- Mouse Wheel - Zoom -->
        <div class="flex items-center gap-1 2k:gap-1.5 4k:gap-2">
          <div
            class="w-6 h-8 2k:w-8 2k:h-11 4k:w-10 4k:h-14 flex items-center justify-center"
            :style="{
              backgroundImage: 'url(images/tips/tips_icon.png)',
              backgroundSize: '300% auto',
              backgroundPosition: '50% center',
              backgroundRepeat: 'no-repeat'
            }"
          />
          <div class="flex flex-col">
            <span class="text-white text-[9px] 2k:text-[10px] 4k:text-xs font-semibold">{{ t('characterCreation.cameraControls.wheel') }}</span>
            <span class="text-slate-400 text-[7px] 2k:text-[8px] 4k:text-[10px]">{{ t('characterCreation.cameraControls.wheelDescription') }}</span>
          </div>
        </div>

        <!-- Separator -->
        <div class="w-px h-8 2k:h-10 4k:h-12 bg-slate-700/50"></div>

        <!-- Right Click - Rotate Character -->
        <div class="flex items-center gap-1 2k:gap-1.5 4k:gap-2">
          <div
            class="w-6 h-8 2k:w-8 2k:h-11 4k:w-10 4k:h-14 flex items-center justify-center"
            :style="{
              backgroundImage: 'url(images/tips/tips_icon.png)',
              backgroundSize: '300% auto',
              backgroundPosition: '100% center',
              backgroundRepeat: 'no-repeat'
            }"
          />
          <div class="flex flex-col">
            <span class="text-white text-[9px] 2k:text-[10px] 4k:text-xs font-semibold">{{ t('characterCreation.cameraControls.rightClick') }}</span>
            <span class="text-slate-400 text-[7px] 2k:text-[8px] 4k:text-[10px]">{{ t('characterCreation.cameraControls.rightClickDescription') }}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
