<script setup lang="ts">
import { computed } from 'vue'
import { useI18n } from 'vue-i18n'
import { useIdentityCreationStore } from '@/stores/useIdentityCreationStore'
import { useAppearanceStore } from '@/stores/useAppearanceStore'

const { t } = useI18n()
const identityStore = useIdentityCreationStore()
const appearanceStore = useAppearanceStore()

const identity = computed(() => identityStore.getIdentityData())
const appearance = computed(() => appearanceStore.getAppearanceData())
</script>

<template>
  <div class="space-y-6 max-h-[82vh] overflow-y-auto pr-2 pb-48">
    <div class="text-center mb-8">
      <h2 class="text-white text-3xl font-bold mb-2">
        {{ t('characterCreation.recap.title') }}
      </h2>
      <p class="text-slate-400 text-sm">
        {{ t('characterCreation.recap.subtitle') }}
      </p>
    </div>

    <!-- Identity Section -->
    <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
      <h3 class="text-white text-xl font-bold mb-4 pb-2 border-b border-slate-700">
        {{ t('characterCreation.recap.sections.identity') }}
      </h3>
      <div class="grid grid-cols-2 gap-4">
        <div>
          <p class="text-slate-400 text-xs mb-1">{{ t('characterCreation.recap.fields.firstName') }}</p>
          <p class="text-white font-semibold">{{ identity.firstName }}</p>
        </div>
        <div>
          <p class="text-slate-400 text-xs mb-1">{{ t('characterCreation.recap.fields.lastName') }}</p>
          <p class="text-white font-semibold">{{ identity.lastName }}</p>
        </div>
        <div>
          <p class="text-slate-400 text-xs mb-1">{{ t('characterCreation.recap.fields.dateOfBirth') }}</p>
          <p class="text-white font-semibold">{{ identity.dateOfBirth }}</p>
        </div>
        <div>
          <p class="text-slate-400 text-xs mb-1">{{ t('characterCreation.recap.fields.gender') }}</p>
          <p class="text-white font-semibold">{{ identity.gender === 'male' ? t('characterCreation.recap.fields.male') : t('characterCreation.recap.fields.female') }}</p>
        </div>
      </div>
    </div>

    <!-- Ped Section -->
    <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
      <h3 class="text-white text-xl font-bold mb-4 pb-2 border-b border-slate-700">
        {{ t('characterCreation.recap.sections.ped') }}
      </h3>
      <div>
        <p class="text-slate-400 text-xs mb-1">{{ t('characterCreation.recap.fields.selectedPed') }}</p>
        <p class="text-white font-semibold">{{ appearance.ped.selectedPed }}</p>
      </div>
    </div>

    <!-- Heritage Section -->
    <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
      <h3 class="text-white text-xl font-bold mb-4 pb-2 border-b border-slate-700">
        {{ t('characterCreation.recap.sections.heritage') }}
      </h3>
      <div class="grid grid-cols-2 gap-4">
        <div>
          <p class="text-slate-400 text-xs mb-1">{{ t('characterCreation.recap.fields.father') }}</p>
          <p class="text-white font-semibold">{{ appearance.heritage.father }}</p>
        </div>
        <div>
          <p class="text-slate-400 text-xs mb-1">{{ t('characterCreation.recap.fields.mother') }}</p>
          <p class="text-white font-semibold">{{ appearance.heritage.mother }}</p>
        </div>
        <div>
          <p class="text-slate-400 text-xs mb-1">{{ t('characterCreation.recap.fields.resemblance') }}</p>
          <p class="text-white font-semibold">{{ appearance.heritage.faceResemblance.toFixed(2) }}</p>
        </div>
        <div>
          <p class="text-slate-400 text-xs mb-1">{{ t('characterCreation.recap.fields.skinTone') }}</p>
          <p class="text-white font-semibold">{{ appearance.heritage.skinResemblance.toFixed(2) }}</p>
        </div>
      </div>
    </div>

    <!-- Physical Customization Section -->
    <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
      <h3 class="text-white text-xl font-bold mb-4 pb-2 border-b border-slate-700">
        {{ t('characterCreation.recap.sections.physical') }}
      </h3>
      <div class="grid grid-cols-3 gap-3 text-xs">
        <!-- Hair -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.hair.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.hairStyle }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.hair.color.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.hairColor }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.hair.highlight.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.hairHighlight }}</p>
        </div>

        <!-- Eyes -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.eyes.opening.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.eyeOpening.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.eyes.color.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.eyeColor }}</p>
        </div>

        <!-- Eyebrows -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.eyebrows.height.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.eyebrowHeight.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.eyebrows.depth.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.eyebrowDepth.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.eyebrows.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.eyebrowsStyle }} ({{ appearance.physical.eyebrowsOpacity.toFixed(2) }})</p>
        </div>

        <!-- Nose -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.nose.width.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.noseWidth.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.nose.height.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.noseHeight.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.nose.length.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.noseLength.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.nose.bridge.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.noseBridge.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.nose.tip.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.noseTipHeight.toFixed(2) }}</p>
        </div>

        <!-- Cheeks -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.cheeks.boneHeight.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.cheekBoneHeight.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.cheeks.boneWidth.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.cheekBoneWidth.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.cheeks.width.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.cheekWidth.toFixed(2) }}</p>
        </div>

        <!-- Jaw -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.jaw.width.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.jawWidth.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.jaw.height.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.jawHeight.toFixed(2) }}</p>
        </div>

        <!-- Lips -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.lips.thickness.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.lipThickness.toFixed(2) }}</p>
        </div>

        <!-- Chin -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.chin.lowering.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.chinLowering.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.chin.length.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.chinLength.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.chin.width.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.chinWidth.toFixed(2) }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.chin.cleft.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.chinCleft.toFixed(2) }}</p>
        </div>

        <!-- Neck -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.neck.thickness.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.neckThickness.toFixed(2) }}</p>
        </div>

        <!-- Beard -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.beard.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.beardStyle }} ({{ appearance.physical.beardOpacity.toFixed(2) }})</p>
        </div>

        <!-- Ageing -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.ageing.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.ageingStyle }} ({{ appearance.physical.ageingOpacity.toFixed(2) }})</p>
        </div>

        <!-- Makeup -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.makeup.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.makeupStyle }} ({{ appearance.physical.makeupOpacity.toFixed(2) }})</p>
        </div>

        <!-- Blush -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.blush.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.blushStyle }} ({{ appearance.physical.blushOpacity.toFixed(2) }})</p>
        </div>

        <!-- Complexion -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.complexion.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.complexionStyle }} ({{ appearance.physical.complexionOpacity.toFixed(2) }})</p>
        </div>

        <!-- Sun Damage -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.sunDamage.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.sunDamageStyle }} ({{ appearance.physical.sunDamageOpacity.toFixed(2) }})</p>
        </div>

        <!-- Lipstick -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.lipstick.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.lipstickStyle }} ({{ appearance.physical.lipstickOpacity.toFixed(2) }})</p>
        </div>

        <!-- Moles & Freckles -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.molesFreckles.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.molesFrecklesStyle }} ({{ appearance.physical.molesFrecklesOpacity.toFixed(2) }})</p>
        </div>

        <!-- Chest Hair -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.chestHair.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.chestHairStyle }} ({{ appearance.physical.chestHairOpacity.toFixed(2) }})</p>
        </div>

        <!-- Body Blemishes -->
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.physicalCustomization.bodyBlemishes.style.title') }}</p>
          <p class="text-white font-semibold">{{ appearance.physical.bodyBlemishesStyle }} ({{ appearance.physical.bodyBlemishesOpacity.toFixed(2) }})</p>
        </div>
      </div>
    </div>

    <!-- Clothing Section -->
    <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
      <h3 class="text-white text-xl font-bold mb-4 pb-2 border-b border-slate-700">
        {{ t('characterCreation.recap.sections.clothing') }}
      </h3>
      <div class="grid grid-cols-3 gap-3 text-xs">
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.clothing.mask.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.clothing.maskDrawable }} / {{ appearance.clothing.maskTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.clothing.torso.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.clothing.torsoDrawable }} / {{ appearance.clothing.torsoTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.clothing.undershirt.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.clothing.undershirtDrawable }} / {{ appearance.clothing.undershirtTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.clothing.arms.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.clothing.armsDrawable }} / {{ appearance.clothing.armsTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.clothing.jacket.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.clothing.jacketDrawable }} / {{ appearance.clothing.jacketTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.clothing.bodyArmor.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.clothing.bodyArmorDrawable }} / {{ appearance.clothing.bodyArmorTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.clothing.decals.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.clothing.decalsDrawable }} / {{ appearance.clothing.decalsTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.clothing.pants.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.clothing.pantsDrawable }} / {{ appearance.clothing.pantsTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.clothing.shoes.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.clothing.shoesDrawable }} / {{ appearance.clothing.shoesTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.clothing.backpack.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.clothing.backpackDrawable }} / {{ appearance.clothing.backpackTexture }}</p>
        </div>
      </div>
    </div>

    <!-- Accessories Section -->
    <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
      <h3 class="text-white text-xl font-bold mb-4 pb-2 border-b border-slate-700">
        {{ t('characterCreation.recap.sections.accessories') }}
      </h3>
      <div class="grid grid-cols-3 gap-3 text-xs">
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.accessories.hat.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.accessories.hatDrawable }} / {{ appearance.accessories.hatTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.accessories.glasses.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.accessories.glassesDrawable }} / {{ appearance.accessories.glassesTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.accessories.earrings.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.accessories.earringsDrawable }} / {{ appearance.accessories.earringsTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.accessories.watch.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.accessories.watchDrawable }} / {{ appearance.accessories.watchTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.accessories.bracelet.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.accessories.braceletDrawable }} / {{ appearance.accessories.braceletTexture }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.accessories.neckAccessory.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.accessories.neckAccessoryDrawable }} / {{ appearance.accessories.neckAccessoryTexture }}</p>
        </div>
      </div>
    </div>

    <!-- Tattoos Section -->
    <div class="bg-slate-800/50 rounded-xl p-6 border border-slate-600/30">
      <h3 class="text-white text-xl font-bold mb-4 pb-2 border-b border-slate-700">
        {{ t('characterCreation.recap.sections.tattoos') }}
      </h3>
      <div class="grid grid-cols-2 gap-3 text-xs">
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.tattoos.head.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.tattoos.headTattooCollection }} / {{ appearance.tattoos.headTattooHash }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.tattoos.neck.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.tattoos.neckTattooCollection }} / {{ appearance.tattoos.neckTattooHash }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.tattoos.torso.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.tattoos.torsoTattooCollection }} / {{ appearance.tattoos.torsoTattooHash }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.tattoos.back.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.tattoos.backTattooCollection }} / {{ appearance.tattoos.backTattooHash }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.tattoos.leftArm.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.tattoos.leftArmTattooCollection }} / {{ appearance.tattoos.leftArmTattooHash }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.tattoos.rightArm.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.tattoos.rightArmTattooCollection }} / {{ appearance.tattoos.rightArmTattooHash }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.tattoos.leftLeg.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.tattoos.leftLegTattooCollection }} / {{ appearance.tattoos.leftLegTattooHash }}</p>
        </div>
        <div class="bg-slate-900/50 p-3 rounded">
          <p class="text-slate-400 mb-1">{{ t('characterCreation.tattoos.rightLeg.category') }}</p>
          <p class="text-white font-semibold">{{ appearance.tattoos.rightLegTattooCollection }} / {{ appearance.tattoos.rightLegTattooHash }}</p>
        </div>
      </div>
    </div>
  </div>
</template>
