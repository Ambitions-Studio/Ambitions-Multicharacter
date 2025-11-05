<script setup lang="ts">
import { computed } from 'vue'
import { useI18n } from 'vue-i18n'
import {
  mdiAccountOutline,
  mdiBriefcaseOutline,
  mdiAccountGroupOutline,
  mdiCashMultiple,
  mdiCardAccountDetailsOutline,
  mdiCheckCircle,
  mdiChartLineVariant,
} from '@/icons'
import type { Character } from './CharacterSlot.vue'
import CategorySection from './CategorySection.vue'

const { t } = useI18n()

const props = defineProps<{
  character: Character
}>()

const identityItems = computed(() => [
  {
    label: t('characterSelection.fields.firstName'),
    value: props.character.firstName || t('common.unknown'),
  },
  {
    label: t('characterSelection.fields.lastName'),
    value: props.character.lastName || t('common.unknown'),
  },
])

const jobItems = computed(() =>
  props.character.job
    ? [
        { label: t('characterSelection.fields.profession'), value: props.character.job },
        {
          label: t('characterSelection.fields.grade'),
          value: props.character.jobGrade || undefined,
        },
      ]
    : [],
)

const crewItems = computed(() =>
  props.character.crew
    ? [
        { label: t('characterSelection.fields.crewName'), value: props.character.crew },
        {
          label: t('characterSelection.fields.grade'),
          value: props.character.crewGrade || undefined,
        },
      ]
    : [],
)

const financeItems = computed(() => [
  {
    label: t('characterSelection.fields.cash'),
    value: `${props.character.cash?.toLocaleString() || '0'}$`,
    valueColor: 'text-green-400',
  },
  {
    label: t('characterSelection.fields.bankAccount'),
    value: `${props.character.bank?.toLocaleString() || '0'}$`,
    valueColor: 'text-blue-400',
  },
  {
    label: t('characterSelection.fields.dirtyMoney'),
    value: `${props.character.dirtyMoney?.toLocaleString() || '0'}$`,
    valueColor: 'text-red-400',
  },
])

const licenseItems = computed(() =>
  props.character.licenses?.map((license) => ({
    label: license,
    labelColor: 'text-white',
    icon: mdiCheckCircle,
    iconColor: 'text-green-400',
  })) || [],
)

const statsItems = computed(() => [
  {
    label: t('characterSelection.fields.totalPlaytime'),
    value: props.character.totalPlaytime || '0h 0m',
  },
  {
    label: t('characterSelection.fields.lastConnection'),
    value: props.character.lastPlayed || t('characterSelection.values.never'),
  },
])
</script>

<template>
  <Transition name="fade-in-right" appear>
    <div
      class="absolute right-16 top-16 w-[38rem] fhd:w-[32rem] 2k:w-[45rem] max-h-[76vh] fhd:max-h-[70vh] 2k:max-h-[80vh] overflow-hidden space-y-8"
    >
      <div class="mb-8">
        <div class="w-16 h-0.5 bg-gradient-to-r from-blue-500 to-cyan-400 mb-4 ml-auto"></div>

        <h1
          class="text-4xl fhd:text-3xl 2k:text-4xl font-black text-white leading-tight tracking-wide text-right"
        >
          {{ t('characterSelection.details.title') }}
          <span class="text-3xl fhd:text-2xl 2k:text-3xl font-light text-blue-200/80">{{
            t('characterSelection.details.subtitle')
          }}</span>
        </h1>
      </div>

      <div
        class="space-y-10 fhd:space-y-5 2k:space-y-8 overflow-y-auto max-h-[calc(76vh-180px)] fhd:max-h-[calc(70vh-150px)] 2k:max-h-[calc(80vh-180px)] pl-3 scrollbar-thin scrollbar-track-slate-800/50 scrollbar-thumb-blue-600/40 hover:scrollbar-thumb-blue-500/60"
      >
        <CategorySection
          :title="t('characterSelection.categories.identity')"
          :icon="mdiAccountOutline"
          icon-color="text-blue-400"
          border-color="border-blue-500/40"
          :items="identityItems"
        />

        <CategorySection
          :title="t('characterSelection.categories.job')"
          :icon="mdiBriefcaseOutline"
          icon-color="text-green-400"
          border-color="border-green-500/40"
          :is-empty="!character.job"
          :empty-text="t('characterSelection.values.noJob')"
          :items="jobItems"
        />

        <CategorySection
          :title="t('characterSelection.categories.crew')"
          :icon="mdiAccountGroupOutline"
          icon-color="text-red-400"
          border-color="border-red-500/40"
          :is-empty="!character.crew"
          :empty-text="t('characterSelection.values.noCrew')"
          :items="crewItems"
        />

        <CategorySection
          :title="t('characterSelection.categories.finances')"
          :icon="mdiCashMultiple"
          icon-color="text-green-400"
          border-color="border-green-500/40"
          :items="financeItems"
        />

        <CategorySection
          :title="t('characterSelection.categories.licenses')"
          :icon="mdiCardAccountDetailsOutline"
          icon-color="text-purple-400"
          border-color="border-purple-500/40"
          :is-empty="!character.licenses?.length"
          :empty-text="t('characterSelection.values.noLicenses')"
          :items="licenseItems"
        />

        <CategorySection
          :title="t('characterSelection.categories.stats')"
          :icon="mdiChartLineVariant"
          icon-color="text-yellow-400"
          border-color="border-yellow-500/40"
          :items="statsItems"
        />
      </div>
    </div>
  </Transition>
</template>

<style scoped>
.fade-in-right-enter-active {
  transition: all 0.6s ease-out;
}

.fade-in-right-enter-from {
  opacity: 0;
  transform: translateX(30px);
}

.fade-in-right-enter-to {
  opacity: 1;
  transform: translateX(0);
}

.fade-in-right-leave-active {
  transition: all 0.4s ease-in;
}

.fade-in-right-leave-from {
  opacity: 1;
  transform: translateX(0);
}

.fade-in-right-leave-to {
  opacity: 0;
  transform: translateX(30px);
}
</style>
