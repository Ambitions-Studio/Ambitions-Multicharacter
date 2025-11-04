<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { storeToRefs } from 'pinia'
import { mdiArrowLeft } from '@/icons'
import CustomButton from '@/components/CustomButton.vue'
import IdentitySection from '@/components/identityCreation/IdentitySection.vue'
import BirthSection from '@/components/identityCreation/BirthSection.vue'
import ProfileSection from '@/components/identityCreation/ProfileSection.vue'
import PhysicalSection from '@/components/identityCreation/PhysicalSection.vue'
import { useIdentityCreationStore } from '@/stores/useIdentityCreationStore'
import { useCharacterStore } from '@/stores/useCharacterStore'

const { t } = useI18n()

const props = defineProps<{
  forceVisible?: boolean
}>()

const emit = defineEmits<{
  backToMenu: []
}>()

const identityStore = useIdentityCreationStore()
const characterStore = useCharacterStore()

const { firstName, lastName, dateOfBirth, gender, nationality, height } = storeToRefs(identityStore)

const isVisible = ref<boolean>(false)

const identitySection = ref<InstanceType<typeof IdentitySection> | null>(null)
const birthSection = ref<InstanceType<typeof BirthSection> | null>(null)
const profileSection = ref<InstanceType<typeof ProfileSection> | null>(null)
const physicalSection = ref<InstanceType<typeof PhysicalSection> | null>(null)

const closeInterface = () => {
  isVisible.value = false
  fetch('https://Ambitions-Multicharacter/closeIdentityCreator', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({}),
  }).catch(() => {})
}

const validateForm = () => {
  let isValid = true

  if (identitySection.value && !identitySection.value.validate()) {
    isValid = false
  }

  if (birthSection.value && !birthSection.value.validate()) {
    isValid = false
  }

  if (profileSection.value && !profileSection.value.validate()) {
    isValid = false
  }

  if (physicalSection.value && !physicalSection.value.validate()) {
    isValid = false
  }

  return isValid
}

const submitForm = () => {
  if (!validateForm()) {
    return
  }

  const identityData = identityStore.submitIdentity()

  characterStore.setIdentity(identityData)

  console.log('=== ' + t('identityCreation.debug.identityDataCreated') + ' ===')
  console.log(`${t('identityCreation.debug.lastName')}: ${identityData.lastName}`)
  console.log(`${t('identityCreation.debug.firstName')}: ${identityData.firstName}`)
  console.log(`${t('identityCreation.debug.dateOfBirth')}: ${identityData.dateOfBirth}`)
  console.log(
    `${t('identityCreation.debug.gender')}: ${identityData.gender === 'M' ? t('identityCreation.debug.genderMale') : t('identityCreation.debug.genderFemale')}`,
  )
  console.log(`${t('identityCreation.debug.nationality')}: ${identityData.nationality}`)
  console.log(`${t('identityCreation.debug.height')}: ${identityData.height} cm`)
  console.log('===================================')
  console.log(t('identityCreation.debug.completeObject') + ':', identityData)
  console.log('✅ Character Store Identity:', characterStore.identity)
  console.log('✅ Identity Store (backup):', identityStore.getIdentityData())

  fetch('https://Ambitions-Multicharacter/createIdentity', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(identityData),
  }).catch(() => {})

  closeInterface()
}

onMounted(() => {
  window.addEventListener('message', (event) => {
    if (event.data.action === 'showIdentityCreator') {
      isVisible.value = true
    } else if (event.data.action === 'hideIdentityCreator') {
      isVisible.value = false
    }
  })

  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape' && isVisible.value) {
      closeInterface()
    }
  })
})
</script>

<template>
  <div
    v-if="isVisible || props.forceVisible"
    class="fixed inset-0 w-full h-full z-10"
    style="
      background: linear-gradient(
        to right,
        rgba(15, 23, 42, 1) 0%,
        rgba(15, 23, 42, 0.7) 15%,
        rgba(15, 23, 42, 0.4) 33%,
        transparent 100%
      );
    "
  >
    <Transition name="fade-in" appear>
      <div
        class="absolute left-16 top-[45%] transform -translate-y-1/2 w-[32rem] fhd:w-[28rem] 2k:w-[40rem] max-h-[85vh] overflow-hidden"
      >
        <div class="mb-8">
          <VBtn
            v-if="props.forceVisible"
            icon
            size="small"
            color="transparent"
            class="bg-slate-800/60 border border-blue-500/30 mb-6 hover:bg-slate-700/80 hover:border-blue-400/50 transition-all"
            @click="emit('backToMenu')"
          >
            <VIcon :icon="mdiArrowLeft" color="white" />
          </VBtn>

          <div class="w-16 h-0.5 bg-gradient-to-r from-blue-500 to-cyan-400 mb-4"></div>

          <h1
            class="text-4xl fhd:text-3xl 2k:text-6xl font-black text-white leading-tight tracking-wide"
          >
            {{ t('identityCreation.title') }}
            <span class="text-3xl fhd:text-2xl 2k:text-5xl font-light text-blue-200/80">{{
              t('identityCreation.subtitle')
            }}</span>
          </h1>
        </div>

        <div
          class="space-y-8 fhd:space-y-6 2k:space-y-12 overflow-y-auto max-h-[calc(85vh-180px)] pr-3 scrollbar-thin scrollbar-track-slate-800/50 scrollbar-thumb-blue-600/40 hover:scrollbar-thumb-blue-500/60"
        >
          <IdentitySection
            ref="identitySection"
            v-model:last-name="lastName"
            v-model:first-name="firstName"
          />

          <BirthSection ref="birthSection" v-model:date-of-birth="dateOfBirth" />

          <ProfileSection
            ref="profileSection"
            v-model:gender="gender"
            v-model:nationality="nationality"
          />

          <PhysicalSection ref="physicalSection" v-model:height="height" />

          <div class="pt-6 pb-4 flex justify-center">
            <CustomButton
              variant="outlined-primary"
              size="large"
              width="w-5/6"
              height="h-16 fhd:!h-14 2k:!h-20"
              rounded="rounded-2xl"
              scale-hover="1.01"
              :outline="true"
              outline-color="rgba(255, 255, 255, 0.3)"
              @click="submitForm"
            >
              <span class="text-lg fhd:text-base 2k:text-2xl tracking-wider uppercase">{{
                t('identityCreation.actions.createIdentity')
              }}</span>
            </CustomButton>
          </div>
        </div>
      </div>
    </Transition>

    <div class="absolute right-0 top-0 w-3/5 h-full pointer-events-none"></div>
  </div>
</template>

<style scoped>
:deep(input[type='date']::-webkit-calendar-picker-indicator) {
  filter: invert(1) !important;
  cursor: pointer;
}

:deep(.v-field--outlined .v-field__outline) {
  color: rgba(59, 130, 246, 0.3) !important;
}

:deep(.v-field--focused .v-field__outline) {
  color: rgba(59, 130, 246, 0.8) !important;
}

.fade-in-enter-active {
  transition: all 0.6s ease-out;
}

.fade-in-enter-from {
  opacity: 0;
  transform: translate(-30px, -50%);
}

.fade-in-enter-to {
  opacity: 1;
  transform: translate(0, -50%);
}
</style>
