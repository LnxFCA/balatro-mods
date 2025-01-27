---@meta


---@class LTDM.LockItem.State
---@field no_locked boolean The initial lock state of the card, false if generated.
---@field id string The unique identifier
---@field key string Card key
---@field button { label: string, price: string } The LTD button state
---@field locked boolean The lock status of the item
---@field index integer? The index of the card in the current area
---@field area string The area the item belongs to.
---@field force_lock boolean Force lock status


--- Represents a locked card
---@class LTDM.LockItem
---@field id string The unique key identifier
---@field key string The locked card key
---@field price number The item price
---@field set string The item set, e.g Joker, Tarot, Voucher
---@field edition table<string, boolean?>? The card edition
---@field enhancement string? The ehnacement key. See `G.P_CENTERS`
---@field seal string? The seal name. See `Card.seal`
---@field state LTDM.LockItem.State State of the card, from card.ltdm_state


---@class LTDM.State
---@field lock_keybind string Active lock/unlock Keybind
---@field keybind_status_text string Error text for keybind
---@field keybind SMODS.Keybind? SMODS.Keybind instance
---@field ltd LTDM.mt.State LTD state


---@class LTDM.Config
---@field frjm_integration boolean Enable integration with FRJM
---@field lock_keybind_enable boolean Enable lock keybind
---@field lock_default_keybind string Default lock/unlock keybind
---@field lock_keybind string Keybind to trigger lock/unlock action
---@field ltd? LTDM.mt.State.Saved Saved state, use LTDM.ltd:load_saved(mod)
---@field booster_pack_enabled boolean Enable LTD for booster packs


---@class LTDM.Utils
---@field parent fun(): LTDM Return the parent LTDM instance
---@field check_keybind fun(self: LTDM.Utils): number 0 if keybind valid, 1 if keybind invalid, 2 if keybind exists
---@field update_lock_keybind fun(self: LTDM.Utils): boolean? Set the mod lock/unlock keybind to state.lock_keybind. Assumes that config.lock_keybind is always valid.
---@field keybind_activate fun(self: LTDM.Utils) Runs when lock/unlock keybind is pressed. Must invoked as `:keybind_activate()`. Checks for `config.lock_keybind_enable`.
---@field save_config fun(self: LTDM.Utils) Save mod configuration
---@field generate_uuid fun(): string Returns a UUID v4 string
---@field get_ehnacement_key fun(ability: BALATRO_T.Card.Ability): string? Returns the key of the enhancement


---@class LTDM
---@field state LTDM.State Mod state
---@field original table<string, function> Original game functions
---@field mod LTDM.Mod SMODS.current_mod
---@field mod_id string Mod id
---@field UIDEF table<string, function> UI definition functions
---@field utils LTDM.Utils Mod utility functions
---@field include fun(filename: string) Load `filename` inside mod context
---@field mt table<string, any>
local LTDM = {}


---@class LTDM.Mod : SMODS_T.Mod
---@field config LTDM.Config


---@class LTDM.Card : BALATRO_T.Card
---@field ltdm_state LTDM.LockItem.State The card local state
---@field ltdm_saved_id? string The saved it for this card
---@field opening boolean? Opening pack status
---@field frjm_shop_joker boolean? FRJM integration


---@class LTDM.ButtonConfig
---@field width number Button minwidth
---@field label_scale number Button label scale
---@field lock_offset_x { voucher: number, other: number, booster: number, consumeable: number }
---@field locked_offset_x { voucher: number, other: number, booster: number, consumeable: number }


---@class LTDM.Button.Config : BALATRO_T.UIDef.Config.Common
---@field ref_table LTDM.Card
---@field ltd_btn_conf LTDM.ButtonConfig

---@class LTDM.Button : BALATRO_T.Moveable
---@field UIRoot BALATRO_T.UIBox
---@field UIBox BALATRO_T.UIBox
---@field config LTDM.Button.Config

--- Initialize the mod
function LTDM.init(self) end
