---@meta


---@class FRSM.Mod.Config


---@class FRSM.Mod : SMODS_T.Mod
---@field config FRSM.Mod.Config


---@class FRSM.State
---@field ui_active boolean
---@field shop_cost number
---@field cost number


---@class FRSM
---@field mod FRSM.Mod
---@field mod_id string
---@field state FRSM.State
---@field UIDEF table<string, any>
---@field utils table<string, function>
---@field init fun(self: FRSM)
---@field activate fun(self: FRSM)
---@field callbacks table<string, function>
---@field overrides table<string, function>


---@class FRSM.Card : BALATRO_T.Card
---@field ability_UIBox_table table<string, any>
