<script setup lang="ts">
import { ref, watch } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider, VBtn } from 'vuetify/components'
import { useAppearanceStore } from '@/stores/useAppearanceStore'
import { useCharacterStore } from '@/stores/useCharacterStore'
import ClothingNavigation from '@/components/characterCreation/layout/ClothingNavigation.vue'

const { t } = useI18n()
const appearanceStore = useAppearanceStore()
const characterStore = useCharacterStore()

const selectedCategory = ref(0)
const previousCategory = ref(0)

const clothingCategories = ref([
  { titleKey: 'characterCreation.clothing.categories.mask', key: 'mask' },
  { titleKey: 'characterCreation.clothing.categories.torso', key: 'torso' },
  { titleKey: 'characterCreation.clothing.categories.undershirt', key: 'undershirt' },
  { titleKey: 'characterCreation.clothing.categories.arms', key: 'arms' },
  { titleKey: 'characterCreation.clothing.categories.jacket', key: 'jacket' },
  { titleKey: 'characterCreation.clothing.categories.bodyArmor', key: 'bodyArmor' },
  { titleKey: 'characterCreation.clothing.categories.decals', key: 'decals' },
  { titleKey: 'characterCreation.clothing.categories.pants', key: 'pants' },
  { titleKey: 'characterCreation.clothing.categories.shoes', key: 'shoes' },
  { titleKey: 'characterCreation.clothing.categories.backpack', key: 'backpack' },
])

const props = withDefaults(
  defineProps<{
    maskDrawable?: number
    maskTexture?: number
    torsoDrawable?: number
    torsoTexture?: number
    undershirtDrawable?: number
    undershirtTexture?: number
    armsDrawable?: number
    armsTexture?: number
    jacketDrawable?: number
    jacketTexture?: number
    bodyArmorDrawable?: number
    bodyArmorTexture?: number
    decalsDrawable?: number
    decalsTexture?: number
    pantsDrawable?: number
    pantsTexture?: number
    shoesDrawable?: number
    shoesTexture?: number
    backpackDrawable?: number
    backpackTexture?: number
  }>(),
  {
    currentSubStep: 0,
    maskDrawable: 0,
    maskTexture: 0,
    torsoDrawable: 0,
    torsoTexture: 0,
    undershirtDrawable: 0,
    undershirtTexture: 0,
    armsDrawable: 0,
    armsTexture: 0,
    jacketDrawable: 0,
    jacketTexture: 0,
    bodyArmorDrawable: 0,
    bodyArmorTexture: 0,
    decalsDrawable: 0,
    decalsTexture: 0,
    pantsDrawable: 0,
    pantsTexture: 0,
    shoesDrawable: 0,
    shoesTexture: 0,
    backpackDrawable: 0,
    backpackTexture: 0,
  },
)

const emit = defineEmits<{
  'update:maskDrawable': [value: number]
  'update:maskTexture': [value: number]
  'update:torsoDrawable': [value: number]
  'update:torsoTexture': [value: number]
  'update:undershirtDrawable': [value: number]
  'update:undershirtTexture': [value: number]
  'update:armsDrawable': [value: number]
  'update:armsTexture': [value: number]
  'update:jacketDrawable': [value: number]
  'update:jacketTexture': [value: number]
  'update:bodyArmorDrawable': [value: number]
  'update:bodyArmorTexture': [value: number]
  'update:decalsDrawable': [value: number]
  'update:decalsTexture': [value: number]
  'update:pantsDrawable': [value: number]
  'update:pantsTexture': [value: number]
  'update:shoesDrawable': [value: number]
  'update:shoesTexture': [value: number]
  'update:backpackDrawable': [value: number]
  'update:backpackTexture': [value: number]
  continue: []
}>()

// Initialize from store if available, otherwise use props
const localMaskDrawable = ref(appearanceStore.maskDrawable ?? props.maskDrawable)
const localMaskTexture = ref(appearanceStore.maskTexture ?? props.maskTexture)
const localTorsoDrawable = ref(appearanceStore.torsoDrawable ?? props.torsoDrawable)
const localTorsoTexture = ref(appearanceStore.torsoTexture ?? props.torsoTexture)
const localUndershirtDrawable = ref(appearanceStore.undershirtDrawable ?? props.undershirtDrawable)
const localUndershirtTexture = ref(appearanceStore.undershirtTexture ?? props.undershirtTexture)
const localArmsDrawable = ref(appearanceStore.armsDrawable ?? props.armsDrawable)
const localArmsTexture = ref(appearanceStore.armsTexture ?? props.armsTexture)
const localJacketDrawable = ref(appearanceStore.jacketDrawable ?? props.jacketDrawable)
const localJacketTexture = ref(appearanceStore.jacketTexture ?? props.jacketTexture)
const localBodyArmorDrawable = ref(appearanceStore.bodyArmorDrawable ?? props.bodyArmorDrawable)
const localBodyArmorTexture = ref(appearanceStore.bodyArmorTexture ?? props.bodyArmorTexture)
const localDecalsDrawable = ref(appearanceStore.decalsDrawable ?? props.decalsDrawable)
const localDecalsTexture = ref(appearanceStore.decalsTexture ?? props.decalsTexture)
const localPantsDrawable = ref(appearanceStore.pantsDrawable ?? props.pantsDrawable)
const localPantsTexture = ref(appearanceStore.pantsTexture ?? props.pantsTexture)
const localShoesDrawable = ref(appearanceStore.shoesDrawable ?? props.shoesDrawable)
const localShoesTexture = ref(appearanceStore.shoesTexture ?? props.shoesTexture)
const localBackpackDrawable = ref(appearanceStore.backpackDrawable ?? props.backpackDrawable)
const localBackpackTexture = ref(appearanceStore.backpackTexture ?? props.backpackTexture)

