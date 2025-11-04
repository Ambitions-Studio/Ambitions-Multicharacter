<script setup lang="ts">
import { watch } from 'vue'
import { useFieldValidation, type ValidationRule } from '@/composables/useFieldValidation'

const props = defineProps<{
  modelValue: string
  label: string
  type?: string
  density?: 'compact' | 'comfortable' | 'default'
  required?: boolean
  minLength?: number
  capitalized?: boolean
  minAge?: number
  maxAge?: number
  validationRules?: ValidationRule[]
  debounceMs?: number
  errorMessages?: {
    required?: string
    minLength?: string
    capitalized?: string
    minAge?: string
    maxAge?: string
    invalidAge?: string
  }
}>()

const emit = defineEmits<{
  'update:modelValue': [value: string]
}>()

const { error, validateField, clearError } = useFieldValidation(props.label)

let validationTimer: ReturnType<typeof setTimeout> | null = null

const validate = () => {
  return validateField(props.modelValue, {
    required: props.required,
    minLength: props.minLength,
    capitalized: props.capitalized,
    minAge: props.minAge,
    maxAge: props.maxAge,
    customRules: props.validationRules,
    errorMessages: props.errorMessages,
  })
}

const debouncedValidate = () => {
  if (validationTimer) clearTimeout(validationTimer)
  validationTimer = setTimeout(validate, props.debounceMs || 500)
}

const handleInput = (event: Event) => {
  const target = event.target as HTMLInputElement
  emit('update:modelValue', target.value)
  debouncedValidate()
}

watch(
  () => props.modelValue,
  () => {
    if (error.value) {
      debouncedValidate()
    }
  },
)

defineExpose({
  validate,
  clearError,
})
</script>

<template>
  <div class="space-y-2">
    <VTextField
      :model-value="modelValue"
      :label="label"
      :type="type || 'text'"
      variant="outlined"
      :density="density || 'compact'"
      class="text-white 2k:text-xl"
      color="blue"
      base-color="blue-300"
      bg-color="rgba(30, 41, 59, 0.4)"
      :required="required"
      @input="handleInput"
    />
    <p v-if="error" class="text-xs text-red-400 ml-2">{{ error }}</p>
  </div>
</template>
