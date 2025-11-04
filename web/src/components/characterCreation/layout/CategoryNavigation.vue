<script setup lang="ts">
import { useI18n } from 'vue-i18n'

const { t } = useI18n()

export interface Category {
  key: string
  titleKey?: string
  title?: string
}

interface Props {
  categories: Category[]
  currentCategory: number
  columns?: 2 | 3 | 4 | 5 | 6
}

const props = withDefaults(defineProps<Props>(), {
  columns: 3,
})

const emit = defineEmits<{
  'update:currentCategory': [value: number]
  categoryChange: [newCategory: number, oldCategory: number]
}>()

const handleCategoryClick = (index: number) => {
  if (index !== props.currentCategory) {
    const oldCategory = props.currentCategory
    emit('update:currentCategory', index)
    emit('categoryChange', index, oldCategory)
  }
}

const getCategoryTitle = (category: Category): string => {
  if (category.titleKey) {
    return t(category.titleKey)
  }
  return category.title || category.key
}

const gridColsClass = {
  2: 'grid-cols-2',
  3: 'grid-cols-3',
  4: 'grid-cols-4',
  5: 'grid-cols-5',
  6: 'grid-cols-6',
}
</script>

<template>
  <div class="mb-6 flex-shrink-0">
    <div :class="['grid gap-3 text-xs', gridColsClass[columns]]">
      <button
        v-for="(category, index) in categories"
        :key="category.key"
        :class="[
          'px-4 py-3 rounded-lg border-2 transition-all duration-200 hover:scale-105',
          {
            'bg-blue-600/30 border-blue-400 text-blue-300 font-semibold shadow-lg shadow-blue-500/20':
              index === currentCategory,
            'bg-slate-800/40 border-slate-600/50 text-slate-400 hover:bg-slate-700/50 hover:border-slate-500 hover:text-slate-300':
              index !== currentCategory,
          },
        ]"
        @click="handleCategoryClick(index)"
      >
        {{ getCategoryTitle(category) }}
      </button>
    </div>
  </div>
</template>
