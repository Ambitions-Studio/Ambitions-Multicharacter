<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { mdiArrowLeft } from '../icons'
import { countries } from '../utils/countries'

const { t } = useI18n()

const props = defineProps<{
  forceVisible?: boolean
}>()

const emit = defineEmits<{
  backToMenu: []
}>()

const isVisible = ref<boolean>(false)

const firstName = ref('')
const lastName = ref('')
const dateOfBirth = ref('')
const gender = ref('')
const nationality = ref('')
const height = ref(170)

const firstNameError = ref('')
const lastNameError = ref('')
const dateOfBirthError = ref('')
const genderError = ref('')
const nationalityError = ref('')

let firstNameTimer: ReturnType<typeof setTimeout> | null = null
let lastNameTimer: ReturnType<typeof setTimeout> | null = null
let dateOfBirthTimer: ReturnType<typeof setTimeout> | null = null

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

const clearErrors = () => {
  firstNameError.value = ''
  lastNameError.value = ''
  dateOfBirthError.value = ''
  genderError.value = ''
  nationalityError.value = ''
}

const validateForm = () => {
  clearErrors()
  let isValid = true

  if (!lastName.value) {
    lastNameError.value = t('identityCreation.validation.lastNameRequired')
    isValid = false
  } else if (lastName.value.length < 3) {
    lastNameError.value = t('identityCreation.validation.lastNameMinLength')
    isValid = false
  } else if (lastName.value[0] !== lastName.value[0].toUpperCase()) {
    lastNameError.value = t('identityCreation.validation.lastNameCapitalized')
    isValid = false
  }

  if (!firstName.value) {
    firstNameError.value = t('identityCreation.validation.firstNameRequired')
    isValid = false
  } else if (firstName.value.length < 3) {
    firstNameError.value = t('identityCreation.validation.firstNameMinLength')
    isValid = false
  } else if (firstName.value[0] !== firstName.value[0].toUpperCase()) {
    firstNameError.value = t('identityCreation.validation.firstNameCapitalized')
    isValid = false
  }

  if (!dateOfBirth.value) {
    dateOfBirthError.value = t('identityCreation.validation.dateOfBirthRequired')
    isValid = false
  }

  if (!gender.value) {
    genderError.value = t('identityCreation.validation.genderRequired')
    isValid = false
  }

  if (!nationality.value) {
    nationalityError.value = t('identityCreation.validation.nationalityRequired')
    isValid = false
  }

  return isValid
}

const validateLastName = () => {
  lastNameError.value = ''
  if (!lastName.value) {
    lastNameError.value = t('identityCreation.validation.lastNameRequired')
  } else if (lastName.value.length < 3) {
    lastNameError.value = t('identityCreation.validation.lastNameMinLength')
  } else if (lastName.value[0] !== lastName.value[0].toUpperCase()) {
    lastNameError.value = t('identityCreation.validation.lastNameCapitalized')
  }
}

const validateFirstName = () => {
  firstNameError.value = ''
  if (!firstName.value) {
    firstNameError.value = t('identityCreation.validation.firstNameRequired')
  } else if (firstName.value.length < 3) {
    firstNameError.value = t('identityCreation.validation.firstNameMinLength')
  } else if (firstName.value[0] !== firstName.value[0].toUpperCase()) {
    firstNameError.value = t('identityCreation.validation.firstNameCapitalized')
  }
}

const validateDateOfBirth = () => {
  dateOfBirthError.value = ''
  if (!dateOfBirth.value) {
    dateOfBirthError.value = t('identityCreation.validation.dateOfBirthRequired')
  }
}

const debouncedValidateLastName = () => {
  if (lastNameTimer) clearTimeout(lastNameTimer)
  lastNameTimer = setTimeout(validateLastName, 500)
}

const debouncedValidateFirstName = () => {
  if (firstNameTimer) clearTimeout(firstNameTimer)
  firstNameTimer = setTimeout(validateFirstName, 500)
}

const debouncedValidateDateOfBirth = () => {
  if (dateOfBirthTimer) clearTimeout(dateOfBirthTimer)
  dateOfBirthTimer = setTimeout(validateDateOfBirth, 500)
}

