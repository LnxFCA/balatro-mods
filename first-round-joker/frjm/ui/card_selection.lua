FRJM.UI.create_card_selection_ui = function ()
    local jokers_collection = {}
    local jokers = {}

    for _, v in ipairs(G.P_CENTER_POOLS.Joker) do
        if v.discovered then table.insert(jokers, v) end
    end

    jokers_collection = SMODS.card_collection_UIBox(jokers, { 5, 5, 5}, {
        no_materialize = true,
        h_mod = 0.95,
    })

    ---@type UIDef
    return jokers_collection
end

