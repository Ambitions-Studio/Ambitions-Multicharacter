-- ===================================================================
-- AMBITIONS MULTICHARACTER - SETTINGS CONFIGURATION
-- ===================================================================
-- This configuration file defines integration settings and optional
-- features for the Ambitions multicharacter system. It controls which
-- external resources are integrated and how the system interacts with
-- other Ambitions framework components.
--
-- SYSTEM FEATURES:
-- • Toggle integrations with other Ambitions resources
-- • Enable/disable optional features per resource
-- • Automatic resource detection (only integrates if resource is running)
-- ===================================================================

settingsConfig = {

  -- ===================================================================
  -- RESOURCE INTEGRATIONS
  -- ===================================================================

  --- Enable Ambitions Inventory integration
  ---
  --- Automatically detects if the ambitions-inventory resource is available.
  --- When the resource is present, the multicharacter system will automatically
  --- create a player inventory for each new character during character creation.
  --- The inventory is linked to the character in the database.
  ---
  --- REQUIREMENTS:
  --- • ambitions-inventory resource must be running on the server
  --- • Database tables (inventories, inventory_items) must exist
  ---
  --- BEHAVIOR:
  --- • Resource detected: Creates inventory on character creation
  --- • Resource missing: No inventory integration, characters have no inventory
  ---
  --- DATABASE IMPACT:
  --- • Creates a row in `inventories` table per character
  --- • Links inventory_id to character in `characters` table
  --- • Inventory is deleted when character is deleted (via trigger)
  useAmbitionsInventory = GetResourceState('Ambitions-Inventory') ~= 'missing',

}
