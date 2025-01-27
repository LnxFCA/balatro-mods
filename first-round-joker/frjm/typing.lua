---@meta


---@class FRJM
---@field mod FRJM.Mod | SMODS_T.Mod Mod instance. `SMODS.current_mod`
---@field mod_id string Mod id
---@field UI { [string]: fun() | fun(): UIDef } Mod UI definitions
---@field original table Original game functions
---@field state FRJM.State Mod runtime configuration
---@field init fun(self: FRJM)
---@field include fun(filename: string)
---@field activate fun(self: any)
---@field utils FRJM.Utils
---@field save_config fun(self: FRJM)
---@field can_activate fun(self: FRJM, area: BALATRO_T.CardArea): boolean
---@field update_keybind fun(self: FRJM)


---@class FRJM.Mod : SMODS_T.Mod
---@field config FRJM.Mod.Config


---@class FRJM.Mod.Config
---@field joker_key string? Saved joker key
---@field save_joker boolean Joker key saving status
---@field base_price boolean Use joker base price status
---@field custom_keybind string Mod activation custom keybind
---@field default_keybind string Mod activation default keybind
---@field use_custom_keybind boolean Use mod activation custom keybind status
---@field joker_name string | nil Saved Joker name
---@field enable_frjm_button boolean Show FRJM button?
---@field disable_restriction boolean Disable discovered Joker restriction


---@class FRJM.State
---@field enabled boolean Mod active status
---@field joker_key string | nil Selected joker key
---@field keybind string Mod activation keybind
---@field selection_ui_active boolean Selection overlay status
---@field card_selection FRJM.State.Selection
---@field frjm_button BALATRO_T.UIBox
---@field keybind_obj SMODS.Keybind


---@class FRJM.State.Selection
---@field name string Selection selected Joker name
---@field key string Selection selected Joker key


---@class FRJM.Utils
---@field parent fun(): FRJM
---@field show_card_selection_overlay fun(self: FRJM.Utils)
---@field select_joker_card fun(self: FRJM.Utils, card: table)
