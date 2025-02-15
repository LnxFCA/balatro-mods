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

    CEPM.utils.update_hand_level(hand --[[@as string]], card, level)
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
    local hands = CEPM.utils.get_random_hand(2)

    CEPM.utils.update_hand_level(hands[1], card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_oberon.use = function (obj, card)
    local hand = G.GAME.last_hand_played

    CEPM.utils.update_hand_level(hand, card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_epsilon.use = function (obj, card)
    CEPM.utils.update_hand_level(CEPM.utils.get_random_hand() --[[@as string]], card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_atlas.use = function (obj, card)
    local hands = CEPM.utils.get_random_hand(3)

    update_hand_text(
        { sound = 'button', volume = 0.7, pitch = 8.8, delay = 0.3, },
        {
            handname = localize('k_all_hands'), chips = '??',
            mult = '??', level = '+'..CEPM.utils.calculate_card_level_up(obj.key),
        }
    )

    delay(1)
    for _, hand in ipairs(hands --[=[@as string[]]=]) do
        CEPM.original.level_up_hand(card, hand, false, CEPM.utils.calculate_card_level_up(obj.key))
    end

    update_hand_text(
        { sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
        { handname = '', chips = 0, mult = 0, level = ''}
    )
end


CEPM.cards.c_cep_kepler.use = function (obj, card)
    local hands = CEPM.utils.get_random_hand(2)

    local left_hand = G.GAME.hands[hands[1]]
    local right_hand = G.GAME.hands[hands[2]]

    -- TODO: Implement hand swap
end


CEPM.cards.c_cep_janus.use = function (obj, card)
    local hand = CEPM.utils.get_random_hand(1)
    local level_extra = CEPM.state.card_state[obj.key].level_extra or 0

    CEPM.utils.update_hand_level(hand --[[@as string]], card, CEPM.cards[obj.key].config.level + level_extra)

    CEPM.state.card_state[obj.key].level_extra = level_extra + 1
end


CEPM.cards.c_cep_hyperion.use = function (obj, card)
    local hand = CEPM.utils.get_random_hand(1)

    CEPM.utils.update_hand_level(hand --[[@as string]], card, CEPM.utils.calculate_card_level_up(obj.key))

    CEPM.state.level_mult = 2
end


CEPM.cards.c_cep_solaris.use = function (obj, card)
    local hands = CEPM.utils.get_available_hands()

    update_hand_text(
        { sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3, },
        {
            handname = localize('k_all_hands'), chips = '??',
            mult = '??', level = '+'..CEPM.utils.calculate_card_level_up(obj.key),
        }
    )

    delay(1)
    for _, hand in ipairs(hands --[=[@as string[]]=]) do
        CEPM.original.level_up_hand(card, hand, false, CEPM.utils.calculate_card_level_up(obj.key))
    end

    update_hand_text(
        { sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
        { handname = '', chips = 0, mult = 0, level = ''}
    )
end


CEPM.cards.c_cep_nova.use = function (obj, card)
    local hands = CEPM.utils.get_available_hands()

    update_hand_text(
        { sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3, },
        {
            handname = localize('k_all_hands'), chips = '??',
            mult = '??', level = '+'..CEPM.utils.calculate_card_level_up(obj.key),
        }
    )

    delay(1)
    for _, hand in ipairs(hands --[=[@as string[]]=]) do
        CEPM.original.level_up_hand(card, hand, false, CEPM.utils.calculate_card_level_up(obj.key))
    end

    update_hand_text(
        { sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
        { handname = '', chips = 0, mult = 0, level = ''}
    )
end
