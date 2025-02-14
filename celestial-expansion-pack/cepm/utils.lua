--- Returns a list of current available hands.
--- Available hands are hands whith `visible = true`
---@param exclude? table<string, boolean>
---@return string[]
function CEPM.utils.get_available_hands(exclude)
    local hands = {}
    exclude = exclude or {}

    for k, v in pairs(G.GAME.hands) do
        if v.visible and not exclude[k] then table.insert(hands, k) end
    end

    return hands
end


--- Returns a handom hand string or list (if max > 1)
---@param max? integer
---@param exclude? table
---@return string | string[]
function CEPM.utils.get_random_hand(max, exclude)
    local hands = CEPM.utils.get_available_hands(exclude)

    if not max or max == 1 then
        return hands[math.random(1, #hands)]
    end

    local rhands = {}
    local exclude_hands = {}

    for i = 1, max do

        if #hands < i then break end
        local hand = CEPM.utils.get_random_hand(1, exclude_hands)
        if hand == nil then break end

        exclude_hands[hand] = true

        table.insert(rhands, hand)
    end

    return rhands
end


--- Returns the default loc vars for a CEP Card
---@param obj SMODS.Consumable
---@return table
function CEPM.utils.get_default_loc_vars(obj)
    local vars = {}
    local card_state = CEPM.state.card_state[obj.key]
    local card_config = CEPM.cards[obj.key].config
    local level_mult = CEPM.state.level_mult

    if obj.key == 'c_cep_janus' or obj.key == 'c_cep_hyperion' then
        level_mult = 1;
    end

    vars = {
        (card_config.level + (card_state.level_extra or card_config.level_extra or 0)) * level_mult,
        card_state.mult or '?',
        card_state.chips or '?',

        colours = { G.C.SECONDARY_SET.Planet },
    }

    if obj.key == 'c_cep_pandora' then
        vars[1] = card_config.level * level_mult
        table.insert(vars, 2, (card_state.level_extra or card_config.level_extra) * level_mult)
    end

    return {
        vars = vars
    }
end


--- Return the most used Poker Hand
---@return string?
function CEPM.utils.get_most_used_hand()
    local max = 0
    local hand = nil


    for _, k in ipairs(CEPM.utils.get_available_hands()) do
        if G.GAME.hands[k].played > max then
            max = G.GAME.hands[k].played
            hand = k
        end
    end

    return hand
end


--- Return the least used Poker Hand
---@return string?
function CEPM.utils.get_least_used_hand()
    local most_used = CEPM.utils.get_most_used_hand()
    if not most_used then return nil end

    local min = G.GAME.hands[most_used].played
    local hand = nil
    for _, k in ipairs(CEPM.utils.get_available_hands()) do
        if G.GAME.hands[k].played < min then
            min = G.GAME.hands[k].played
            hand = k
        end
    end

    return hand
end


--- Wrapper for level_up_hand.
---@param hand string
---@param card BALATRO_T.Card
---@param level integer | string
function CEPM.utils.level_up_hand(hand, card, level)
    update_hand_text(
        { sound = 'button', volume = 0.7, pitch = 8.8, delay = 0.3, },
        {
            handname = localize(hand, 'poker_hands'), chips = G.GAME.hands[hand].chips,
            mult = G.GAME.hands[hand].mult, level = G.GAME.hands[hand].level,
        }
    )

    CEPM.original.level_up_hand(card, hand, nil, level)

    update_hand_text(
        { sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
        { handname = '', chips = 0, mult = 0, level = ''}
    )
end


--- Return the level up value for given card key.
---@param key string
---@return number
function CEPM.utils.calculate_card_level_up(key)
    return (CEPM.cards[key].config.level + (CEPM.state.card_state[key].level_extra or 0)) * CEPM.state.level_mult
end
