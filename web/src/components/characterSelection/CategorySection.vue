<script setup lang="ts">
export type CategoryItem = {
  label: string
  value?: string | number
  labelColor?: string
  valueColor?: string
  icon?: string
  iconColor?: string
}

defineProps<{
  title: string
  icon: string
  iconColor: string
  borderColor: string
  isEmpty?: boolean
  emptyText?: string
  items?: CategoryItem[]
}>()
</script>

<template>
  <div class="space-y-4">
    <div class="flex items-center space-x-3 mb-6 justify-end">
      <span class="text-slate-300 text-sm 2k:text-xl font-medium uppercase tracking-widest">{{
        title
      }}</span>
      <div
        class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border flex items-center justify-center"
        :class="borderColor"
      >
        <VIcon :icon="icon" :class="iconColor" class="text-sm" />
      </div>
    </div>

    <div
      class="bg-slate-800/50 rounded-lg p-4 2k:p-6 max-w-sm 2k:max-w-md ml-auto"
      style="border: 1px solid rgba(255, 255, 255, 0.3)"
    >
      <!-- Empty State -->
      <div v-if="isEmpty" class="text-slate-500 text-center py-2 italic">
        {{ emptyText }}
      </div>

      <!-- Items State -->
      <div v-else-if="items && items.length > 0" class="space-y-2">
        <template v-for="(item, index) in items" :key="index">
          <div class="flex items-center justify-between">
            <span
              class="text-sm 2k:text-base font-medium"
              :class="item.labelColor || 'text-slate-400'"
              >{{ item.label }}</span
            >
            <div class="flex items-center gap-2">
              <span
                v-if="item.value !== undefined && item.value !== ''"
                class="2k:text-lg font-semibold"
                :class="item.valueColor || 'text-white'"
                >{{ item.value }}</span
              >
              <VIcon
                v-if="item.icon"
                :icon="item.icon"
                :class="item.iconColor || 'text-green-400'"
                class="text-sm"
              />
            </div>
          </div>
          <div
            v-if="index < items.length - 1"
            class="w-full h-px bg-gradient-to-r from-transparent via-slate-400/70 to-transparent mt-2"
          ></div>
        </template>
      </div>
    </div>
  </div>
</template>
