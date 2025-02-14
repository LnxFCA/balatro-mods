---@class CEPM.mt.State.Card
---@field level_extra? number
---@field mult? number
---@field chips? number


---@class CEPM.mt.State.Saved
---@field last_card? string
---@field first_hand? string
---@field last_hand? string
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
    self.last_card = nil
    self.last_hand = nil
    self.first_hand = nil
    self.level_mult = 1
    self.card_state = {}

    for k, _ in pairs(CEPM.cards) do self.card_state[k] = self.card_state[k] or {} end

    if self.saved_state then self:load() end
end


function CEPM.mt.State.load(self, state)
    self.saved_state = state or self.saved_state
    if not self.saved_state then return end

    -- Load state
    for k, v in pairs(self.saved_state) do self[k] = v end
    for k, _ in pairs(CEPM.cards) do self.card_state[k] = self.card_state[k] or {} end

    self.saved_state = nil
end


function CEPM.mt.State.save(self, mod)
    -- Save to mod configuration
    mod.config.cep = LNXFCA.utils.copy_table({
        last_card = self.last_card,
        first_hand = self.first_hand,
        last_hand = self.last_hand,
        level_mult = self.level_mult,
        card_state = self.card_state
    })


    SMODS.save_mod_config(CEPM.mod)
end


function CEPM.mt.State.reset(self)
    self:init()
end
