<script setup lang="ts">
import { useFieldValidation } from '@/composables/useFieldValidation'

export type SelectItem = {
  title: string
  value: string | number
}

const props = defineProps<{
  modelValue: string | number
  label: string
  items: SelectItem[]
  density?: 'compact' | 'comfortable' | 'default'
  required?: boolean
  errorMessages?: {
    required?: string
  }
}>()

const emit = defineEmits<{
  'update:modelValue': [value: string | number]
}>()

const { error, validateField, clearError } = useFieldValidation(props.label)

const validate = () => {
  return validateField(props.modelValue, {
    required: props.required,
    errorMessages: props.errorMessages,
  })
}

const handleUpdate = (value: string | number) => {
  emit('update:modelValue', value)
  clearError()
}

defineExpose({
  validate,
  clearError,
})
</script>

<template>
  <div class="space-y-2">
    <VSelect
      :model-value="modelValue"
      :label="label"
      :items="items"
      variant="outlined"
      :density="density || 'compact'"
      class="text-white 2k:text-xl"
      color="blue"
      base-color="blue-300"
      bg-color="rgba(30, 41, 59, 0.4)"
      :required="required"
      @update:model-value="handleUpdate"
    />
    <p v-if="error" class="text-xs text-red-400 ml-2">{{ error }}</p>
  </div>
</template>