// Save current section when switching categories
const saveSectionData = (categoryIndex: number) => {
  switch (categoryIndex) {
    case 0: // Mask
      appearanceStore.setMaskSection({
        maskDrawable: localMaskDrawable.value,
        maskTexture: localMaskTexture.value,
      })
      break
    case 1: // Torso
      appearanceStore.setTorsoSection({
        torsoDrawable: localTorsoDrawable.value,
        torsoTexture: localTorsoTexture.value,
      })
      break
    case 2: // Undershirt
      appearanceStore.setUndershirtSection({
        undershirtDrawable: localUndershirtDrawable.value,
        undershirtTexture: localUndershirtTexture.value,
      })
      break
    case 3: // Arms
      appearanceStore.setArmsSection({
        armsDrawable: localArmsDrawable.value,
        armsTexture: localArmsTexture.value,
      })
      break
    case 4: // Jacket
      appearanceStore.setJacketSection({
        jacketDrawable: localJacketDrawable.value,
        jacketTexture: localJacketTexture.value,
      })
      break
    case 5: // Body Armor
      appearanceStore.setBodyArmorSection({
        bodyArmorDrawable: localBodyArmorDrawable.value,
        bodyArmorTexture: localBodyArmorTexture.value,
      })
      break
    case 6: // Decals
      appearanceStore.setDecalsSection({
        decalsDrawable: localDecalsDrawable.value,
        decalsTexture: localDecalsTexture.value,
      })
      break
    case 7: // Pants
      appearanceStore.setPantsSection({
        pantsDrawable: localPantsDrawable.value,
        pantsTexture: localPantsTexture.value,
      })
      break
    case 8: // Shoes
      appearanceStore.setShoesSection({
        shoesDrawable: localShoesDrawable.value,
        shoesTexture: localShoesTexture.value,
      })
      break
    case 9: // Backpack
      appearanceStore.setBackpackSection({
        backpackDrawable: localBackpackDrawable.value,
        backpackTexture: localBackpackTexture.value,
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

  // Save ALL clothing data to AppearanceStore (to be sure)
  const clothingData = {
    maskDrawable: localMaskDrawable.value,
    maskTexture: localMaskTexture.value,
    torsoDrawable: localTorsoDrawable.value,
    torsoTexture: localTorsoTexture.value,
    undershirtDrawable: localUndershirtDrawable.value,
    undershirtTexture: localUndershirtTexture.value,
    armsDrawable: localArmsDrawable.value,
    armsTexture: localArmsTexture.value,
    jacketDrawable: localJacketDrawable.value,
    jacketTexture: localJacketTexture.value,
    bodyArmorDrawable: localBodyArmorDrawable.value,
    bodyArmorTexture: localBodyArmorTexture.value,
    decalsDrawable: localDecalsDrawable.value,
    decalsTexture: localDecalsTexture.value,
    pantsDrawable: localPantsDrawable.value,
    pantsTexture: localPantsTexture.value,
    shoesDrawable: localShoesDrawable.value,
    shoesTexture: localShoesTexture.value,
    backpackDrawable: localBackpackDrawable.value,
    backpackTexture: localBackpackTexture.value,
  }

  appearanceStore.setClothing(clothingData)

  // Update ONLY clothing section in character store
  characterStore.setClothing(clothingData)

  emit('update:maskDrawable', localMaskDrawable.value)
  emit('update:maskTexture', localMaskTexture.value)
  emit('update:torsoDrawable', localTorsoDrawable.value)
  emit('update:torsoTexture', localTorsoTexture.value)
  emit('update:undershirtDrawable', localUndershirtDrawable.value)
  emit('update:undershirtTexture', localUndershirtTexture.value)
  emit('update:armsDrawable', localArmsDrawable.value)
  emit('update:armsTexture', localArmsTexture.value)
  emit('update:jacketDrawable', localJacketDrawable.value)
  emit('update:jacketTexture', localJacketTexture.value)
  emit('update:bodyArmorDrawable', localBodyArmorDrawable.value)
  emit('update:bodyArmorTexture', localBodyArmorTexture.value)
  emit('update:decalsDrawable', localDecalsDrawable.value)
  emit('update:decalsTexture', localDecalsTexture.value)
  emit('update:pantsDrawable', localPantsDrawable.value)
  emit('update:pantsTexture', localPantsTexture.value)
  emit('update:shoesDrawable', localShoesDrawable.value)
  emit('update:shoesTexture', localShoesTexture.value)
  emit('update:backpackDrawable', localBackpackDrawable.value)
  emit('update:backpackTexture', localBackpackTexture.value)

  emit('continue')
}
</script>

<template>
  <div class="space-y-6">
    <!-- Menu for Clothing Categories -->
    <ClothingNavigation
      v-model="selectedCategory"
      :categories="clothingCategories"
    />

    <!-- Content Container -->
    <div class="h-[60vh] overflow-y-scroll pr-2 pb-32">
      <!-- Mask -->
      <div v-if="selectedCategory === 0">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.mask.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.mask.drawable.description') }}
            </p>
            <VSlider
              v-model="localMaskDrawable"
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
              {{ t('characterCreation.clothing.mask.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.mask.texture.description') }}
            </p>
            <VSlider
              v-model="localMaskTexture"
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

      <!-- Torso -->
      <div v-if="selectedCategory === 1">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.torso.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.torso.drawable.description') }}
            </p>
            <VSlider
              v-model="localTorsoDrawable"
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
              {{ t('characterCreation.clothing.torso.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.torso.texture.description') }}
            </p>
            <VSlider
              v-model="localTorsoTexture"
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

      <!-- Undershirt -->
      <div v-if="selectedCategory === 2">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.undershirt.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.undershirt.drawable.description') }}
            </p>
            <VSlider
              v-model="localUndershirtDrawable"
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
              {{ t('characterCreation.clothing.undershirt.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.undershirt.texture.description') }}
            </p>
            <VSlider
              v-model="localUndershirtTexture"
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

      <!-- Arms -->
      <div v-if="selectedCategory === 3">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.arms.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.arms.drawable.description') }}
            </p>
            <VSlider
              v-model="localArmsDrawable"
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
              {{ t('characterCreation.clothing.arms.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.arms.texture.description') }}
            </p>
            <VSlider
              v-model="localArmsTexture"
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

      <!-- Jacket -->
      <div v-if="selectedCategory === 4">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.jacket.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.jacket.drawable.description') }}
            </p>
            <VSlider
              v-model="localJacketDrawable"
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
              {{ t('characterCreation.clothing.jacket.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.jacket.texture.description') }}
            </p>
            <VSlider
              v-model="localJacketTexture"
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

      <!-- Body Armor -->
      <div v-if="selectedCategory === 5">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.bodyArmor.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.bodyArmor.drawable.description') }}
            </p>
            <VSlider
              v-model="localBodyArmorDrawable"
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
              {{ t('characterCreation.clothing.bodyArmor.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.bodyArmor.texture.description') }}
            </p>
            <VSlider
              v-model="localBodyArmorTexture"
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

      <!-- Decals -->
      <div v-if="selectedCategory === 6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.decals.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.decals.drawable.description') }}
            </p>
            <VSlider
              v-model="localDecalsDrawable"
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
              {{ t('characterCreation.clothing.decals.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.decals.texture.description') }}
            </p>
            <VSlider
              v-model="localDecalsTexture"
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

      <!-- Pants -->
      <div v-if="selectedCategory === 7">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.pants.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.pants.drawable.description') }}
            </p>
            <VSlider
              v-model="localPantsDrawable"
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
              {{ t('characterCreation.clothing.pants.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.pants.texture.description') }}
            </p>
            <VSlider
              v-model="localPantsTexture"
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

      <!-- Shoes -->
      <div v-if="selectedCategory === 8">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.shoes.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.shoes.drawable.description') }}
            </p>
            <VSlider
              v-model="localShoesDrawable"
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
              {{ t('characterCreation.clothing.shoes.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.shoes.texture.description') }}
            </p>
            <VSlider
              v-model="localShoesTexture"
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

      <!-- Backpack -->
      <div v-if="selectedCategory === 9">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.clothing.backpack.drawable.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.backpack.drawable.description') }}
            </p>
            <VSlider
              v-model="localBackpackDrawable"
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
              {{ t('characterCreation.clothing.backpack.texture.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.clothing.backpack.texture.description') }}
            </p>
            <VSlider
              v-model="localBackpackTexture"
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

      <!-- Continue Button for Clothing -->
      <div class="mt-6 flex justify-center">
        <VBtn
          variant="outlined"
          size="large"
          class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
          elevation="0"
          @click="handleContinue"
        >
          <span class="text-base tracking-wide uppercase">
            {{ t('characterCreation.clothing.validateButton') }}
          </span>
        </VBtn>
      </div>
    </div>
  </div>
</template>
