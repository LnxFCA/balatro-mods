---@diagnostic disable:missing-fields
CEPM = {}  ---@type CEPM


function CEPM.init(self)
    self.original = {}
    self.cards = {}
    self.utils = {}

    self.mod = SMODS.current_mod
    self.mod_id = self.mod_id

    self.mt = {}
    self.state = {}
end


CEPM:init()


if not LNXFCA and not LNXFCA.initialized and lnxfca_common_init then
    lnxfca_common_init()
end


LNXFCA.include("cepm/cards.lua", CEPM.mod_id)
LNXFCA.include("cepm/cep.lua", CEPM.mod_id)
LNXFCA.include("cepm/utils.lua", CEPM.mod_id)
LNXFCA.include("cepm/overrides.lua", CEPM.mod_id)


-- Initialize state manager
CEPM.state = CEPM.mt.State:new()


-- Load atlas
SMODS.Atlas({
    key = 'cep_atlas',
    path = 'celestial_expansion_pack.png',
    px = 71,
    py = 95,
})


-- Load cards
local cep_cards = { 'c_cep_luna', 'c_cep_charon', 'c_cep_titan', 'c_cep_oberon', 'c_cep_epsilon', 'c_cep_atlas',
    'c_cep_kepler', 'c_cep_janus', 'c_cep_hyperion', 'c_cep_pandora', 'c_cep_solaris', 'c_cep_nova',
}

for _, card in ipairs(cep_cards) do
    SMODS.Consumable({
        key = CEPM.cards[card].key,
        pos = CEPM.cards[card].pos,
        set = 'Planet',
        atlas = 'cep_atlas',
        use = CEPM.cards[card].use,
        can_use = CEPM.cards[card].can_use or function() return true end,
        loc_vars = CEPM.utils.get_default_loc_vars,
    })
end
