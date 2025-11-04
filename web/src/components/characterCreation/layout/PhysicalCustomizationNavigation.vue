<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import { VMenu, VBtn, VList, VListItem } from 'vuetify/components'

const { t } = useI18n()

export interface Category {
  key: string
  titleKey?: string
  title?: string
}

interface Props {
  categories: Category[]
  modelValue: number
}

const props = defineProps<Props>()

const emit = defineEmits<{
  'update:modelValue': [value: number]
}>()

const categoryEmojis = ['💇', '👁️', '🤨', '👃', '😊', '🧔', '🗿', '👄', '🦴', '🦒', '👴', '💄', '😊', '🎭', '☀️', '🔴', '💪', '🩹']

const getCategoryTitle = (category: Category): string => {
  if (category.titleKey) {
    return t(category.titleKey)
  }
  return category.title || category.key
}

const selectCategory = (index: number) => {
  emit('update:modelValue', index)
}
</script>

<template>
  <div class="flex justify-center w-full mb-4">
    <VMenu location="bottom" open-on-hover>
      <template #activator="{ props: menuProps }">
        <VBtn
          v-bind="menuProps"
          variant="outlined"
          size="large"
          class="!bg-slate-900/80 !border-2 !border-blue-900/40 !text-blue-100 hover:!text-white hover:!border-blue-500 transition-all !px-12 !py-6 !text-lg !flex !items-center !justify-center !rounded-xl"
        >
          <div class="flex items-center gap-3">
            <span class="text-2xl">{{ categoryEmojis[modelValue] }}</span>
            <span class="font-semibold">{{ getCategoryTitle(categories[modelValue]) }}</span>
          </div>
        </VBtn>
      </template>
      <VList class="!bg-slate-900/95 !border !border-blue-900/40 !min-w-[300px] !max-h-[500px] !overflow-y-auto">
        <VListItem
          v-for="(category, index) in categories"
          :key="category.key"
          @click="selectCategory(index)"
          class="hover:!bg-blue-900/30 cursor-pointer !text-slate-300 hover:!text-white transition-all !py-3 !text-base !justify-center"
        >
          <div class="flex items-center">
            <span class="mr-3 text-xl">{{ categoryEmojis[index] }}</span>
            <span class="font-medium">{{ getCategoryTitle(category) }}</span>
          </div>
        </VListItem>
      </VList>
    </VMenu>
  </div>
</template>
