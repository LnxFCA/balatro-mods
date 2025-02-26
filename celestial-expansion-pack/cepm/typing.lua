---@meta


---@class CEPM.Card
---@field key string
---@field pos { x: number, y: number }
---@field use? fun(self: SMODS.Consumable, card: BALATRO_T.Card, area: BALATRO_T.CardArea, copier: table)
---@field can_use? fun(sel: SMODS.Consumable, card: BALATRO_T.Card): boolean
---@field loc_vars? fun(self: SMODS.Consumable, card: BALATRO_T.Card): table
---@field in_pool? fun(self: SMODS.Consumable, args: table): boolean, { allow_duplicate: boolean }?
---@field check_for_unlock? fun(self: SMODS.Consumable, args: table): boolean
---@field config { level: integer, level_extra?: integer }


---@class CEPM.Mod.Config
---@field cep CEPM.mt.State.Saved
---@field instant_level_up boolean


---@class CEPM.Mod : SMODS_T.Mod
---@field config CEPM.Mod.Config

---@class CEPM
---@field state CEPM.mt.State
---@field cards table<string, CEPM.Card>
---@field original table<string, function>
---@field mod CEPM.Mod | SMODS_T.Mod
---@field mod_id string
---@field utils table<string, function>
---@field mt table
local CEPM = {}


function CEPM.init(self) end
