<script setup lang="ts">
import { ref } from 'vue'
import { useI18n } from 'vue-i18n'
import ValidatedTextField from '@/components/identityCreation/ValidatedTextField.vue'

const { t } = useI18n()

const props = defineProps<{
  lastName: string
  firstName: string
}>()

const emit = defineEmits<{
  'update:lastName': [value: string]
  'update:firstName': [value: string]
}>()

const lastNameField = ref<InstanceType<typeof ValidatedTextField> | null>(null)
const firstNameField = ref<InstanceType<typeof ValidatedTextField> | null>(null)

const validate = () => {
  let isValid = true

  if (lastNameField.value && !lastNameField.value.validate()) {
    isValid = false
  }

  if (firstNameField.value && !firstNameField.value.validate()) {
    isValid = false
  }

  return isValid
}

defineExpose({
  validate,
})
</script>

<template>
  <div class="space-y-4 fhd:space-y-3 2k:space-y-6">
    <div class="flex items-center space-x-3 mb-6 fhd:mb-4">
      <div
        class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-500/40 flex items-center justify-center"
      >
        <span class="text-blue-300 text-sm font-bold">01</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{
        t('identityCreation.sections.identity')
      }}</span>
    </div>

    <div class="grid grid-cols-2 gap-4 fhd:gap-3 2k:gap-6">
      <ValidatedTextField
        ref="lastNameField"
        :model-value="props.lastName"
        :label="t('identityCreation.fields.lastName')"
        :required="true"
        :min-length="3"
        :capitalized="true"
        :error-messages="{
          required: t('identityCreation.validation.lastNameRequired'),
          minLength: t('identityCreation.validation.lastNameMinLength'),
          capitalized: t('identityCreation.validation.lastNameCapitalized'),
        }"
        @update:model-value="emit('update:lastName', $event)"
      />
      <ValidatedTextField
        ref="firstNameField"
        :model-value="props.firstName"
        :label="t('identityCreation.fields.firstName')"
        :required="true"
        :min-length="3"
        :capitalized="true"
        :error-messages="{
          required: t('identityCreation.validation.firstNameRequired'),
          minLength: t('identityCreation.validation.firstNameMinLength'),
          capitalized: t('identityCreation.validation.firstNameCapitalized'),
        }"
        @update:model-value="emit('update:firstName', $event)"
      />
    </div>
  </div>
</template>
