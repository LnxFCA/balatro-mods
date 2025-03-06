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


-- USE

CEPM.cards.c_cep_luna.use = function(obj, card)
    CEPM.utils.update_hand_level(CEPM.utils.get_random_hand(1) --[[@as string]], card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_charon.use = function(obj, card)
    local hand = CEPM.utils.get_least_used_hand()
    if hand == nil then
        local hands = CEPM.utils.get_available_hands()
        hand = hands[math.random(1, #hands)]
    end

    CEPM.utils.update_hand_level(hand, card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_titan.use = function(obj, card)
    local hands = CEPM.utils.get_random_hand(2) --[=[@as string[]]=]

    for _, hand in ipairs(hands) do
        CEPM.utils.update_hand_level(hand, card, CEPM.utils.calculate_card_level_up(obj.key))
        delay(0.5)
    end
end


CEPM.cards.c_cep_oberon.use = function(obj, card)
    CEPM.utils.update_hand_level(G.GAME.last_hand_played, card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_epsilon.use = function(obj, card)
    CEPM.utils.update_hand_level(CEPM.utils.get_random_hand() --[[@as string]], card, CEPM.utils.calculate_card_level_up(obj.key))
end


CEPM.cards.c_cep_atlas.use = function(obj, card)
    local hands = CEPM.utils.get_random_hand(3)

    for _, hand in ipairs(hands --[=[@as string[]]=]) do
        CEPM.utils.update_hand_level(hand, card, CEPM.utils.calculate_card_level_up(obj.key), CEPM.mod.config.instant_level_up)
        if not CEPM.mod.config.instant_level_up then delay(0.5) end
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


CEPM.cards.c_cep_janus.use = function(obj, card)
    local level = CEPM.cards[obj.key].config.level + (CEPM.state.card_state[obj.key].level_extra or 0)

    CEPM.utils.update_hand_level(CEPM.utils.get_random_hand(1) --[[@as string]], card, level)

    CEPM.state.card_state[obj.key].level_extra = (CEPM.state.card_state[obj.key].level_extra or 0) + 1
end


CEPM.cards.c_cep_hyperion.use = function(obj, card)
    CEPM.utils.update_hand_level(CEPM.utils.get_random_hand(1) --[[@as string]], card, CEPM.utils.calculate_card_level_up(obj.key))
    CEPM.state.level_mult = 2
end


CEPM.cards.c_cep_solaris.use = function(obj, card)
    for _, hand in ipairs(CEPM.utils.get_available_hands()) do
        CEPM.utils.update_hand_level(hand, card, CEPM.utils.calculate_card_level_up(obj.key), CEPM.mod.config.instant_level_up)
        if not CEPM.mod.config.instant_level_up then delay(0.5) end
    end
end


CEPM.cards.c_cep_nova.use = function(obj, card)
    for _, hand in ipairs(CEPM.utils.get_available_hands()) do
        CEPM.utils.update_hand_level(hand, card, CEPM.utils.calculate_card_level_up(obj.key), CEPM.mod.config.instant_level_up)
        if not CEPM.mod.config.instant_level_up then delay(0.5) end
    end
end


-- SPAWN

CEPM.cards.c_cep_luna.in_pool = function(obj, _)
    if G.GAME.round >= 15 then
        CEPM.state.card_state[obj.key].can_spawn = true
    end

    return CEPM.state.card_state[obj.key].can_spawn
end


CEPM.cards.c_cep_charon.in_pool = function(obj, _)
    if G.GAME.hands["High Card"].played >= 4 or G.GAME.hands["Pair"].played >= 4 then
        CEPM.state.card_state[obj.key].can_spawn = true
    end

    return CEPM.state.card_state[obj.key].can_spawn
end


CEPM.cards.c_cep_titan.in_pool = function(obj, _)
    if G.GAME.hands["Pair"].played >= 8 or G.GAME.hands["Two Pair"].played >= 8 then
        CEPM.state.card_state[obj.key].can_spawn = true
    end

    return CEPM.state.card_state[obj.key].can_spawn
end


CEPM.cards.c_cep_oberon.in_pool = function(obj, _)
    return false
end


CEPM.cards.c_cep_epsilon.in_pool = function(obj, _)
    if G.GAME.hands["Two Pair"].played >= 10 then
        CEPM.state.card_state[obj.key].can_spawn = true
    end

    return CEPM.state.card_state[obj.key].can_spawn
end


CEPM.cards.c_cep_atlas.in_pool = function(obj, _)
    if G.GAME.hands["Three of a Kind"].played >= 6 or G.GAME.hands["Straight"].played >= 6 then
        CEPM.state.card_state[obj.key].can_spawn = true
    end

    return CEPM.state.card_state[obj.key].can_spawn
end


CEPM.cards.c_cep_kepler.in_pool = function(obj, _)
    if G.GAME.hands["Straight"].played_this_round >= 2 then
        CEPM.state.card_state[obj.key].can_spawn = true
    end

    return CEPM.state.card_state[obj.key].can_spawn
end


CEPM.cards.c_cep_janus.in_pool = function(obj, _)
    if G.GAME.hands["Straight Flush"].played >= 1 or G.GAME.hands["Straight"].played >= 8 then
        CEPM.state.card_state[obj.key].can_spawn = true
    end

    return CEPM.state.card_state[obj.key].can_spawn
end


CEPM.cards.c_cep_hyperion.in_pool = function(obj, _)
    return false
end


CEPM.cards.c_cep_pandora.in_pool = function(obj, _)
    if G.GAME.hands["Three of a Kind"].played >= 3 and G.GAME.hands["Full House"].played >= 3 then
        CEPM.state.card_state[obj.key].can_spawn = true
    end

    return CEPM.state.card_state[obj.key].can_spawn
end


CEPM.cards.c_cep_solaris.in_pool = function(obj, _)
    if not CEPM.state.card_state[obj.key].can_spawn then
        local played_hands = 0
        local available_hands = CEPM.utils.get_available_hands()
        for _, hand in ipairs(available_hands) do
            if G.GAME.hands[hand].visible and G.GAME.hands[hand].played >= 1 then
                played_hands = played_hands + 1
            end
        end

        if played_hands >= 1 and played_hands == #available_hands then
            CEPM.state.card_state[obj.key].can_spawn = true
        end
    end

    return CEPM.state.card_state[obj.key].can_spawn
end


CEPM.cards.c_cep_nova.in_pool = function(obj, _)
    if not CEPM.state.card_state[obj.key].can_spawn then
        local card_count = 0
        for _, state in pairs(CEPM.state.card_state) do
            if state.used >= 1 then card_count = card_count + 1 end
        end

        if card_count >= 11 then
            CEPM.state.card_state[obj.key].can_spawn = true
        end
    end

    return CEPM.state.card_state[obj.key].can_spawn
end

-- UNLOCK
CEPM.cards.c_cep_luna.check_for_unlock = function(obj)
    if G.GAME.round >= 15 then
        CEPM.state.card_state[obj.key].can_unlock = true
    end

    return CEPM.state.card_state[obj.key].can_unlock
end


CEPM.cards.c_cep_charon.check_for_unlock = function(obj)
    if G.GAME.hands["High Card"].played >= 15 then
        CEPM.state.card_state[obj.key].can_unlock = true
    end

    return CEPM.state.card_state[obj.key].can_unlock
end


CEPM.cards.c_cep_titan = function(obj)
    if G.GAME.hands["Pair"].played >= 3 then
        CEPM.state.card_state[obj.key].can_unlock = true
    end

    return CEPM.state.card_state[obj.key].can_unlock
end


CEPM.cards.c_cep_oberon.check_for_unlock = function(obj)
    return CEPM.state.card_state[obj.key].can_unlock
end


CEPM.cards.c_cep_epsilon.check_for_unlock = function(obj)
    if G.GAME.round_resets.ante >= 7 then
        CEPM.state.card_state[obj.key].can_unlock = true
    end

    return CEPM.state.card_state[obj.key].can_unlock
end


CEPM.cards.c_cep_atlas.check_for_unlock = function(obj)
    if G.GAME.hands["Three of a Kind"].played_this_round >= 3 then
        CEPM.state.card_state[obj.key].can_unlock = true
    end

    return CEPM.state.card_state[obj.key].can_unlock
end


CEPM.cards.c_cep_kepler.check_for_unlock = function(obj)
    local hands = CEPM.utils.get_available_hands()

    local status = true
    for i, v in ipairs(hands) do
        if G.GAME.hands[v].played >= 1 then
            status = true
        else
            status = false
            break
        end
    end

    CEPM.state.card_state[obj.key].can_unlock = status

    return CEPM.state.card_state[obj.key].can_unlock
end


CEPM.cards.c_cep_janus.check_for_unlock = function(obj)
    if G.GAME.hands["Straight Flush"].played >= 3 then
        CEPM.state.card_state[obj.key].can_unlock = true
    end

    return CEPM.state.card_state[obj.key].can_unlock
end


CEPM.cards.c_cep_hyperion.check_for_unlock = function(obj)
    return CEPM.state.card_state[obj.key].can_unlock
end


CEPM.cards.c_cep_pandora.check_for_unlock = function(obj)
    return CEPM.state.card_state[obj.key].can_unlock
end


CEPM.cards.c_cep_solaris.check_for_unlock = function(obj)
    if G.GAME.round_resets.ante >= 10 then
        CEPM.state.card_state[obj.key].can_unlock = true
    end

    return CEPM.state.card_state[obj.key].can_unlock
end


CEPM.cards.c_cep_nova.check_for_unlock = function(obj)
    local state = true
    for k, v in pairs(CEPM.state.card_state) do
        if k ~= "c_cep_nova" then
            if v.used >= 2 then
                state = true
            else
                state = false
                break
            end
        end
    end

    CEPM.state.card_state[obj.key].can_unlock = state

    return CEPM.state.card_state[obj.key].can_unlock
end
