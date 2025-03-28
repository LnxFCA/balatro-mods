---@meta

---@class HLUM.State.Saved
---@field level number
---@field money_cap number
---@field money_scale number


---@class HLUM.Config.CycleConfig
---@field current_option number
---@field current_option_val number


---@class HLUM.Config
---@field state HLUM.State.Saved
---@field money_scale number
---@field cycle_config HLUM.Config.CycleConfig


---@class HLUM.Mod : SMODS_T.Mod
---@field config HLUM.Config


---@class HLUM
---@field state HLUM.State
---@field mt { State: HLUM.State }
---@field mod HLUM.Mod
---@field mod_id string
---@field UIDEF table<string, any>
---@field overrides table<string, function>
---@field callbacks table<string, function>
---@field init fun(self: HLUM)
