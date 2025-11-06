-- ===================================================================
-- AMBITIONS MULTICHARACTER - DEFAULT CHARACTER CONFIGURATION
-- ===================================================================
-- This configuration file defines default character appearance settings
-- for the Ambitions multicharacter system. These defaults are used when
-- creating new characters to provide consistent starting points.
--
-- SYSTEM FEATURES:
-- • Complete GTA V character customization support
-- • Gender-specific default configurations
-- • All clothing slots and accessories included
-- • Facial features and body modifications covered
-- • Optimized for character creation workflow
-- ===================================================================

return {
  -- ===================================================================
  -- DEFAULT CHARACTER APPEARANCE SYSTEM
  -- ===================================================================

  --- Default character configurations by gender
  ---
  --- These configurations provide base appearance settings for new characters.
  --- Each gender has optimized defaults that ensure characters look natural
  --- and professional while still allowing full customization.
  ---
  --- GENDER KEYS:
  --- • "m" = Male character defaults
  --- • "f" = Female character defaults
  ---
  --- VALUE RANGES:
  --- • Most values range from -10 to +10 (facial features)
  --- • Clothing indices start from 0 (-1 means no item equipped)
  --- • Colors typically range from 0-63 (hair, makeup)
  --- • Opacity values range from 0-10 (makeup, overlays)
  defaultCharacter = {
    ["m"] = {
      -- ===================================================================
      -- HERITAGE & GENETICS
      -- ===================================================================

      --- Parent selection for character genetics
      --- Determines base facial structure and skin tone
      --- Range: 0-45 (face IDs from Benjamin to Misty)
      mom = 21,                -- Mother face ID (0-45: any face can be used)
      dad = 0,                 -- Father face ID (0-45: any face can be used)
      face_md_weight = 50,     -- Face mix: 0-100 (0=mother, 100=father)
      skin_md_weight = 50,     -- Skin mix: 0-100 (0=mother, 100=father)

      -- ===================================================================
      -- FACIAL STRUCTURE
      -- ===================================================================

      --- Nose configuration
      --- Fine-tunes nose shape and proportions
      --- Range: -10 to +10 for most parameters
      nose_1 = 0,              -- Nose width (narrow to wide)
      nose_2 = 0,              -- Nose peak height (low to high)
      nose_3 = 0,              -- Nose peak length (short to long)
      nose_4 = 0,              -- Nose bone height (low to high)
      nose_5 = 0,              -- Nose peak lowering (up to down)
      nose_6 = 0,              -- Nose bone twist (left to right)

      --- Cheek and jaw structure
      --- Defines facial width and bone prominence
      --- Range: -10 to +10 for bone adjustments
      cheeks_1 = 0,            -- Cheek bones height (low to high)
      cheeks_2 = 0,            -- Cheek bones width (narrow to wide)
      cheeks_3 = 0,            -- Cheeks width (thin to full)
      lip_thickness = 0,       -- Lip thickness (thin to full)

      --- Jaw and chin configuration (SetPedFaceFeature indices 13-19)
      --- Adjusts jaw and chin shape and prominence
      --- Range: -10 to +10 for positioning (internally converted to -1.0 to 1.0)
      jaw_1 = 0,               -- Index 13: Jaw bone width (narrow to wide)
      jaw_2 = 0,               -- Index 14: Jaw bone shape (round to square)
      chin_1 = 0,              -- Index 15: Chin bone position (up to down)
      chin_2 = 0,              -- Index 16: Chin bone length (backward to forward)
      chin_3 = 0,              -- Index 17: Chin bone shape (pointed to square)
      chin_4 = 0,              -- Index 18: Chin hole/dimple (shallow to deep)
      neck_thickness = 0,      -- Index 19: Neck thickness (thin to thick)

      -- ===================================================================
      -- HAIR STYLING
      -- ===================================================================

      --- Hair appearance settings
      --- Defines hairstyle and coloring
      --- Styles vary by gender and range from 0 to available options
      hair_1 = 0,              -- Hair style index (0 = bald/default)
      hair_2 = 0,              -- Hair texture variation
      hair_color_1 = 0,        -- Primary hair color (0-63)
      hair_color_2 = 0,        -- Secondary/highlight color (0-63)

      -- ===================================================================
      -- CLOTHING & ACCESSORIES
      -- ===================================================================

      --- Core clothing components (SetPedComponentVariation)
      --- Component IDs 0-11 with drawable and texture variants
      --- -1 indicates no item equipped for optional slots
      tshirt_1 = 15,           -- Component 8: Undershirt/accessories
      tshirt_2 = 0,            -- Undershirt texture
      torso_1 = 0,             -- Component 3: Torso (shirts, jackets)
      torso_2 = 0,             -- Torso texture
      decals_1 = 0,            -- Component 10: Decals/badges
      decals_2 = 0,            -- Decals texture
      arms = 0,                -- Component 11: Torso auxiliary parts
      arms_2 = 0,              -- Arms texture
      pants_1 = 0,             -- Component 4: Legs/pants
      pants_2 = 0,             -- Pants texture
      shoes_1 = 1,             -- Component 6: Feet/shoes
      shoes_2 = 0,             -- Shoes texture

      --- Additional clothing components
      mask_1 = 0,              -- Component 1: Face masks
      mask_2 = 0,              -- Mask texture
      bproof_1 = 0,            -- Component 9: Bulletproof vest/kevlar
      bproof_2 = 0,            -- Kevlar texture
      chain_1 = 0,             -- Component 7: Accessories/chains
      chain_2 = 0,             -- Chain texture
      bags_1 = 0,              -- Component 5: Bags/parachute
      bags_2 = 0,              -- Bag texture

      --- Props (SetPedPropIndex) - use -1 to disable
      helmet_1 = -1,           -- Prop 0: Hats/helmets
      helmet_2 = 0,            -- Helmet texture
      glasses_1 = -1,          -- Prop 1: Glasses/eyewear
      glasses_2 = 0,           -- Glasses texture
      ears_1 = -1,             -- Prop 2: Ear accessories
      ears_2 = 0,              -- Ear accessory texture
      watches_1 = -1,          -- Prop 6: Watches
      watches_2 = 0,           -- Watch texture
      bracelets_1 = -1,        -- Prop 7: Bracelets
      bracelets_2 = 0,         -- Bracelet texture

      -- ===================================================================
      -- FACIAL FEATURES & MAKEUP
      -- ===================================================================

      --- Eye configuration
      --- Controls eye color and shape modifications
      eye_color = 0,           -- Eye color (0-31)
      eye_squint = 0,          -- Eye opening/squinting (-10 to +10)

      --- Head Overlays (SetPedHeadOverlay)
      --- Overlay ID 0: Blemishes (0-23, 255=disable)
      blemishes_1 = 0,         -- Blemish style
      blemishes_2 = 0,         -- Blemish opacity (0-10)
      blemishes_3 = 0,         -- Blemish color (0-63)

      --- Overlay ID 1: Facial Hair/Beard (0-28, 255=disable)
      beard_1 = 0,             -- Beard style
      beard_2 = 0,             -- Beard opacity (0-10)
      beard_3 = 0,             -- Beard color (0-63)
      beard_4 = 0,             -- Beard secondary color (0-63)

      --- Overlay ID 2: Eyebrows (0-33, 255=disable)
      eyebrows_1 = 0,          -- Eyebrow style
      eyebrows_2 = 0,          -- Eyebrow opacity (0-10)
      eyebrows_3 = 0,          -- Eyebrow color (0-63)
      eyebrows_4 = 0,          -- Eyebrow secondary color (0-63)
      eyebrows_5 = 0,          -- Eyebrow height (-10 to +10)
      eyebrows_6 = 0,          -- Eyebrow depth (-10 to +10)

      --- Overlay ID 3: Ageing (0-14, 255=disable)
      age_1 = 0,               -- Aging style
      age_2 = 0,               -- Aging opacity (0-10)

      --- Overlay ID 4: Makeup (0-74, 255=disable)
      makeup_1 = 0,            -- Makeup style
      makeup_2 = 0,            -- Makeup opacity (0-10)
      makeup_3 = 0,            -- Makeup color (0-63)
      makeup_4 = 0,            -- Makeup secondary color (0-63)

      --- Overlay ID 5: Blush (0-6, 255=disable)
      blush_1 = 0,             -- Blush style
      blush_2 = 0,             -- Blush opacity (0-10)
      blush_3 = 0,             -- Blush color (0-63)

      --- Overlay ID 6: Complexion (0-11, 255=disable)
      complexion_1 = 0,        -- Complexion style
      complexion_2 = 0,        -- Complexion opacity (0-10)

      --- Overlay ID 7: Sun Damage (0-10, 255=disable)
      sun_1 = 0,               -- Sun damage style
      sun_2 = 0,               -- Sun damage opacity (0-10)

      --- Overlay ID 8: Lipstick (0-9, 255=disable)
      lipstick_1 = 0,          -- Lipstick style
      lipstick_2 = 0,          -- Lipstick opacity (0-10)
      lipstick_3 = 0,          -- Lipstick color (0-63)
      lipstick_4 = 0,          -- Lipstick secondary color (0-63)

      --- Overlay ID 9: Moles/Freckles (0-17, 255=disable)
      moles_1 = 0,             -- Moles style
      moles_2 = 0,             -- Moles opacity (0-10)

      --- Overlay ID 10: Chest Hair (0-16, 255=disable)
      chest_1 = 0,             -- Chest hair style
      chest_2 = 0,             -- Chest hair opacity (0-10)
      chest_3 = 0,             -- Chest hair color (0-63)

      --- Overlay ID 11-12: Body Blemishes (0-11, 255=disable)
      bodyb_1 = -1,            -- Body blemish style
      bodyb_2 = 0,             -- Body blemish opacity (0-10)
      bodyb_3 = -1,            -- Additional body blemish style
      bodyb_4 = 0,             -- Additional blemish opacity (0-10)

    },

    ["f"] = {
      -- ===================================================================
      -- HERITAGE & GENETICS (Female Configuration)
      -- ===================================================================

      --- Female-optimized parent selection
      --- Provides feminine facial structure defaults
      mom = 21,                -- Mother face optimized for female appearance
      dad = 0,                 -- Father face for genetic diversity
      grandparents = 0,        -- Grandparent influence

      --- Genetic blending for feminine features
      face_md_weight = 50,     -- Balanced parent influence
      skin_md_weight = 50,     -- Balanced skin tone inheritance
      face_g_weight = 0,       -- No grandparent influence

      -- ===================================================================
      -- FACIAL STRUCTURE (Female-Optimized)
      -- ===================================================================

      --- Feminine nose configuration
      --- Generally more refined and delicate than male defaults
      nose_1 = 0,              -- Nose width (typically narrower for females)
      nose_2 = 0,              -- Nose peak height
      nose_3 = 0,              -- Nose peak length
      nose_4 = 0,              -- Nose bone height
      nose_5 = 0,              -- Nose peak lowering
      nose_6 = 0,              -- Nose bone twist

      --- Feminine facial structure
      --- Softer features with natural contours
      cheeks_1 = 0,            -- Cheek bones height
      cheeks_2 = 0,            -- Cheek bones width
      cheeks_3 = 0,            -- Cheeks width
      lip_thickness = 0,       -- Lip fullness (often slightly fuller for females)

      --- Jaw and chin configuration (SetPedFaceFeature indices 13-19) - Female
      --- Adjusts jaw and chin shape for feminine features
      --- Range: -10 to +10 for positioning (internally converted to -1.0 to 1.0)
      jaw_1 = 0,               -- Index 13: Jaw bone width (narrow to wide)
      jaw_2 = 0,               -- Index 14: Jaw bone shape (round to square)
      chin_1 = 0,              -- Index 15: Chin bone position (up to down)
      chin_2 = 0,              -- Index 16: Chin bone length (backward to forward)
      chin_3 = 0,              -- Index 17: Chin bone shape (pointed to square)
      chin_4 = 0,              -- Index 18: Chin hole/dimple (shallow to deep)
      neck_thickness = 0,      -- Index 19: Neck thickness (thin to thick)

      -- ===================================================================
      -- HAIR STYLING (Female Defaults)
      -- ===================================================================

      --- Female hairstyle defaults
      --- Professional and versatile styling options
      hair_1 = 4,              -- Female-appropriate hairstyle
      hair_2 = 0,              -- Hair texture
      hair_color_1 = 1,        -- Natural hair color variation
      hair_color_2 = 0,        -- Highlight/lowlight color

      -- ===================================================================
      -- FEMALE CLOTHING DEFAULTS
      -- ===================================================================

      --- Female-specific clothing configuration
      --- Professional and appropriate default wardrobe
      tshirt_1 = 14,           -- Female undershirt/base layer
      tshirt_2 = 0,            -- Texture variant
      torso_1 = 15,            -- Female torso clothing
      torso_2 = 0,             -- Texture variant
      decals_1 = 0,            -- Decal overlays
      decals_2 = 0,            -- Decal texture
      arms = 15,               -- Female arm clothing fit
      arms_2 = 0,              -- Arms texture
      pants_1 = 14,            -- Female leg clothing
      pants_2 = 0,             -- Pants texture
      shoes_1 = 5,             -- Female footwear
      shoes_2 = 0,             -- Shoe texture

      --- Female accessories (same availability as male)
      mask_1 = 0,              -- Face coverings
      mask_2 = 0,              -- Mask texture
      bproof_1 = 0,            -- Protective gear
      bproof_2 = 0,            -- Armor texture
      chain_1 = 0,             -- Neck jewelry
      chain_2 = 0,             -- Chain texture
      helmet_1 = -1,           -- Headwear - disabled by default
      helmet_2 = 0,            -- Helmet texture
      glasses_1 = -1,          -- Eyewear - disabled by default
      glasses_2 = 0,           -- Glasses texture
      watches_1 = -1,          -- Timepieces - disabled by default
      watches_2 = 0,           -- Watch texture
      bracelets_1 = -1,        -- Wrist jewelry - disabled by default
      bracelets_2 = 0,         -- Bracelet texture
      bags_1 = 0,              -- Bags and accessories
      bags_2 = 0,              -- Bag texture

      -- ===================================================================
      -- FEMININE FACIAL FEATURES
      -- ===================================================================

      --- Eye styling for females
      eye_color = 0,           -- Eye color selection
      eye_squint = 0,          -- Eye shape modification

      --- Head Overlays (SetPedHeadOverlay) - Female optimized
      --- Overlay ID 0: Blemishes (0-23, 255=disable)
      blemishes_1 = 0,         -- Blemish style
      blemishes_2 = 0,         -- Blemish opacity (0-10)
      blemishes_3 = 0,         -- Blemish color (0-63)

      --- Overlay ID 1: Facial Hair/Beard (0-28, 255=disable) - N/A for females
      beard_1 = 0,             -- Not applicable for females
      beard_2 = 0,             -- Not applicable for females
      beard_3 = 0,             -- Not applicable for females
      beard_4 = 0,             -- Not applicable for females

      --- Overlay ID 2: Eyebrows (0-33, 255=disable) - Enhanced for females
      eyebrows_1 = 1,          -- Eyebrow style (more defined)
      eyebrows_2 = 10,         -- Eyebrow opacity (higher)
      eyebrows_3 = 0,          -- Eyebrow color (0-63)
      eyebrows_4 = 0,          -- Eyebrow secondary color (0-63)
      eyebrows_5 = 0,          -- Eyebrow height (-10 to +10)
      eyebrows_6 = 0,          -- Eyebrow depth (-10 to +10)

      --- Overlay ID 3: Ageing (0-14, 255=disable)
      age_1 = 0,               -- Aging style
      age_2 = 0,               -- Aging opacity (0-10)

      --- Overlay ID 4: Makeup (0-74, 255=disable)
      makeup_1 = 0,            -- Makeup style
      makeup_2 = 0,            -- Makeup opacity (0-10)
      makeup_3 = 0,            -- Makeup color (0-63)
      makeup_4 = 0,            -- Makeup secondary color (0-63)

      --- Overlay ID 5: Blush (0-6, 255=disable)
      blush_1 = 0,             -- Blush style
      blush_2 = 0,             -- Blush opacity (0-10)
      blush_3 = 0,             -- Blush color (0-63)

      --- Overlay ID 6: Complexion (0-11, 255=disable)
      complexion_1 = 0,        -- Complexion style
      complexion_2 = 0,        -- Complexion opacity (0-10)

      --- Overlay ID 7: Sun Damage (0-10, 255=disable)
      sun_1 = 0,               -- Sun damage style
      sun_2 = 0,               -- Sun damage opacity (0-10)

      --- Overlay ID 8: Lipstick (0-9, 255=disable)
      lipstick_1 = 0,          -- Lipstick style
      lipstick_2 = 0,          -- Lipstick opacity (0-10)
      lipstick_3 = 0,          -- Lipstick color (0-63)
      lipstick_4 = 0,          -- Lipstick secondary color (0-63)

      --- Overlay ID 9: Moles/Freckles (0-17, 255=disable)
      moles_1 = 0,             -- Moles style
      moles_2 = 0,             -- Moles opacity (0-10)

      --- Overlay ID 10: Chest Hair (0-16, 255=disable) - N/A for females
      chest_1 = 0,             -- Not applicable for females
      chest_2 = 0,             -- Not applicable for females
      chest_3 = 0,             -- Not applicable for females

      --- Overlay ID 11-12: Body Blemishes (0-11, 255=disable)
      bodyb_1 = -1,            -- Body blemish style
      bodyb_2 = 0,             -- Body blemish opacity (0-10)
      bodyb_3 = -1,            -- Additional body blemish style
      bodyb_4 = 0,             -- Additional blemish opacity (0-10)

      --- Props (SetPedPropIndex) - Female accessories
      ears_1 = -1,             -- Prop 2: Ear jewelry - disabled by default
      ears_2 = 0,              -- Ear accessory texture
    }
  }
}