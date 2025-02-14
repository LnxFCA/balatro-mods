CEPM.cards = {
    c_cep_luna = { key = "cep_luna", pos = { x = 0, y = 0 }, config = { level = 1 }, },
    c_cep_charon = { key = "cep_charon", pos = { x = 1, y = 0}, config = { level = 2, }, },
    c_cep_titan = { key = "cep_titan", pos = { x = 2, y = 0 }, config = { level = 1, }},
    c_cep_oberon = { key = "cep_oberon", pos = { x = 3, y = 0 }, config = { level = 1 }, },
    c_cep_epsilon = { key = "cep_epsilon", pos = { x = 4, y = 0 }, config = { level = 2,} },
    c_cep_atlas = { key = "cep_atlas", pos = { x = 5, y = 0 }, config = { level = 1, } },
    c_cep_kepler = { key = "cep_kepler", pos = { x = 0, y = 1 }, config = { level = 0, }},
    c_cep_janus = { key = "cep_janus", pos = { x = 1, y = 1}, config = { level = 1, level_extra = 0 }, },
    c_cep_hyperion = { key = "cep_hyperion", pos = { x = 2, y = 1 }, config = { level = 1, }, },
    c_cep_pandora = { key = "cep_pandora", pos = { x = 3, y = 1 }, config = { level = 3, level_extra = -1 }, },
    c_cep_solaris = { key = "cep_solaris", pos = { x = 4, y = 1 }, config = { level = 1, }, },
    c_cep_nova = { key = "cep_nova", pos = { x = 5, y = 1 }, config = { level = 2, }, },
}


CEPM.cards.c_cep_luna.use = function (_, card)
    local hand = CEPM.utils.get_random_hand(1)
    local level = (CEPM.state.last_card == 'c_cep_hyperion' and 2) or 1

    CEPM.utils.level_up_hand(hand --[[@as string]], card, level)
end


CEPM.cards.c_cep_charon.use = function (obj, card)
    local hand = CEPM.utils.get_least_used_hand()
    if hand == nil then
        local hands = CEPM.utils.get_available_hands()
        hand = hands[math.random(1, #hands)]
    end

    CEPM.utils.level_up_hand(hand, card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_titan.use = function (obj, card)
    local hands = CEPM.utils.get_random_hand(2)

    CEPM.utils.level_up_hand(hands[1], card, CEPM.utils.calculate_card_level_up(obj.key))
end
