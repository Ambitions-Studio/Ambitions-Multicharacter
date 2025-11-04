<script setup lang="ts">
import { ref } from 'vue'
import { useI18n } from 'vue-i18n'
import ValidatedTextField from '@/components/identityCreation/ValidatedTextField.vue'

const { t } = useI18n()

const MIN_AGE = 18
const MAX_AGE = 110

const props = defineProps<{
  dateOfBirth: string
}>()

const emit = defineEmits<{
  'update:dateOfBirth': [value: string]
}>()

const dateOfBirthField = ref<InstanceType<typeof ValidatedTextField> | null>(null)

const validate = () => {
  if (dateOfBirthField.value && !dateOfBirthField.value.validate()) {
    return false
  }
  return true
}

defineExpose({
  validate,
})
</script>

<template>
  <div class="space-y-4 fhd:space-y-3 2k:space-y-6">
    <div class="flex items-center space-x-3 mb-6 fhd:mb-4">
      <div
        class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-cyan-500/40 flex items-center justify-center"
      >
        <span class="text-cyan-300 text-sm font-bold">02</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{
        t('identityCreation.sections.birth')
      }}</span>
    </div>

    <ValidatedTextField
      ref="dateOfBirthField"
      :model-value="props.dateOfBirth"
      :label="t('identityCreation.fields.dateOfBirth')"
      type="date"
      density="comfortable"
      :required="true"
      :min-age="MIN_AGE"
      :max-age="MAX_AGE"
      :error-messages="{
        required: t('identityCreation.validation.dateOfBirthRequired'),
        minAge: t('identityCreation.validation.dateOfBirthMinAge', { age: MIN_AGE }),
        maxAge: t('identityCreation.validation.dateOfBirthMaxAge', { age: MAX_AGE }),
        invalidAge: t('identityCreation.validation.dateOfBirthInvalid'),
      }"
      @update:model-value="emit('update:dateOfBirth', $event)"
    />
  </div>
</template>
