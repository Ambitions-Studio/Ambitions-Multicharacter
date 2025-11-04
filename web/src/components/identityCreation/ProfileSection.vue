<script setup lang="ts">
import { ref } from 'vue'
import { useI18n } from 'vue-i18n'
import { countries } from '@/utils/countries'
import ValidatedSelect from '@/components/identityCreation/ValidatedSelect.vue'

const { t } = useI18n()

const props = defineProps<{
  gender: string
  nationality: string
}>()

const emit = defineEmits<{
  'update:gender': [value: string]
  'update:nationality': [value: string]
}>()

const genderField = ref<InstanceType<typeof ValidatedSelect> | null>(null)
const nationalityField = ref<InstanceType<typeof ValidatedSelect> | null>(null)

const validate = () => {
  let isValid = true

  if (genderField.value && !genderField.value.validate()) {
    isValid = false
  }

  if (nationalityField.value && !nationalityField.value.validate()) {
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
        class="w-8 h-8 rounded-lg bg-gradient-to-br from-slate-700 to-slate-800 border border-blue-400/40 flex items-center justify-center"
      >
        <span class="text-blue-400 text-sm font-bold">03</span>
      </div>
      <span class="text-slate-300 text-sm font-medium uppercase tracking-widest">{{
        t('identityCreation.sections.profile')
      }}</span>
    </div>

    <div class="grid grid-cols-2 gap-4 fhd:gap-3 2k:gap-6">
      <ValidatedSelect
        ref="genderField"
        :model-value="props.gender"
        :label="t('identityCreation.fields.gender')"
        :items="[
          { title: t('identityCreation.genderOptions.male'), value: 'M' },
          { title: t('identityCreation.genderOptions.female'), value: 'F' },
        ]"
        :required="true"
        :error-messages="{
          required: t('identityCreation.validation.genderRequired'),
        }"
        @update:model-value="emit('update:gender', $event as string)"
      />
      <ValidatedSelect
        ref="nationalityField"
        :model-value="props.nationality"
        :label="t('identityCreation.fields.nationality')"
        :items="countries.map((country) => ({ title: country.name, value: country.name }))"
        :required="true"
        :error-messages="{
          required: t('identityCreation.validation.nationalityRequired'),
        }"
        @update:model-value="emit('update:nationality', $event as string)"
      />
    </div>
  </div>
</template>
