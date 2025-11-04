import { defineStore } from 'pinia'
import { ref } from 'vue'

export type IdentityData = {
  firstName: string
  lastName: string
  dateOfBirth: string
  gender: string
  nationality: string
  height: number
}

export const useIdentityCreationStore = defineStore('identityCreation', () => {
  const firstName = ref('')
  const lastName = ref('')
  const dateOfBirth = ref('')
  const gender = ref('')
  const nationality = ref('')
  const height = ref(170)

  const isIdentityComplete = ref(false)

  const setFirstName = (value: string) => {
    firstName.value = value
  }

  const setLastName = (value: string) => {
    lastName.value = value
  }

  const setDateOfBirth = (value: string) => {
    dateOfBirth.value = value
  }

  const setGender = (value: string) => {
    gender.value = value
  }

  const setNationality = (value: string) => {
    nationality.value = value
  }

  const setHeight = (value: number) => {
    height.value = value
  }

  const getIdentityData = (): IdentityData => {
    return {
      firstName: firstName.value,
      lastName: lastName.value,
      dateOfBirth: dateOfBirth.value,
      gender: gender.value,
      nationality: nationality.value,
      height: height.value,
    }
  }

  const setIdentityData = (data: IdentityData) => {
    firstName.value = data.firstName
    lastName.value = data.lastName
    dateOfBirth.value = data.dateOfBirth
    gender.value = data.gender
    nationality.value = data.nationality
    height.value = data.height
  }

  const submitIdentity = () => {
    isIdentityComplete.value = true
    return getIdentityData()
  }

  const resetIdentity = () => {
    firstName.value = ''
    lastName.value = ''
    dateOfBirth.value = ''
    gender.value = ''
    nationality.value = ''
    height.value = 170
    isIdentityComplete.value = false
  }

  return {
    firstName,
    lastName,
    dateOfBirth,
    gender,
    nationality,
    height,
    isIdentityComplete,
    setFirstName,
    setLastName,
    setDateOfBirth,
    setGender,
    setNationality,
    setHeight,
    getIdentityData,
    setIdentityData,
    submitIdentity,
    resetIdentity,
  }
})
