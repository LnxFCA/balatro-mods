---@meta

---@class HLUM.State.Saved
---@field level number
---@field money_cap number


---@class HLUM.Config
---@field state HLUM.State.Saved


---@class HLUM.Mod : Mod
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
