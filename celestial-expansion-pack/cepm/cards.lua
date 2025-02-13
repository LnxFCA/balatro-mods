CEPM.cards = {
    luna = { key = "cep_luna", pos = { x = 0, y = 0 }, },
    charon = { key = "cep_charon", pos = { x = 1, y = 0}, },
    titan = { key = "cep_titan", pos = { x = 2, y = 0 }, },
    oberon = { key = "cep_oberon", pos = { x = 3, y = 0 }, },
    epsilon = { key = "cep_epsilon", pos = { x = 4, y = 0 }, },
    atlas = { key = "cep_atlas", pos = { x = 5, y = 0 }, },
    kepler = { key = "cep_kepler", pos = { x = 0, y = 1 }, },
    janus = { key = "cep_janus", pos = { x = 1, y = 1}, },
    hyperion = { key = "cep_hyperion", pos = { x = 2, y = 1 }, },
    pandora = { key = "cep_pandora", pos = { x = 3, y = 1 }, },
    solaris = { key = "cep_solaris", pos = { x = 4, y = 1 }, },
    nova = { key = "cep_nova", pos = { x = 5, y = 1 }, },
}


CEPM.cards.luna.use = function (_, card, _, _)
    local hand = CEPM.utils.get_random_hand(1, {}) --[[@ string]]
    local level = (CEPM.state.last_card == 'c_cep_hyperion' and 2) or 1

    update_hand_text(
        { sound = 'button', volume = 0.7, pitch = 8.8, delay = 0.3, },
        {
            handname = localize(hand, 'poker_hands'), chips = G.GAME.hands[hand].chips,
            mult = G.GAME.hands[hand].mult, level = G.GAME.hands[hand].level,
        }
    )

    level_up_hand(card, hand, nil, level)
    update_hand_text(
        { sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
        { handname = '', chips = 0, mult = 0, level = ''}
    )
end

