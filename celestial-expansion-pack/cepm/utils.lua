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
---@return string | string[]?
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

    return hands
end


--- Returns the default loc vars for a CEP Card
---@param obj SMODS.Consumable
---@return table
function CEPM.utils.get_default_loc_vars(obj)
    local vars = {}
    local card_state = CEPM.state.cards[obj.key]
    local level_mult = 1

    if CEPM.state.last_card == 'c_cep_hyperion' and obj.key ~= 'c_cep_janus' and obj.key ~= 'c_cep_hyperion' then
        level_mult = 2;
    end

    vars = {
        (card_state.level or 1) * level_mult,
        card_state.mult or '?',
        card_state.chips or '?',

        colours = { G.C.SECONDARY_SET.Tarot },
    }

    return {
        vars = vars
    }
end
