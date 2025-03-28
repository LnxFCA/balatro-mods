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
    self.money_scale = HLUM.mod.config.money_scale
    self.level_d = 1
    self.money_cap_d = G.P_CENTERS.c_hermit.config.extra
    self.money_cap = self.money_cap_d or 20

    if self.saved_state then self:load() end
end


function HLUM.mt.State.load(self, state)
    self.saved_state = state or self.saved_state

    if not self.saved_state then return end

    self.level = self.saved_state.level or 1
    self.money_cap = self.saved_state.money_cap or G.P_CENTERS.c_hermit.config.extra or 20
    self.money_scale = HLUM.mod.config.money_scale or self.saved_state.money_scale or 10

    self:update_scale(self.money_scale)

    self.saved_state = nil
end


function HLUM.mt.State.save(self, mod)
    mod.config.state = { level = self.level, money_cap = self.money_cap, money_scale = self.money_scale }

    SMODS.save_mod_config(mod)
end


--- Level up Hermit
---@param self HLUM.State
---@param obj SMODS.Consumable
function HLUM.mt.State.level_up(self, obj)
    self.level = self.level + 1
    self.money_cap = self.money_cap + self.money_scale

    obj.config.extra = self.money_cap
end


--- Update Hermit money scale
---@param self HLUM.State
---@param new number
function HLUM.mt.State.update_scale(self, new)
    self.money_scale = new
    self.money_cap = self.money_cap_d + (self.money_scale * (self.level - 1))
end
