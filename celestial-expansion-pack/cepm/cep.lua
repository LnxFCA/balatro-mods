---@class CEPM.mt.State.Card
---@field level_extra? number
---@field mult? number
---@field chips? number
---@field used number
---@field can_spawn boolean
---@field can_unlock boolean
---@field extra table<string, any>


---@class CEPM.mt.State.Saved
---@field level_mult number
---@field card_state table<string, CEPM.mt.State.Card>


---@class CEPM.mt.State : CEPM.mt.State.Saved
---@field saved_state? CEPM.mt.State.Saved
---@field load fun(self: CEPM.mt.State, state?: CEPM.mt.State.Saved)
---@field save fun(self: CEPM.mt.State, mod: CEPM.Mod)
---@field reset fun(self: CEPM.mt.State)
---@field new fun(self: CEPM.mt.State): CEPM.mt.State
---@field init fun(self: CEPM.mt.State)
CEPM.mt.State = {}


function CEPM.mt.State.new(self)
    local obj = setmetatable({}, self)
    for k, v in pairs(self) do obj[k] = v end

    obj:init()

    return obj
end


function CEPM.mt.State.init(self)
    self.level_mult = 1
    self.card_state = {}


    -- Initialize card state
    for k, _ in pairs(CEPM.cards) do
        self.card_state[k] = self.card_state[k] or { used = 0, can_spawn = false, can_unlock = false, extra = {}, }
    end

    if self.saved_state then self:load() end
end


function CEPM.mt.State.load(self, state)
    self.saved_state = state or self.saved_state
    if not self.saved_state then return end

    -- Load state
    for k, v in pairs(self.saved_state) do self[k] = v end

    -- Initialize card state
    for k, _ in pairs(CEPM.cards) do
        self.card_state[k] = self.card_state[k] or { used = 0, can_spawn = false, can_unlock = false, extra = {}, }
    end

    self.saved_state = nil
end


function CEPM.mt.State.save(self, mod)
    -- Save to mod configuration
    mod.config.cep = LNXFCA.utils.copy_table({
        level_mult = self.level_mult,
        card_state = self.card_state
    })


    SMODS.save_mod_config(CEPM.mod)
end


function CEPM.mt.State.reset(self)
    self:init()
end
