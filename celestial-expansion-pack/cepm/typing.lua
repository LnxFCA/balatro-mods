---@meta


---@class CEPM.State
---@field cards table<string, table>
---@field last_hand string
---@field first_hand string
---@field last_card string


---@class CEPM.Card
---@field key string
---@field pos { x: number, y: number }
---@field use? fun(self: SMODS.Consumable, card: BALATRO_T.Card, area: BALATRO_T.CardArea, copier: table)
---@field loc_vars? fun(self: SMODS.Consumable, card: BALATRO_T.Card): table
---@field loc_vars_default? { hand: string, chips: string, mult: string, extra?: string }


---@class CEPM.Mod.Config
---@field cards table<string, table>


---@class CEPM.Mod : SMODS_T.Mod
---@field config CEPM.Mod.Config

---@class CEPM
---@field state CEPM.State
---@field cards table<string, CEPM.Card>
---@field original table<string, function>
---@field mod CEPM.Mod | SMODS_T.Mod
---@field mod_id string
---@field utils table<string, function>
local CEPM = {}


function CEPM.init(self) end
