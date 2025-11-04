<script setup lang="ts">
import { ref, watch } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider, VBtn } from 'vuetify/components'
import { useAppearanceStore } from '@/stores/useAppearanceStore'
import { useCharacterStore } from '@/stores/useCharacterStore'
import AccessoriesNavigation from '@/components/characterCreation/layout/AccessoriesNavigation.vue'

const { t } = useI18n()
const appearanceStore = useAppearanceStore()
const characterStore = useCharacterStore()

const selectedCategory = ref(0)
const previousCategory = ref(0)

const accessoriesCategories = ref([
  { titleKey: 'characterCreation.accessories.categories.hat', key: 'hat' },
  { titleKey: 'characterCreation.accessories.categories.glasses', key: 'glasses' },
  { titleKey: 'characterCreation.accessories.categories.earrings', key: 'earrings' },
  { titleKey: 'characterCreation.accessories.categories.watch', key: 'watch' },
  { titleKey: 'characterCreation.accessories.categories.bracelet', key: 'bracelet' },
  { titleKey: 'characterCreation.accessories.categories.neckAccessory', key: 'neckAccessory' },
])

const props = withDefaults(
  defineProps<{
    hatDrawable?: number
    hatTexture?: number
    glassesDrawable?: number
    glassesTexture?: number
    earringsDrawable?: number
    earringsTexture?: number
    watchDrawable?: number
    watchTexture?: number
    braceletDrawable?: number
    braceletTexture?: number
    neckAccessoryDrawable?: number
    neckAccessoryTexture?: number
  }>(),
  {
    hatDrawable: 0,
    hatTexture: 0,
    glassesDrawable: 0,
    glassesTexture: 0,
    earringsDrawable: 0,
    earringsTexture: 0,
    watchDrawable: 0,
    watchTexture: 0,
    braceletDrawable: 0,
    braceletTexture: 0,
    neckAccessoryDrawable: 0,
    neckAccessoryTexture: 0,
  },
)

const emit = defineEmits<{
  'update:hatDrawable': [value: number]
  'update:hatTexture': [value: number]
  'update:glassesDrawable': [value: number]
  'update:glassesTexture': [value: number]
  'update:earringsDrawable': [value: number]
  'update:earringsTexture': [value: number]
  'update:watchDrawable': [value: number]
  'update:watchTexture': [value: number]
  'update:braceletDrawable': [value: number]
  'update:braceletTexture': [value: number]
  'update:neckAccessoryDrawable': [value: number]
  'update:neckAccessoryTexture': [value: number]
  continue: []
}>()

// Initialize from store if available, otherwise use props
const localHatDrawable = ref(appearanceStore.hatDrawable ?? props.hatDrawable)
const localHatTexture = ref(appearanceStore.hatTexture ?? props.hatTexture)
const localGlassesDrawable = ref(appearanceStore.glassesDrawable ?? props.glassesDrawable)
const localGlassesTexture = ref(appearanceStore.glassesTexture ?? props.glassesTexture)
const localEarringsDrawable = ref(appearanceStore.earringsDrawable ?? props.earringsDrawable)
const localEarringsTexture = ref(appearanceStore.earringsTexture ?? props.earringsTexture)
const localWatchDrawable = ref(appearanceStore.watchDrawable ?? props.watchDrawable)
const localWatchTexture = ref(appearanceStore.watchTexture ?? props.watchTexture)
const localBraceletDrawable = ref(appearanceStore.braceletDrawable ?? props.braceletDrawable)
const localBraceletTexture = ref(appearanceStore.braceletTexture ?? props.braceletTexture)
const localNeckAccessoryDrawable = ref(
  appearanceStore.neckAccessoryDrawable ?? props.neckAccessoryDrawable
)
const localNeckAccessoryTexture = ref(
  appearanceStore.neckAccessoryTexture ?? props.neckAccessoryTexture
)

// Save current section when switching categories
const saveSectionData = (categoryIndex: number) => {
  switch (categoryIndex) {
    case 0: // Hat
      appearanceStore.setHatSection({
        hatDrawable: localHatDrawable.value,
        hatTexture: localHatTexture.value,
      })
      break
    case 1: // Glasses
      appearanceStore.setGlassesSection({
        glassesDrawable: localGlassesDrawable.value,
        glassesTexture: localGlassesTexture.value,
      })
      break
    case 2: // Earrings
      appearanceStore.setEarringsSection({
        earringsDrawable: localEarringsDrawable.value,
        earringsTexture: localEarringsTexture.value,
      })
      break
    case 3: // Watch
      appearanceStore.setWatchSection({
        watchDrawable: localWatchDrawable.value,
        watchTexture: localWatchTexture.value,
      })
      break
    case 4: // Bracelet
      appearanceStore.setBraceletSection({
        braceletDrawable: localBraceletDrawable.value,
        braceletTexture: localBraceletTexture.value,
      })
      break
    case 5: // Neck Accessory
      appearanceStore.setNeckAccessorySection({
        neckAccessoryDrawable: localNeckAccessoryDrawable.value,
        neckAccessoryTexture: localNeckAccessoryTexture.value,
      })
      break
  }
}

