---@meta


---@class FRSM.Mod.Config
---@field default_keybind string Default activation key
---@field custom_keybind string Custom activation key
---@field enable_custom_keybind boolean Enable custom activate key
---@field enable_button boolean Display the FRSM button on the main menu screen
---@field persist_selection boolean Use selected items across game starts (not runs)
---@field state FRSM.mt.State.Saved Mod state


---@class FRSM.Mod : SMODS.Mod.Base, SMODS.Mod.Extra
---@field config FRSM.Mod.Config


---@class FRSM.mt.State.Selection
---@field vouchers string[] Selected vouchers
---@field boosters string[] Selected booster packs
---@field jokers { selected: string[], set: string } Selected cards, like Jokers, Tarots, etc...
---@field cost number Cost of used slots
---@field shop_cost number Estimated cost of selected items


---@class FRSM.mt.State.Saved
---@field selection { old: FRSM.mt.State.Selection, current: FRSM.mt.State.Selection }


---@class FRSM.mt.State: FRSM.mt.State.Saved
---@field ui_active boolean Mod UI status
---@field cost number Current used slots cost
---@field shop_cost number Current selected items cost
---@field saved_state FRSM.mt.State.Saved Restored state
---@field new fun(self: FRSM.mt.State): FRSM.mt.State
---@field init fun(self: FRSM.mt.State)
---@field load fun(self: FRSM.mt.State, state?: FRSM.mt.State.Saved)
---@field save fun(self: FRSM.mt.State, mod: FRSM.Mod)


---@class FRSM
---@field mod FRSM.Mod
---@field mod_id string
---@field state FRSM.mt.State
---@field UIDEF table<string, any>
---@field utils table<string, function>
---@field init fun(self: FRSM)
---@field activate fun(self: FRSM)
---@field callbacks table<string, function>
---@field overrides table<string, function>
---@field mt { State: FRSM.mt.State }


---@class FRSM.Card : BALATRO.Card
---@field ability_UIBox_table table<string, any>
