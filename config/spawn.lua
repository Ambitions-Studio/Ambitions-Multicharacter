-- ===================================================================
-- AMBITIONS MULTICHARACTER - SPAWN CONFIGURATION
-- ===================================================================
-- This configuration file defines spawn behavior and character selection
-- settings for the Ambitions multicharacter system. It controls where
-- players spawn, how many character slots they have, and various UI
-- and gameplay options for the character selection process.
--
-- SYSTEM FEATURES:
-- • Configurable character slots per player
-- • Instance-based spawning for privacy during character creation
-- • Customizable spawn locations for selection and gameplay
-- • Character deletion permission controls
-- • Optimized for seamless character management workflow
-- ===================================================================

spawnConfig = {
  -- ===================================================================
  -- CHARACTER SLOT MANAGEMENT
  -- ===================================================================

  --- Maximum number of character slots per player
  ---
  --- This setting determines how many characters each player can create
  --- and manage on your server. The character selection interface will
  --- dynamically adjust to show the configured number of slots.
  ---
  --- CONFIGURATION:
  --- • Values: Any positive integer (recommended: 1-10)
  --- • Default: 2 (provides basic multi-character functionality)
  --- • Performance: Higher values may slightly increase UI load times
  characterSlots = 2,

  -- ===================================================================
  -- CHARACTER MANAGEMENT PERMISSIONS
  -- ===================================================================

  --- Allow players to delete their characters
  ---
  --- This setting controls whether the "Delete Character" button appears
  --- in the character selection interface. When disabled, players cannot
  --- remove their characters through the UI, requiring admin intervention.
  ---
  --- SECURITY CONSIDERATIONS:
  --- • Set to false for servers wanting permanent character commitment
  --- • Set to true for flexible character management
  --- • Character deletion is immediate and irreversible when enabled
  ---
  --- UI BEHAVIOR:
  --- • true: Red "Delete Character" button appears for existing characters
  --- • false: Only "Play Character" button appears for existing characters
  playerCanDeleteCharacter = true,

  -- ===================================================================
  -- CHARACTER APPEARANCE DEFAULTS
  -- ===================================================================

  --- Default player ped model for character creation
  ---
  --- This setting defines which ped model is used as the default template
  --- when a player begins creating a new character. This model is displayed
  --- in the character selection interface during the identity creation process,
  --- before the player customizes their appearance.
  ---
  --- TECHNICAL DETAILS:
  --- • Must be a valid GTA V ped model hash or string
  --- • Model is loaded automatically during character creation
  --- • Serves as base template for appearance customization systems
  --- • Applies to all new character creations unless overridden
  ---
  --- COMMON PED MODELS:
  --- • "mp_m_freemode_01": Male multiplayer freemode ped (default GTA Online male)
  --- • "mp_f_freemode_01": Female multiplayer freemode ped (default GTA Online female)
  --- • "none": No ped model spawned (player remains invisible during creation)
  --- • Custom peds: Any valid ped model from your server's stream folder
  ---
  --- CUSTOMIZATION WORKFLOW:
  --- 1. Player clicks "Create Character" on empty slot
  --- 2. System spawns this default ped model (if not "none")
  --- 3. Identity creator opens (firstname, lastname, DOB, etc.)
  --- 4. Appearance customization follows (if implemented)
  --- 5. Final ped model is saved to database
  ---
  --- PERFORMANCE:
  --- • Model is cached after first load
  --- • No performance impact on existing character selection
  --- • Minimal memory footprint for standard freemode models
  --- • "none" option has zero performance cost (no model loading)
  ---
  --- COMPATIBILITY:
  --- • Works with fivem-appearance, esx_skin, qb-clothing
  --- • Compatible with custom clothing/tattoo systems
  --- • Supports both vanilla and custom ped models
  --- • "none" option useful for UI-only character creation systems
  ---
  --- CONFIGURATION:
  --- • Default: "mp_m_freemode_01" (standard male multiplayer ped)
  --- • Change to "mp_f_freemode_01" for female default
  --- • Set to "none" to disable ped spawning during creation
  --- • Use custom ped hash for unique server identity
  defaultPed = "mp_m_freemode_01",

  -- ===================================================================
  -- INSTANCE SPAWNING SYSTEM
  -- ===================================================================

  --- Enable instance-based character selection spawning
  ---
  --- This advanced feature creates private instances for players
  --- during character creation and selection. Players are isolated
  --- from the main game world until they complete character selection.
  ---
  --- TECHNICAL BENEFITS:
  --- • Players can create/select characters without interference
  --- • Prevents other players from seeing character creation process
  --- • Reduces server load during peak connection times
  --- • Eliminates griefing during vulnerable character selection
  ---
  --- PERFORMANCE IMPACT:
  --- • Minimal server overhead (routing bucket management)
  --- • Slightly increased memory usage per connecting player
  --- • Automatic cleanup when players join main instance
  ---
  --- COMPATIBILITY:
  --- • Requires server artifacts 4752+ for routing bucket support
  --- • Works with all Ambitions framework features
  --- • Compatible with other instance-based resources
  ---
  --- CONFIGURATION:
  --- • true: Players spawn in private instances during character selection
  --- • false: Players spawn directly in main world (traditional method)
  instanceSpawning = true,

  -- ===================================================================
  -- WORLD COORDINATES CONFIGURATION
  -- ===================================================================

  --- Character selection spawn location
  ---
  --- This coordinate defines where players spawn when entering the
  --- character selection interface. Choose a location that is:
  --- • Visually appealing for character showcase
  --- • Free from NPC or vehicle interference
  --- • Well-lit for character appearance visibility
  --- • Accessible without special permissions
  ---
  --- COORDINATE FORMAT: vector4(x, y, z, heading)
  --- • x, y, z: World coordinates in GTA V units
  --- • heading: Player facing direction (0-360 degrees)
  ---
  --- RECOMMENDED LOCATIONS:
  --- • Mirror Park: Quiet residential area with good lighting
  --- • Observatory: Scenic overlook with minimal traffic
  --- • Beach areas: Open spaces with natural lighting
  --- • Custom MLO: Dedicated character selection interior
  characterSelectionSpawn = vector4(925.45, 11.70, 112.55, 301.35),

  --- Default player spawn location after character selection
  ---
  --- This coordinate defines where players spawn when they start playing
  --- with their selected character. This should be your server's primary
  --- spawn location or new player orientation area.
  ---
  --- CONSIDERATIONS:
  --- • Should match your server's new player experience flow
  --- • Ensure location has necessary facilities (shops, jobs, etc.)
  --- • Consider proximity to tutorial or orientation systems
  --- • Avoid spawning in restricted or dangerous areas
  ---
  --- COORDINATE FORMAT: vector4(x, y, z, heading)
  ---
  --- PLACEHOLDER VALUES:
  --- • Current settings use placeholder coordinates (0, 0, 70, 0)
  --- • IMPORTANT: Update these coordinates for your server!
  --- • The Z coordinate (70) prevents spawning underground
  ---
  --- COMMON SPAWN LOCATIONS:
  --- • Los Santos International Airport: Central, accessible
  --- • Mission Row Police Station: Urban, well-connected
  --- • Sandy Shores: Desert roleplay servers
  --- • Paleto Bay: Rural/small-town roleplay servers
  --- • Custom spawn building: Dedicated server orientation area
  playerSpawn = vector4(-3043.11, 26.9011, 10.1047, 325.984),
}