// Watch for category changes and save previous section
watch(selectedCategory, (newCategory, oldCategory) => {
  saveSectionData(oldCategory)
  previousCategory.value = oldCategory
})

const handleContinue = () => {
  // Save current section before validating
  saveSectionData(selectedCategory.value)

  // Save ALL accessories data to AppearanceStore (to be sure)
  const accessoriesData = {
    hatDrawable: localHatDrawable.value,
    hatTexture: localHatTexture.value,
    glassesDrawable: localGlassesDrawable.value,
    glassesTexture: localGlassesTexture.value,
    earringsDrawable: localEarringsDrawable.value,
    earringsTexture: localEarringsTexture.value,
    watchDrawable: localWatchDrawable.value,
    watchTexture: localWatchTexture.value,
    braceletDrawable: localBraceletDrawable.value,
    braceletTexture: localBraceletTexture.value,
    neckAccessoryDrawable: localNeckAccessoryDrawable.value,
    neckAccessoryTexture: localNeckAccessoryTexture.value,
  }

  appearanceStore.setAccessories(accessoriesData)

  // Update ONLY accessories section in character store
  characterStore.setAccessories(accessoriesData)

  emit('update:hatDrawable', localHatDrawable.value)
  emit('update:hatTexture', localHatTexture.value)
  emit('update:glassesDrawable', localGlassesDrawable.value)
  emit('update:glassesTexture', localGlassesTexture.value)
  emit('update:earringsDrawable', localEarringsDrawable.value)
  emit('update:earringsTexture', localEarringsTexture.value)
  emit('update:watchDrawable', localWatchDrawable.value)
  emit('update:watchTexture', localWatchTexture.value)
  emit('update:braceletDrawable', localBraceletDrawable.value)
  emit('update:braceletTexture', localBraceletTexture.value)
  emit('update:neckAccessoryDrawable', localNeckAccessoryDrawable.value)
  emit('update:neckAccessoryTexture', localNeckAccessoryTexture.value)

  emit('continue')
}
</script>

<template>
  <div class="space-y-6">
    <AccessoriesNavigation
      v-model="selectedCategory"
      :categories="accessoriesCategories"
    />

    <div class="h-[60vh] overflow-y-scroll pr-2 pb-32">
      <!-- Hat -->
      <div v-if="selectedCategory === 0" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.hat.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.hat.drawable.description') }}
            </p>
            <VSlider
              v-model="localHatDrawable"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.hat.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.hat.texture.description') }}
            </p>
            <VSlider
              v-model="localHatTexture"
              :min="0"
              :max="50"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Glasses -->
      <div v-if="selectedCategory === 1" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.glasses.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.glasses.drawable.description') }}
            </p>
            <VSlider
              v-model="localGlassesDrawable"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.glasses.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.glasses.texture.description') }}
            </p>
            <VSlider
              v-model="localGlassesTexture"
              :min="0"
              :max="50"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Earrings -->
      <div v-if="selectedCategory === 2" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.earrings.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.earrings.drawable.description') }}
            </p>
            <VSlider
              v-model="localEarringsDrawable"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.earrings.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.earrings.texture.description') }}
            </p>
            <VSlider
              v-model="localEarringsTexture"
              :min="0"
              :max="50"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Watch -->
      <div v-if="selectedCategory === 3" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.watch.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.watch.drawable.description') }}
            </p>
            <VSlider
              v-model="localWatchDrawable"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.watch.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.watch.texture.description') }}
            </p>
            <VSlider
              v-model="localWatchTexture"
              :min="0"
              :max="50"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Bracelet -->
      <div v-if="selectedCategory === 4" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.bracelet.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.bracelet.drawable.description') }}
            </p>
            <VSlider
              v-model="localBraceletDrawable"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.bracelet.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.bracelet.texture.description') }}
            </p>
            <VSlider
              v-model="localBraceletTexture"
              :min="0"
              :max="50"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Neck Accessory -->
      <div v-if="selectedCategory === 5" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.neckAccessory.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.neckAccessory.drawable.description') }}
            </p>
            <VSlider
              v-model="localNeckAccessoryDrawable"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>

          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.accessories.neckAccessory.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.accessories.neckAccessory.texture.description') }}
            </p>
            <VSlider
              v-model="localNeckAccessoryTexture"
              :min="0"
              :max="50"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Continue Button for Accessories -->
      <div class="mt-6 flex justify-center">
      <VBtn
        variant="outlined"
        size="large"
        class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
        elevation="0"
        @click="handleContinue"
      >
        <span class="text-base tracking-wide uppercase">
          {{ t('characterCreation.accessories.validateButton') }}
        </span>
      </VBtn>
      </div>
    </div>
  </div>
</template>
