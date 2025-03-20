---@class HLUM.State : HLUM.State.Saved
---@field saved_state HLUM.State.Saved
---@field init fun(self: HLUM.State)
---@field save fun(self: HLUM.State, mod: HLUM.Mod)
---@field load fun(self: HLUM.State, state?: HLUM.State.Saved)
---@field level_d number
---@field money_cap_d number
HLUM.mt.State = Object:extend()


function HLUM.mt.State.init(self)
    self.level = 1
    self.money_cap = 20
    self.level_d = 1
    self.money_cap_d = nil

    if self.saved_state then self:load() end
end


function HLUM.mt.State.load(self, state)
    self.saved_state = state or self.saved_state

    if not self.saved_state then return end

    self.level = self.saved_state.level
    self.money_cap = self.saved_state.money_cap

    self.saved_state = nil
end


function HLUM.mt.State.save(self, mod)
    mod.config.state = { level = self.level, money_cap = self.money_cap }

    SMODS.save_mod_config(mod)
end


--- Level up Hermit
---@param self HLUM.State
---@param obj SMODS.Consumable
function HLUM.mt.State.level_up(self, obj)
    self.level = self.level + 1
    self.money_cap = self.money_cap + 5
    self.money_cap_d = self.money_cap_d or obj.config.extra

    obj.config.extra = self.money_cap
end
