


-- Load atlas

SMODS.Atlas({
    key = 'cep_atlas',
    path = 'celestial_expansion_pack.png',
    px = 71,
    py = 95,
})


-- Load cards
local cep_cards = { 'luna', 'charon', 'titan', 'oberon', 'epsilon', 'atlas', 'kepler', 'janus', 'hyperion',
    'pandora', 'solaris', 'nova',
}


for _, card in pairs(cep_cards) do
    SMODS.Consumable({
        key = CEPM.cards[card].key,
        pos = CEPM.cards[card].pos,
        set = 'Planet',
        atlas = 'cep_atlas',
        use = CEPM.cards[card].use,
        loc_vars = function (self) return CEPM.utils.get_default_loc_vars(self) end,
    })

    CEPM.state.cards['c_'..CEPM.cards[card].key] = {}
end
