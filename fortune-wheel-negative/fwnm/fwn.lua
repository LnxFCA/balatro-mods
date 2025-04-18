
---@class FWNM.State.Saved
---@field editions FWNM.State.Editions | SMODS.PollEdition.Options
---@field active boolean


---@class FWNM.State : FWNM.State.Saved
---@field saved_state? FWNM.State.Saved
---@field saved boolean
---@field loaded boolean
FWNM.mt.State = Object:extend() --[[@as FWNM.State]]

--- Initializes a new `State` object.
---@param self FWNM.State
function FWNM.mt.State.init(self)

    self.loaded = false
    self:load()

    if self.loaded then return end

    self.editions = {
        e_negative = { name = 'e_negative', weight = G.P_CENTERS.e_negative.weight },
        e_polychrome = { name = 'e_polychrome', weight = G.P_CENTERS.e_polychrome.weight },
        e_holo = { name = 'e_holo', weight = G.P_CENTERS.e_holo.weight },
        e_foil = { name = 'e_holo', weight = G.P_CENTERS.e_foil.weight },
    }

    self.active = false
    self.saved = false
end


--- Load state from `state`.
---@param self FWNM.State
---@param state? FWNM.State.Saved
---@return FWNM.State.Saved? prev
function FWNM.mt.State.load(self, state)
    self.saved_state = state or self.saved_state
    if not self.saved_state then return end

    local tmp_state = LNXFCA.utils.copy_table(self.saved_state)  --[[@as FWNM.State.Saved]]
    for k, v in pairs(tmp_state) do self[k] = v end

    tmp_state = self.saved_state
    self.saved_state = nil
    self.loaded = true
    self.saved = true

    return tmp_state
end


--- Save state
---@param self FWNM.State
---@param mod FWNM.Mod
function FWNM.mt.State.save(self, mod)
    local tmp_state = {
        active = self.active,
        editions = self.editions
    }

    mod.config.state = LNXFCA.utils.copy_table(tmp_state)
    EMPTY(tmp_state.editions)
    EMPTY(tmp_state)

    self.saved = true
    SMODS.save_mod_config(mod --[[@as SMODS.Mod]])
end


--- Return a list of editions
---@param self FWNM.State
---@return SMODS.PollEdition.Options
function FWNM.mt.State.get_editions_list(self)
    local edition_list = {
        self.editions.e_negative,
        self.editions.e_polychrome,
        self.editions.e_holo,
        self.editions.e_foil,
     }

    return edition_list
end


--- Activate the Negative Wheel
---@param self FWNM.State
function FWNM.mt.State.activate(self)
    self.saved = false
    self.active = true

    self:update_negative_chance(2)
end


--- Update negative edition change
---@param self FWNM.State|fun():FWNM.State
---@param mod? number
function FWNM.mt.State.update_negative_chance(self, mod)
    self.saved = false
    self.editions.e_negative.weight = self.editions.e_negative.weight + (mod or 1)
end
