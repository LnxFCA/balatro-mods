---@meta


---@class FRJM
---@field mod FRJM.Mod mod instance. `SMODS.current_mod`
---@field mod_id string mod id
---@field UI { [string]: fun(): UIDef } mod UI definitions
---@field original table original game functions
---@field config FRJM.RConfig mod runtime configuration
---@field init fun(self: FRJM)
---@field include fun(self: FRJM, filename: string)
---@field activate fun(self: any)
---@field utils FRJM.Utils
---@field save_config fun(self: FRJM)
---@field check fun(self: FRJM, area: any): boolean


---@class FRJM.Mod
---@field config FRJM.MConfig mod local configuration
---@field id string mod id
---@field config_tab fun() : UIDef mod configuration tab


---@class FRJM.MConfig
---@field joker_key string | nil saved joker key
---@field save_joker boolean joker key saving status
---@field base_price boolean use joker base price status
---@field custom_keybind string mod activation custom keybind
---@field default_keybind string mod activation default keybind
---@field use_custom_keybind boolean use mod activation custom keybind status
---@field joker_name string | nil saved Joker name


---@class FRJM.RConfig
---@field enabled boolean mod active status
---@field joker_key string | nil selected joker key
---@field keybind string mod activation keybind
---@field selection_ui_active boolean selection overlay status
---@field card_selection FRJM.RConfig.Selection


---@class FRJM.RConfig.Selection
---@field name string selection selected Joker name
---@field key string selection selected Joker key


---@class FRJM.Utils
---@field parent fun(): FRJM
---@field show_card_selection_overlay fun(self: FRJM.Utils)
---@field select_joker_card fun(self: FRJM.Utils, card: table)
---@field debug fun(self: FRJM.Utils, msg: string, funcv: any)
