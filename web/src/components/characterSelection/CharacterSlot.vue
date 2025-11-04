<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import { mdiPlus, mdiAccount } from '@/icons'

const { t } = useI18n()

export type Character = {
  firstName: string
  lastName: string
  job: string | null
  jobGrade: string | null
  crew: string | null
  crewGrade: string | null
  cash: number
  bank: number
  dirtyMoney: number
  licenses: string[]
  totalPlaytime: string
  lastPlayed: string
}

const props = defineProps<{
  slotId: number
  isEmpty: boolean
  character?: Character
  isSelected: boolean
}>()

const emit = defineEmits<{
  click: [slotId: number, isEmpty: boolean]
}>()

const handleClick = () => {
  emit('click', props.slotId, props.isEmpty)
}
</script>

<template>
  <div
    class="character-slot cursor-pointer transition-all duration-300 ease-out hover:scale-[1.02] hover:shadow-xl hover:shadow-blue-500/20 p-5 fhd:p-4 2k:p-8 rounded-xl"
    :class="{
      'bg-gradient-to-br from-blue-600/20 via-blue-500/15 to-blue-600/20': isSelected,
      'bg-gradient-to-br from-slate-800/50 via-slate-700/40 to-slate-800/50': !isSelected,
    }"
    @click="handleClick"
  >
    <div class="flex items-center space-x-4">
      <div
        class="w-12 h-12 rounded-full flex items-center justify-center border-2"
        :class="{
          'bg-blue-500/20 border-blue-400/50': isSelected,
          'bg-slate-600/30 border-slate-500/50': !isSelected,
        }"
      >
        <VIcon
          :icon="isEmpty ? mdiPlus : mdiAccount"
          :class="isEmpty ? 'text-slate-400' : isSelected ? 'text-blue-300' : 'text-slate-300'"
        />
      </div>

      <div class="flex-1">
        <template v-if="!isEmpty && character">
          <h3 class="text-lg font-semibold text-white mb-1">
            {{ character.firstName }} {{ character.lastName }}
          </h3>
          <p class="text-sm text-slate-300 mb-1">
            {{ character.job || t('characterSelection.values.noJob') }}
            <template v-if="character.jobGrade"> - {{ character.jobGrade }}</template>
          </p>
          <p class="text-sm text-slate-300 mb-1">
            <template v-if="character.crew">
              {{ character.crew }}
              <template v-if="character.crewGrade"> - {{ character.crewGrade }} </template>
            </template>
            <template v-else>{{ t('characterSelection.values.noCrew') }}</template>
          </p>
          <p class="text-xs text-slate-400">{{ character.lastPlayed }}</p>
        </template>
        <template v-else>
          <h3 class="text-lg font-semibold text-slate-400 mb-1">
            {{ t('characterSelection.slot', { id: slotId }) }}
          </h3>
          <p class="text-sm text-slate-500">{{ t('characterSelection.createNew') }}</p>
        </template>
      </div>

      <div class="text-right">
        <div
          class="w-6 h-6 rounded-full flex items-center justify-center"
          :class="{
            'bg-blue-500/30': isSelected,
            'bg-slate-600/30': !isSelected,
          }"
        >
          <span
            class="text-xs font-bold"
            :class="{
              'text-blue-300': isSelected,
              'text-slate-400': !isSelected,
            }"
            >{{ slotId }}</span
          >
        </div>
      </div>
    </div>
  </div>
</template>
