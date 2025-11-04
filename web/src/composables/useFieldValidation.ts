import { ref } from 'vue'
import { useI18n } from 'vue-i18n'

export type ValidationRule = {
  validate: (value: string | number) => boolean
  message: string
}

export type ValidationOptions = {
  required?: boolean
  minLength?: number
  capitalized?: boolean
  minAge?: number
  maxAge?: number
  customRules?: ValidationRule[]
  errorMessages?: {
    required?: string
    minLength?: string
    capitalized?: string
    minAge?: string
    maxAge?: string
    invalidAge?: string
  }
}

export function useFieldValidation(fieldLabel: string) {
  const { t } = useI18n()
  const error = ref('')

  const calculateAge = (birthDate: string): number => {
    const today = new Date()
    const birth = new Date(birthDate)
    let age = today.getFullYear() - birth.getFullYear()
    const monthDiff = today.getMonth() - birth.getMonth()

    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birth.getDate())) {
      age--
    }

    return age
  }

  const validateField = (
    value: string | number,
    options: ValidationOptions = {},
  ): boolean => {
    error.value = ''

    const stringValue = String(value)

    if (options.required && !value) {
      error.value = options.errorMessages?.required || t('validation.required', { field: fieldLabel })
      return false
    }

    if (options.minLength && stringValue && stringValue.length < options.minLength) {
      error.value =
        options.errorMessages?.minLength ||
        t('validation.minLength', { field: fieldLabel, length: options.minLength })
      return false
    }

    if (
      options.capitalized &&
      stringValue &&
      stringValue[0] !== stringValue[0].toUpperCase()
    ) {
      error.value =
        options.errorMessages?.capitalized || t('validation.capitalized', { field: fieldLabel })
      return false
    }

    if ((options.minAge !== undefined || options.maxAge !== undefined) && stringValue) {
      const age = calculateAge(stringValue)

      if (isNaN(age)) {
        error.value = options.errorMessages?.invalidAge || t('validation.invalidAge', { field: fieldLabel })
        return false
      }

      if (options.minAge !== undefined && age < options.minAge) {
        error.value =
          options.errorMessages?.minAge ||
          t('validation.minAge', { field: fieldLabel, age: options.minAge })
        return false
      }

      if (options.maxAge !== undefined && age > options.maxAge) {
        error.value =
          options.errorMessages?.maxAge ||
          t('validation.maxAge', { field: fieldLabel, age: options.maxAge })
        return false
      }
    }

    if (options.customRules) {
      for (const rule of options.customRules) {
        if (!rule.validate(value)) {
          error.value = rule.message
          return false
        }
      }
    }

    return true
  }

  const clearError = () => {
    error.value = ''
  }

  return {
    error,
    validateField,
    clearError,
  }
}
