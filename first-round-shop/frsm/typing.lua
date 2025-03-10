---@meta


---@class FRSM.Mod.Config


---@class FRSM.Mod : Mod
---@field config FRSM.Mod.Config


---@class FRSM.State
---@field ui_active boolean


---@class FRSM
---@field mod FRSM.Mod
---@field mod_id string
---@field state FRSM.State
---@field UIDEF table<string, function | table>
---@field utils table<string, function>
---@field init fun(self: FRSM)
---@field activate fun(self: FRSM)
