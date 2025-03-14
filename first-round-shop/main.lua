FRSM = {} --[[@as FRSM]] ---@diagnostic disable-line:missing-fields

function FRSM.init(self)
    self.state = {}
    self.utils = {}
    self.UIDEF = {}

    -- State
    self.state.ui_active = false
    self.state.shop_cost = 0
    self.state.cost = 0

    self.mod = SMODS.current_mod --[[@as FRSM.Mod]]
    self.mod_id = self.mod.id
end


-- Initialize mod
FRSM:init()

-- Load shared module
if not LNXFCA or not LNXFCA.initialized and lnxfca_common_init then
    lnxfca_common_init()
end


-- Load mod files
LNXFCA.include("frsm/ui/frs.lua", FRSM.mod_id)
LNXFCA.include("frsm/ui/collection.lua")
LNXFCA.include("frsm/frs.lua", FRSM.mod_id)
LNXFCA.include("frsm/utils.lua", FRSM.mod_id)
LNXFCA.include("frsm/callbacks.lua", FRSM.mod_id)
LNXFCA.include("frsm/overrides.lua", FRSM.mod_id)


SMODS.Keybind({
    key_pressed = 's',
    event = 'pressed',
    action = function()
        if not FRSM.state.ui_active then FRSM:activate() end
    end,
})
