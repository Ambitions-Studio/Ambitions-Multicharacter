<script setup lang="ts">
import { ref, watch } from 'vue'
import { useI18n } from 'vue-i18n'
import { VSlider, VBtn } from 'vuetify/components'
import { useAppearanceStore } from '@/stores/useAppearanceStore'
import { useCharacterStore } from '@/stores/useCharacterStore'
import TattoosNavigation from '@/components/characterCreation/layout/TattoosNavigation.vue'

const { t } = useI18n()
const appearanceStore = useAppearanceStore()
const characterStore = useCharacterStore()

const selectedCategory = ref(0)
const previousCategory = ref(0)

const tattoosCategories = ref([
  { titleKey: 'characterCreation.tattoos.categories.head', key: 'head' },
  { titleKey: 'characterCreation.tattoos.categories.neck', key: 'neck' },
  { titleKey: 'characterCreation.tattoos.categories.torso', key: 'torso' },
  { titleKey: 'characterCreation.tattoos.categories.back', key: 'back' },
  { titleKey: 'characterCreation.tattoos.categories.leftArm', key: 'leftArm' },
  { titleKey: 'characterCreation.tattoos.categories.rightArm', key: 'rightArm' },
  { titleKey: 'characterCreation.tattoos.categories.leftLeg', key: 'leftLeg' },
  { titleKey: 'characterCreation.tattoos.categories.rightLeg', key: 'rightLeg' },
])

const props = withDefaults(
  defineProps<{
    headTattooCollection?: number
    headTattooHash?: number
    neckTattooCollection?: number
    neckTattooHash?: number
    torsoTattooCollection?: number
    torsoTattooHash?: number
    backTattooCollection?: number
    backTattooHash?: number
    leftArmTattooCollection?: number
    leftArmTattooHash?: number
    rightArmTattooCollection?: number
    rightArmTattooHash?: number
    leftLegTattooCollection?: number
    leftLegTattooHash?: number
    rightLegTattooCollection?: number
    rightLegTattooHash?: number
  }>(),
  {
    headTattooCollection: 0,
    headTattooHash: 0,
    neckTattooCollection: 0,
    neckTattooHash: 0,
    torsoTattooCollection: 0,
    torsoTattooHash: 0,
    backTattooCollection: 0,
    backTattooHash: 0,
    leftArmTattooCollection: 0,
    leftArmTattooHash: 0,
    rightArmTattooCollection: 0,
    rightArmTattooHash: 0,
    leftLegTattooCollection: 0,
    leftLegTattooHash: 0,
    rightLegTattooCollection: 0,
    rightLegTattooHash: 0,
  },
)

const emit = defineEmits<{
  'update:headTattooCollection': [value: number]
  'update:headTattooHash': [value: number]
  'update:neckTattooCollection': [value: number]
  'update:neckTattooHash': [value: number]
  'update:torsoTattooCollection': [value: number]
  'update:torsoTattooHash': [value: number]
  'update:backTattooCollection': [value: number]
  'update:backTattooHash': [value: number]
  'update:leftArmTattooCollection': [value: number]
  'update:leftArmTattooHash': [value: number]
  'update:rightArmTattooCollection': [value: number]
  'update:rightArmTattooHash': [value: number]
  'update:leftLegTattooCollection': [value: number]
  'update:leftLegTattooHash': [value: number]
  'update:rightLegTattooCollection': [value: number]
  'update:rightLegTattooHash': [value: number]
  continue: []
}>()

const localHeadTattooCollection = ref(
  appearanceStore.headTattooCollection ?? props.headTattooCollection
)
const localHeadTattooHash = ref(appearanceStore.headTattooHash ?? props.headTattooHash)
const localNeckTattooCollection = ref(
  appearanceStore.neckTattooCollection ?? props.neckTattooCollection
)
const localNeckTattooHash = ref(appearanceStore.neckTattooHash ?? props.neckTattooHash)
const localTorsoTattooCollection = ref(
  appearanceStore.torsoTattooCollection ?? props.torsoTattooCollection
)
const localTorsoTattooHash = ref(appearanceStore.torsoTattooHash ?? props.torsoTattooHash)
const localBackTattooCollection = ref(
  appearanceStore.backTattooCollection ?? props.backTattooCollection
)
const localBackTattooHash = ref(appearanceStore.backTattooHash ?? props.backTattooHash)
const localLeftArmTattooCollection = ref(
  appearanceStore.leftArmTattooCollection ?? props.leftArmTattooCollection
)
const localLeftArmTattooHash = ref(appearanceStore.leftArmTattooHash ?? props.leftArmTattooHash)
const localRightArmTattooCollection = ref(
  appearanceStore.rightArmTattooCollection ?? props.rightArmTattooCollection
)
const localRightArmTattooHash = ref(
  appearanceStore.rightArmTattooHash ?? props.rightArmTattooHash
)
const localLeftLegTattooCollection = ref(
  appearanceStore.leftLegTattooCollection ?? props.leftLegTattooCollection
)
const localLeftLegTattooHash = ref(appearanceStore.leftLegTattooHash ?? props.leftLegTattooHash)
const localRightLegTattooCollection = ref(
  appearanceStore.rightLegTattooCollection ?? props.rightLegTattooCollection
)
const localRightLegTattooHash = ref(
  appearanceStore.rightLegTattooHash ?? props.rightLegTattooHash
)

