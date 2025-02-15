CEPM.cards = {
    c_cep_luna = { key = "cep_luna", pos = { x = 0, y = 0 }, config = { level = 1, }, },
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


CEPM.cards.c_cep_luna.use = function (obj, card)
    CEPM.utils.update_hand_level(CEPM.utils.get_random_hand(1) --[[@as string]], card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_charon.use = function (obj, card)
    local hand = CEPM.utils.get_least_used_hand()
    if hand == nil then
        local hands = CEPM.utils.get_available_hands()
        hand = hands[math.random(1, #hands)]
    end

    CEPM.utils.update_hand_level(hand, card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_titan.use = function (obj, card)
    local hands = CEPM.utils.get_random_hand(2) --[=[@as string[]]=]

    for _, hand in ipairs(hands) do
        CEPM.utils.update_hand_level(hand, card, CEPM.utils.calculate_card_level_up(obj.key))
        delay(0.5)
    end
end


CEPM.cards.c_cep_oberon.use = function (obj, card)
    CEPM.utils.update_hand_level(G.GAME.last_hand_played, card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_epsilon.use = function (obj, card)
    CEPM.utils.update_hand_level(CEPM.utils.get_random_hand() --[[@as string]], card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_atlas.use = function (obj, card)
    local hands = CEPM.utils.get_random_hand(3)

    for _, hand in ipairs(hands --[=[@as string[]]=]) do
        CEPM.utils.update_hand_level(hand, card, CEPM.utils.calculate_card_level_up(obj.key))
        delay(0.5)
    end
end


CEPM.cards.c_cep_kepler.use = function (_, card)
    local hands = CEPM.utils.get_random_hand(2)

    local left_hand = G.GAME.hands[hands[1]].level
    local right_hand = G.GAME.hands[hands[2]].level


    -- Left hand -> Right hand
    CEPM.utils.update_hand_level(hands[1], card, right_hand - left_hand)
    delay(0.5)
    -- Right hand <- Left Hand
    CEPM.utils.update_hand_level(hands[2], card, left_hand - right_hand)
end


CEPM.cards.c_cep_janus.use = function (obj, card)
    local level = CEPM.cards[obj.key].config.level + (CEPM.state.card_state[obj.key].level_extra or 0)

    CEPM.utils.update_hand_level(CEPM.utils.get_random_hand(1) --[[@as string]], card, level)

    CEPM.state.card_state[obj.key].level_extra = (CEPM.state.card_state[obj.key].level_extra or 0) + 1
end


CEPM.cards.c_cep_hyperion.use = function (obj, card)
    CEPM.utils.update_hand_level(CEPM.utils.get_random_hand(1) --[[@as string]], card, CEPM.utils.calculate_card_level_up(obj.key))
    CEPM.state.level_mult = 2
end


CEPM.cards.c_cep_solaris.use = function (obj, card)
    for _, hand in ipairs(CEPM.utils.get_available_hands()) do
        CEPM.utils.update_hand_level(hand, card, CEPM.utils.calculate_card_level_up(obj.key))
        delay(0.15)
    end
end


CEPM.cards.c_cep_nova.use = function (obj, card)
    for _, hand in ipairs(CEPM.utils.get_available_hands()) do
        CEPM.utils.update_hand_level(hand, card, CEPM.utils.calculate_card_level_up(obj.key))
        delay(0.15)
    end
end