const submitForm = () => {
  if (!validateForm()) {
    return
  }

  const identityData = {
    firstName: firstName.value,
    lastName: lastName.value,
    dateOfBirth: dateOfBirth.value,
    gender: gender.value,
    nationality: nationality.value,
    height: height.value
  }

  console.log('=== ' + t('identityCreation.debug.identityDataCreated') + ' ===')
  console.log(`${t('identityCreation.debug.lastName')}: ${identityData.lastName}`)
  console.log(`${t('identityCreation.debug.firstName')}: ${identityData.firstName}`)
  console.log(`${t('identityCreation.debug.dateOfBirth')}: ${identityData.dateOfBirth}`)
  console.log(`${t('identityCreation.debug.gender')}: ${identityData.gender === 'M' ? t('identityCreation.debug.genderMale') : t('identityCreation.debug.genderFemale')}`)
  console.log(`${t('identityCreation.debug.nationality')}: ${identityData.nationality}`)
  console.log(`${t('identityCreation.debug.height')}: ${identityData.height} cm`)
  console.log('===================================')
  console.log(t('identityCreation.debug.completeObject') + ':', identityData)

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
  <div v-if="isVisible || props.forceVisible" class="fixed inset-0 w-full h-full z-10" style="background: linear-gradient(to right, rgba(15, 23, 42, 1) 0%, rgba(15, 23, 42, 0.7) 15%, rgba(15, 23, 42, 0.4) 33%, transparent 100%)">

    <Transition
      name="fade-in"
      appear
    >
      <div class="absolute left-16 top-[45%] transform -translate-y-1/2 w-[32rem] fhd:w-[28rem] 2k:w-[40rem] max-h-[85vh] overflow-hidden">

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

        <h1 class="text-4xl fhd:text-3xl 2k:text-6xl font-black text-white leading-tight tracking-wide">
          {{ t('identityCreation.title') }} <span class="text-3xl fhd:text-2xl 2k:text-5xl font-light text-blue-200/80">{{ t('identityCreation.subtitle') }}</span>
        </h1>
      </div>

      <div class="space-y-8 fhd:space-y-6 2k:space-y-12 overflow-y-auto max-h-[calc(85vh-180px)] pr-3 scrollbar-thin scrollbar-track-slate-800/50 scrollbar-thumb-blue-600/40 hover:scrollbar-thumb-blue-500/60">

        <div class="space-y-4 fhd:space-y-3 2k:space-y-6">
          <div class="flex items-center space-x-3 mb-6 fhd:mb-4">
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center">
              <span class="text-blue-300 text-sm font-bold">01</span>
            </div>
            <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{ t('identityCreation.sections.identity') }}</span>
          </div>

          <div class="grid grid-cols-2 gap-4 fhd:gap-3 2k:gap-6">
            <div class="space-y-2">
              <VTextField
                v-model="lastName"
                :label="t('identityCreation.fields.lastName')"
                variant="outlined"
                :density="$vuetify.display.fhd ? 'compact' : 'comfortable'"
                class="text-white 2k:text-xl"
                color="blue"
                base-color="blue-300"
                bg-color="rgba(30, 41, 59, 0.4)"
                required
                @input="debouncedValidateLastName"
              />
              <p v-if="lastNameError" class="text-xs text-red-400 ml-2">{{ lastNameError }}</p>
            </div>
            <div class="space-y-2">
              <VTextField
                v-model="firstName"
                :label="t('identityCreation.fields.firstName')"
                variant="outlined"
                :density="$vuetify.display.fhd ? 'compact' : 'comfortable'"
                class="text-white 2k:text-xl"
                color="blue"
                base-color="blue-300"
                bg-color="rgba(30, 41, 59, 0.4)"
                required
                @input="debouncedValidateFirstName"
              />
              <p v-if="firstNameError" class="text-xs text-red-400 ml-2">{{ firstNameError }}</p>
            </div>
          </div>
        </div>

        <div class="space-y-4 fhd:space-y-3 2k:space-y-6">
          <div class="flex items-center space-x-3 mb-6 fhd:mb-4">
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-cyan-500/40 flex items-center justify-center">
              <span class="text-cyan-300 text-sm font-bold">02</span>
            </div>
            <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{ t('identityCreation.sections.birth') }}</span>
          </div>

          <div class="space-y-2">
            <VTextField
              v-model="dateOfBirth"
              :label="t('identityCreation.fields.dateOfBirth')"
              variant="outlined"
              density="comfortable"
              type="date"
              class="text-white"
              color="cyan"
              base-color="cyan-300"
              bg-color="rgba(30, 41, 59, 0.4)"
              required
              @input="debouncedValidateDateOfBirth"
            />
            <p v-if="dateOfBirthError" class="text-xs text-red-400 ml-2">{{ dateOfBirthError }}</p>
          </div>
        </div>

        <div class="space-y-4 fhd:space-y-3 2k:space-y-6">
          <div class="flex items-center space-x-3 mb-6 fhd:mb-4">
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-400/40 flex items-center justify-center">
              <span class="text-blue-400 text-sm font-bold">03</span>
            </div>
            <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{ t('identityCreation.sections.profile') }}</span>
          </div>

          <div class="grid grid-cols-2 gap-4 fhd:gap-3 2k:gap-6">
            <div class="space-y-2">
              <VSelect
                v-model="gender"
                :label="t('identityCreation.fields.gender')"
                :items="[
                  { title: t('identityCreation.genderOptions.male'), value: 'M' },
                  { title: t('identityCreation.genderOptions.female'), value: 'F' }
                ]"
                variant="outlined"
                :density="$vuetify.display.fhd ? 'compact' : 'comfortable'"
                class="text-white 2k:text-xl"
                color="blue"
                base-color="blue-300"
                bg-color="rgba(30, 41, 59, 0.4)"
                required
                @update:modelValue="() => { genderError = '' }"
              />
              <p v-if="genderError" class="text-xs text-red-400 ml-2">{{ genderError }}</p>
            </div>
            <div class="space-y-2">
              <VSelect
                v-model="nationality"
                :label="t('identityCreation.fields.nationality')"
                :items="countries.map(country => ({ title: country.name, value: country.name }))"
                variant="outlined"
                :density="$vuetify.display.fhd ? 'compact' : 'comfortable'"
                class="text-white 2k:text-xl"
                color="blue"
                base-color="blue-300"
                bg-color="rgba(30, 41, 59, 0.4)"
                required
                @update:modelValue="() => { nationalityError = '' }"
              />
              <p v-if="nationalityError" class="text-xs text-red-400 ml-2">{{ nationalityError }}</p>
            </div>
          </div>
        </div>

        <div class="space-y-4 fhd:space-y-3 2k:space-y-6">
          <div class="flex items-center space-x-3 mb-6 fhd:mb-4">
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-slate-500/40 flex items-center justify-center">
              <span class="text-slate-300 text-sm font-bold">04</span>
            </div>
            <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{ t('identityCreation.sections.physical') }}</span>
          </div>

          <div class="space-y-4 fhd:space-y-3 2k:space-y-6">
            <div class="flex items-center justify-between px-2">
              <span class="text-slate-200 text-sm font-medium">{{ t('identityCreation.fields.height') }}</span>
              <span class="text-blue-300 text-lg font-bold">{{ height }} cm</span>
            </div>
            <VSlider
              v-model="height"
              :min="120"
              :max="220"
              :step="1"
              thumb-label="always"
              track-color="rgba(71, 85, 105, 0.6)"
              color="blue"
              class="w-full"
            />
          </div>
        </div>

        <div class="pt-6 pb-4 flex justify-center">
          <VBtn
            variant="outlined"
            size="x-large"
            class="w-5/6 bg-charcoal-elegant text-white font-bold border-2 border-blue-500 hover:border-blue-400 rounded-2xl hover:scale-[1.01] hover:shadow-2xl hover:shadow-blue-500/30 transition-all duration-300 !flex !items-center !justify-center fhd:!h-14 2k:!h-20"
            elevation="0"
            height="64"
            @click="submitForm"
          >
            <span class="text-lg fhd:text-base 2k:text-2xl tracking-wider uppercase">{{ t('identityCreation.actions.createIdentity') }}</span>
          </VBtn>
        </div>
      </div>
      </div>
    </Transition>

    <div class="absolute right-0 top-0 w-3/5 h-full pointer-events-none">
    </div>
  </div>
</template>

<style scoped>
:deep(input[type="date"]::-webkit-calendar-picker-indicator) {
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