// Save current section when switching categories
const saveSectionData = (categoryIndex: number) => {
  switch (categoryIndex) {
    case 0: // Head
      appearanceStore.setHeadTattooSection({
        headTattooCollection: localHeadTattooCollection.value,
        headTattooHash: localHeadTattooHash.value,
      })
      break
    case 1: // Neck
      appearanceStore.setNeckTattooSection({
        neckTattooCollection: localNeckTattooCollection.value,
        neckTattooHash: localNeckTattooHash.value,
      })
      break
    case 2: // Torso
      appearanceStore.setTorsoTattooSection({
        torsoTattooCollection: localTorsoTattooCollection.value,
        torsoTattooHash: localTorsoTattooHash.value,
      })
      break
    case 3: // Back
      appearanceStore.setBackTattooSection({
        backTattooCollection: localBackTattooCollection.value,
        backTattooHash: localBackTattooHash.value,
      })
      break
    case 4: // Left Arm
      appearanceStore.setLeftArmTattooSection({
        leftArmTattooCollection: localLeftArmTattooCollection.value,
        leftArmTattooHash: localLeftArmTattooHash.value,
      })
      break
    case 5: // Right Arm
      appearanceStore.setRightArmTattooSection({
        rightArmTattooCollection: localRightArmTattooCollection.value,
        rightArmTattooHash: localRightArmTattooHash.value,
      })
      break
    case 6: // Left Leg
      appearanceStore.setLeftLegTattooSection({
        leftLegTattooCollection: localLeftLegTattooCollection.value,
        leftLegTattooHash: localLeftLegTattooHash.value,
      })
      break
    case 7: // Right Leg
      appearanceStore.setRightLegTattooSection({
        rightLegTattooCollection: localRightLegTattooCollection.value,
        rightLegTattooHash: localRightLegTattooHash.value,
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

  // Save ALL tattoos data to AppearanceStore (to be sure)
  const tattoosData = {
    headTattooCollection: localHeadTattooCollection.value,
    headTattooHash: localHeadTattooHash.value,
    neckTattooCollection: localNeckTattooCollection.value,
    neckTattooHash: localNeckTattooHash.value,
    torsoTattooCollection: localTorsoTattooCollection.value,
    torsoTattooHash: localTorsoTattooHash.value,
    backTattooCollection: localBackTattooCollection.value,
    backTattooHash: localBackTattooHash.value,
    leftArmTattooCollection: localLeftArmTattooCollection.value,
    leftArmTattooHash: localLeftArmTattooHash.value,
    rightArmTattooCollection: localRightArmTattooCollection.value,
    rightArmTattooHash: localRightArmTattooHash.value,
    leftLegTattooCollection: localLeftLegTattooCollection.value,
    leftLegTattooHash: localLeftLegTattooHash.value,
    rightLegTattooCollection: localRightLegTattooCollection.value,
    rightLegTattooHash: localRightLegTattooHash.value,
  }

  appearanceStore.setTattoos(tattoosData)

  // Update ONLY tattoos section in character store
  characterStore.setTattoos(tattoosData)
  emit('update:headTattooCollection', localHeadTattooCollection.value)
  emit('update:headTattooHash', localHeadTattooHash.value)
  emit('update:neckTattooCollection', localNeckTattooCollection.value)
  emit('update:neckTattooHash', localNeckTattooHash.value)
  emit('update:torsoTattooCollection', localTorsoTattooCollection.value)
  emit('update:torsoTattooHash', localTorsoTattooHash.value)
  emit('update:backTattooCollection', localBackTattooCollection.value)
  emit('update:backTattooHash', localBackTattooHash.value)
  emit('update:leftArmTattooCollection', localLeftArmTattooCollection.value)
  emit('update:leftArmTattooHash', localLeftArmTattooHash.value)
  emit('update:rightArmTattooCollection', localRightArmTattooCollection.value)
  emit('update:rightArmTattooHash', localRightArmTattooHash.value)
  emit('update:leftLegTattooCollection', localLeftLegTattooCollection.value)
  emit('update:leftLegTattooHash', localLeftLegTattooHash.value)
  emit('update:rightLegTattooCollection', localRightLegTattooCollection.value)
  emit('update:rightLegTattooHash', localRightLegTattooHash.value)

  emit('continue')
}
</script>

<template>
  <div class="space-y-6">
    <TattoosNavigation
      v-model="selectedCategory"
      :categories="tattoosCategories"
    />

    <div class="h-[60vh] overflow-y-scroll pr-2 pb-32">
      <!-- Head -->
      <div v-if="selectedCategory === 0" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.head.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.head.collection.description') }}
            </p>
            <VSlider
              v-model="localHeadTattooCollection"
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
              {{ t('characterCreation.tattoos.head.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.head.hash.description') }}
            </p>
            <VSlider
              v-model="localHeadTattooHash"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Neck -->
      <div v-if="selectedCategory === 1" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.neck.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.neck.collection.description') }}
            </p>
            <VSlider
              v-model="localNeckTattooCollection"
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
              {{ t('characterCreation.tattoos.neck.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.neck.hash.description') }}
            </p>
            <VSlider
              v-model="localNeckTattooHash"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Torso -->
      <div v-if="selectedCategory === 2" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.torso.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.torso.collection.description') }}
            </p>
            <VSlider
              v-model="localTorsoTattooCollection"
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
              {{ t('characterCreation.tattoos.torso.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.torso.hash.description') }}
            </p>
            <VSlider
              v-model="localTorsoTattooHash"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Back -->
      <div v-if="selectedCategory === 3" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.back.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.back.collection.description') }}
            </p>
            <VSlider
              v-model="localBackTattooCollection"
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
              {{ t('characterCreation.tattoos.back.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.back.hash.description') }}
            </p>
            <VSlider
              v-model="localBackTattooHash"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Left Arm -->
      <div v-if="selectedCategory === 4" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.leftArm.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.leftArm.collection.description') }}
            </p>
            <VSlider
              v-model="localLeftArmTattooCollection"
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
              {{ t('characterCreation.tattoos.leftArm.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.leftArm.hash.description') }}
            </p>
            <VSlider
              v-model="localLeftArmTattooHash"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Right Arm -->
      <div v-if="selectedCategory === 5" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.rightArm.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.rightArm.collection.description') }}
            </p>
            <VSlider
              v-model="localRightArmTattooCollection"
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
              {{ t('characterCreation.tattoos.rightArm.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.rightArm.hash.description') }}
            </p>
            <VSlider
              v-model="localRightArmTattooHash"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Left Leg -->
      <div v-if="selectedCategory === 6" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.leftLeg.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.leftLeg.collection.description') }}
            </p>
            <VSlider
              v-model="localLeftLegTattooCollection"
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
              {{ t('characterCreation.tattoos.leftLeg.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.leftLeg.hash.description') }}
            </p>
            <VSlider
              v-model="localLeftLegTattooHash"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Right Leg -->
      <div v-if="selectedCategory === 7" class="space-y-6">
        <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30 space-y-6">
          <div>
            <label class="block text-slate-300 text-sm font-medium mb-3">
              {{ t('characterCreation.tattoos.rightLeg.collection.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.rightLeg.collection.description') }}
            </p>
            <VSlider
              v-model="localRightLegTattooCollection"
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
              {{ t('characterCreation.tattoos.rightLeg.hash.title') }}
            </label>
            <p class="text-slate-500 text-xs mb-4">
              {{ t('characterCreation.tattoos.rightLeg.hash.description') }}
            </p>
            <VSlider
              v-model="localRightLegTattooHash"
              :min="0"
              :max="100"
              :step="1"
              color="blue"
              thumb-label
              class="mt-2"
            />
          </div>
        </div>
      </div>

      <!-- Continue Button for Tattoos -->
      <div class="mt-6 flex justify-center">
      <VBtn
        variant="outlined"
        size="large"
        class="bg-charcoal-elegant-forest !text-white font-semibold !border-2 !border-emerald-500 hover:!border-emerald-400 hover:!bg-emerald-600/50 rounded-lg hover:scale-[1.02] hover:shadow-lg hover:shadow-emerald-500/20 transition-all duration-300 !flex !items-center !justify-center px-8"
        elevation="0"
        @click="handleContinue"
      >
        <span class="text-base tracking-wide uppercase">
          {{ t('characterCreation.tattoos.validateButton') }}
        </span>
      </VBtn>
      </div>
    </div>
  </div>
</template>
