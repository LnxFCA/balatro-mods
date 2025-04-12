---@meta


---@class FWNM.State.Edition
---@field name string
---@field weight number


---@class FWNM.State.Editions
---@field e_negative FWNM.State.Edition
---@field e_polychrome FWNM.State.Edition
---@field e_holo FWNM.State.Edition
---@field e_foil FWNM.State.Edition


---@class FWNM.Mod.Config
---@field state? FWNM.State.Saved


---@class FWNM.Mod
---@field config FWNM.Mod.Config


---@class FWNM
---@field mod FWNM.Mod
---@field id string
---@field state FWNM.State
---@field original table<string, function | table>
---@field UIDEF table<string, function | table>
---@field obj_table table<string, SMODS.Consumable.All | SMODS.Voucher>
---@field mt { State: FWNM.State | fun(): FWNM.State }
local FWNM = {}


_G.FWNM = FWNM
