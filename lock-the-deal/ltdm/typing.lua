---@meta


--- Represents a locked card
---@class LTDM.LockItem
---@field key string The locked card key
---@field set string The card set
---@field editon BALATRO_T.Card.Edition The card editon
---@field cost number The card cost


---@class LTDM.State
---@field lock_table table<string, LTDM.LockItem> Table with locked cards information
---@field lock_number number The number of current locked cards
---@field run_status LTDM.GameStatus Mod current state. If true, then is in-game
---@field lock_keybind string Active lock/unlock Keybind
---@field keybind_status_text string Error text for keybind
---@field keybind SMODS.Keybind? SMODS.Keybind instance
---@field ltd_button_text table<string, { text: string, popup_title: string, popup_text: string }>


---@class LTDM.Config
---@field frjm_integration boolean Enable integration with FRJM
---@field lock_table table<string, LTDM.LockItem> Table with locked cards information
---@field lock_number number THe number of current locked cards
---@field lock_keybind_enable boolean Enable lock keybind
---@field lock_default_keybind string Default lock/unlock keybind
---@field lock_keybind string Keybind to trigger lock/unlock action


---@class LTDM.Utils
---@field parent fun(): LTDM Return the parent LTDM instance
---@field check_keybind fun(self: LTDM.Utils): number 0 if keybind valid, 1 if keybind invalid, 2 if keybind exists
---@field update_lock_keybind fun(self: LTDM.Utils): boolean? Set the mod lock/unlock keybind to state.lock_keybind. Assumes that config.lock_keybind is always valid.
---@field lock_card fun(self: LTDM.Utils, card: BALATRO_T.Card) Lock a card
---@field unlock_card fun(self: LTDM.Utils, key: string) Unlock a card
---@field remove_card fun(self: LTDM.Utils, key: string) Removes a card from lock_table and ltd_button_text.
---@field keybind_activate fun(self: LTDM.Utils) Runs when lock/unlock keybind is pressed. Must invoked as `:keybind_activate()`. Checks for `config.lock_keybind_enable`.
---@field activate fun(self: LTDM.Utils, e: BALATRO_T.UIElement) Runs when the user clicks the lock/unlock button
---@field debug fun(self, msg: string?, funcv: function | { short_src: string, linedefined: number, name: string } | nil)
---@field save_config fun(self: LTDM.Utils) Save mod configuration

---@class LTDM
---@field state LTDM.State Mod state
---@field original table<string, function> Original game functions
---@field mod LTDM.Mod | SMODS_T.Mod SMODS.current_mod
---@field mod_id string Mod id
---@field UIDEF table<string, function> UI definition functions
---@field utils LTDM.Utils Mod utility functions
---@field include fun(filename: string) Load `filename` inside mod context
local LTDM = {}


---@class LTDM.Mod : SMODS_T.Mod
---@field config LTDM.Config

---@enum LTDM.GameStatus
LTDM.GameStatus = {
    NEW_RUN = 1, --- A new run
    LOAD_RUN = 2, --- A existent run
}


--- Initialize the mod
function LTDM.init(self) end
