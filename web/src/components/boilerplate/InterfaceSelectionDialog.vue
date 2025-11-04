<script setup lang="ts">
import {
  mdiClose,
  mdiAccountMultiple,
  mdiCardAccountDetails,
  mdiAccountPlus,
} from '../../icons'

const modelValue = defineModel<boolean>({ required: true })

const emit = defineEmits<{
  selectCharacterSelection: []
  selectIdentityCreator: []
  selectCharacterCreator: []
}>()

const handleCharacterSelection = () => {
  modelValue.value = false
  emit('selectCharacterSelection')
}

const handleIdentityCreator = () => {
  modelValue.value = false
  emit('selectIdentityCreator')
}

const handleCharacterCreator = () => {
  modelValue.value = false
  emit('selectCharacterCreator')
}

const closeDialog = () => {
  modelValue.value = false
}
</script>

<template>
  <VDialog v-model="modelValue" persistent>
    <div class="flex justify-center">
      <VCard
        elevation="0"
        color="transparent"
        class="bg-charcoal-elegant !border border-slate-400/30 !rounded-xl !p-4 lg:!p-5 xl:!p-6 fhd:!p-10 2k:!p-12 w-80 xl:w-80 2xl:w-80 fhd:w-[32rem] 2k:w-[45rem] !shadow-2xl"
      >
        <VCardTitle
          class="!text-white !text-lg lg:!text-xl xl:!text-2xl fhd:!text-3xl 2k:!text-4xl !font-semibold !py-3 lg:!py-4 fhd:!py-6 2k:!py-6 !px-4 lg:!px-5 xl:!px-6 fhd:!px-10 2k:!px-12 text-center !border-b border-slate-600/30"
        >
          <div class="flex items-center justify-between w-full">
            <div></div>
            <span>Interface Selection</span>
            <VBtn
              icon
              size="x-small"
              color="transparent"
              class="bg-charcoal-elegant-gray xl:ml-4 fhd:!w-10 fhd:!h-10 2k:!w-14 2k:!h-14"
              @click="closeDialog"
            >
              <VIcon :icon="mdiClose" color="white" size="small" class="fhd:!text-lg 2k:!text-xl" />
            </VBtn>
          </div>
        </VCardTitle>

        <VCardText class="!p-4 lg:!p-5 xl:!p-6 fhd:!p-10 2k:!p-12">
          <div class="space-y-3 lg:space-y-4 fhd:space-y-6 2k:space-y-8">
            <VBtn
              block
              :size="'default'"
              variant="outlined"
              class="bg-charcoal-elegant-gray !text-gray-200 hover:!bg-gray-500/50 !text-xs lg:!text-sm xl:!text-sm fhd:!text-xl 2k:!text-2xl !py-2 lg:!py-3 xl:!py-4 fhd:!py-8 2k:!py-10"
              @click="handleCharacterSelection"
            >
              <VIcon
                :icon="mdiAccountMultiple"
                class="mr-2 !text-gray-200 !text-base lg:!text-lg xl:!text-xl 2k:!text-3xl"
              />
              Character Selection
            </VBtn>

            <VBtn
              block
              :size="'default'"
              variant="outlined"
              class="bg-charcoal-elegant-gray !text-gray-200 hover:!bg-gray-500/50 !text-xs lg:!text-sm xl:!text-sm fhd:!text-xl 2k:!text-2xl !py-2 lg:!py-3 xl:!py-4 fhd:!py-8 2k:!py-10"
              @click="handleIdentityCreator"
            >
              <VIcon
                :icon="mdiCardAccountDetails"
                class="mr-2 !text-gray-200 !text-base lg:!text-lg xl:!text-xl 2k:!text-3xl"
              />
              Identity Creator
            </VBtn>

            <VBtn
              block
              :size="'default'"
              variant="outlined"
              class="bg-charcoal-elegant-gray !text-gray-200 hover:!bg-gray-500/50 !text-xs lg:!text-sm xl:!text-sm fhd:!text-xl 2k:!text-2xl !py-2 lg:!py-3 xl:!py-4 fhd:!py-8 2k:!py-10"
              @click="handleCharacterCreator"
            >
              <VIcon
                :icon="mdiAccountPlus"
                class="mr-2 !text-gray-200 !text-base lg:!text-lg xl:!text-xl 2k:!text-3xl"
              />
              Character Creator
            </VBtn>
          </div>
        </VCardText>
      </VCard>
    </div>
  </VDialog>
</template>
