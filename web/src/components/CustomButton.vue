<script setup lang="ts">
import { computed } from 'vue'

export type ButtonVariant =
  | 'primary'
  | 'success'
  | 'danger'
  | 'warning'
  | 'info'
  | 'outlined-primary'
export type ButtonSize = 'small' | 'medium' | 'large' | 'xl'

const props = withDefaults(
  defineProps<{
    variant?: ButtonVariant
    size?: ButtonSize
    icon?: string
    iconPosition?: 'left' | 'right'
    disabled?: boolean
    width?: string
    height?: string
    borderWidth?: string
    borderColor?: string
    borderHoverColor?: string
    rounded?: string
    scaleHover?: string
    outline?: boolean
    outlineColor?: string
  }>(),
  {
    variant: 'primary',
    size: 'medium',
    iconPosition: 'left',
    disabled: false,
    width: 'auto',
    height: 'auto',
    borderWidth: '',
    borderColor: '',
    borderHoverColor: '',
    rounded: '',
    scaleHover: '1.05',
    outline: false,
    outlineColor: 'rgba(255, 255, 255, 0.3)',
  },
)

const emit = defineEmits<{
  click: []
}>()

const variantClasses = computed(() => {
  const variants: Record<ButtonVariant, string> = {
    primary: 'bg-charcoal-elegant hover:bg-blue-600/95 hover:shadow-blue-500/30',
    success: 'bg-charcoal-elegant-forest hover:bg-green-600/95 hover:shadow-green-500/30',
    danger: 'bg-charcoal-elegant-blood hover:bg-red-600/95 hover:shadow-red-500/30',
    warning: 'bg-charcoal-elegant-gold hover:bg-yellow-600/95 hover:shadow-yellow-500/30',
    info: 'bg-charcoal-elegant-sky hover:bg-cyan-600/95 hover:shadow-cyan-500/30',
    'outlined-primary':
      'bg-charcoal-elegant border-2 border-blue-500 hover:border-blue-400 hover:shadow-2xl hover:shadow-blue-500/30',
  }
  return variants[props.variant]
})

const customBorderClasses = computed(() => {
  if (!props.borderWidth && !props.borderColor) return ''
  return `${props.borderWidth} ${props.borderColor} ${props.borderHoverColor ? `hover:${props.borderHoverColor}` : ''}`
})

const roundedClass = computed(() => {
  return props.rounded || ''
})

const scaleHoverClass = computed(() => {
  const scaleMap: Record<string, string> = {
    '1.01': 'hover:scale-[1.01]',
    '1.02': 'hover:scale-[1.02]',
    '1.05': 'hover:scale-105',
  }
  return scaleMap[props.scaleHover] || 'hover:scale-105'
})

const sizeClasses = computed(() => {
  const sizes: Record<ButtonSize, { padding: string; text: string; height: string }> = {
    small: {
      padding: '!px-4 !py-4',
      text: '!text-sm',
      height: 'h-16',
    },
    medium: {
      padding: '!px-5 !py-6',
      text: '!text-base',
      height: 'h-20',
    },
    large: {
      padding: '!px-6 !py-8',
      text: '!text-xl',
      height: 'h-24',
    },
    xl: {
      padding: '!px-8 !py-10',
      text: '!text-2xl',
      height: 'h-28',
    },
  }
  return sizes[props.size]
})

const widthClass = computed(() => {
  if (props.width === 'auto') return ''
  return props.width
})

const heightClass = computed(() => {
  if (props.height === 'auto') return sizeClasses.value.height
  return props.height
})

const outlineStyle = computed(() => {
  if (!props.outline) return {}
  return {
    border: `1px solid ${props.outlineColor}`,
  }
})

const handleClick = () => {
  if (!props.disabled) {
    emit('click')
  }
}
</script>

<template>
  <VBtn
    :size="'large'"
    color="transparent"
    :class="[
      variantClasses,
      customBorderClasses,
      roundedClass,
      scaleHoverClass,
      sizeClasses.padding,
      sizeClasses.text,
      widthClass,
      heightClass,
      'transition-all duration-300 ease-out hover:shadow-xl font-semibold !flex !items-center !justify-center text-white',
      disabled ? 'opacity-50 cursor-not-allowed' : '',
    ]"
    :style="outlineStyle"
    elevation="0"
    :disabled="disabled"
    @click="handleClick"
  >
    <VIcon v-if="icon && iconPosition === 'left'" start :icon="icon" class="text-lg" />
    <slot />
    <VIcon v-if="icon && iconPosition === 'right'" end :icon="icon" class="text-lg" />
  </VBtn>
</template>
