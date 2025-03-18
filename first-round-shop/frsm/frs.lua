FRSM.mt.State = {}


--- Create a new State object
---@param self any
---@return FRSM.mt.State
function FRSM.mt.State.new(self)
    local obj = setmetatable({}, self)

    for k, v in pairs(self) do obj[k] = v end

    obj:init()

    return obj
end


--- Init state object
---@param self FRSM.mt.State
function FRSM.mt.State.init(self)
    self.ui_active = false
    self.cost = 0
    self.shop_cost = 0
    self.selection = {}

    if self.saved_state then self:load(self) end
end


--- Load from saved state
---@param self FRSM.mt.State
---@param state FRSM.mt.State.Saved
function FRSM.mt.State.load(self, state)
    self.saved_state = state or self.saved_state

    if not self.saved_state then return end

    for k, v in pairs(self.saved_state) do self[k] = v end
    self.saved_state = nil
end


--- Save state on mod configuration
---@param self FRSM.mt.State
---@param mod FRSM.Mod
function FRSM.mt.State.save(self, mod)
    mod.config.state = LNXFCA.utils.copy_table({
        selection = self.selection,
    })

    SMODS.save_mod_config(mod)
end
