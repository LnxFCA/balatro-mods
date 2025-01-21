---@diagnostic disable:duplicate-set-field

LTDM.original.create_card_for_shop = create_card_for_shop
---@param area BALATRO_T.CardArea The card
function create_card_for_shop(area)
    -- TODO: Implement locked card logic
    return LTDM.original.create_card_for_shop(area)
end

LTDM.original.create_shop_card_ui = create_shop_card_ui
local ltd_lock_text = {}

---@param card BALATRO_T.Card
---@param type string
---@param area BALATRO_T.CardArea
function create_shop_card_ui(card, type, area)
    -- Create primary card UI
    LTDM.original.create_shop_card_ui(card, type, area)
    -- Only accept cards for now
    if area ~= G.shop_jokers then return true end

    -- Set initial button text
    if LTDM.state.lock_table[card.config.center.key] then
        LTDM.state.ltd_button_text[card.config.center.key] = localize('ltd_button_locked')
    else
        LTDM.state.ltd_button_text[card.config.center.key] = localize('ltd_button_lock')
    end

    -- TODO: Check if this is needed
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.35,
        blocking = false,
        blockable = false,
        func = function ()
            LTDM.UIDEF.add_ltd_button(card)

            return true
        end
    }))
end


LTDM.original.buy_from_shop = G.FUNCS.buy_from_shop
-- Remove lock/unlock button when card is purchased
-- TODO: Implement lock_list clear here
function G.FUNCS.buy_from_shop(e)
    if LTDM.original.buy_from_shop(e) == false then return end

    local card = e.config.ref_table

    -- Remove the lock/unlock button from the card
    if card.children.ltd_button then
        card.children.ltd_button:remove()
        card.children.ltd_button = nil

        LTDM.utils:remove_card(card.config.center.key)
    end
end


-- Called when the lock/unlock button is clicked
-- TODO: Implement lock_list and more
function G.FUNCS.ltd_lock_unlock(e)
    local card = e.config.ref_table ---@type BALATRO_T.Card
    local card_key = card.config.center.key

    -- Card locked
    if LTDM.state.lock_table[card_key] then
        LTDM.utils:unlock_card(card_key)
        return
    end

    -- Lock card
    LTDM.utils:lock_card(card)
end


-- Called when the card is being drawn, lock/unlock button
-- is only shown when the card is highlighted.
-- TODO: Implement other things
---@param e Moveable
function G.FUNCS.ltd_can_lock_unlock(e)
    -- Check if the card is highlighted
    if e.config.ref_table.highlighted then
        if ((e.config.ref_table.children.buy_and_use_button or {}).states or {}).visible then
            -- Align Buy and Use button, and the LTD button.
            -- TODO: Tested in English and Spanish, need to test in other languages.
            e.config.ref_table.children.buy_and_use_button.alignment.offset.y = -0.44  -- move u
            e.UIBox.alignment.offset.y = 0.59  -- move down
        else
            -- Reset custom alignment if Buy and Use button is not visible
            e.UIBox.alignment.offset.y = 0
        end

        -- Change the button color according
        if LTDM.state.lock_table[e.config.ref_table.config.center.key] then
            e.config.colour = HEX("6C757D")  -- Gray

            -- Fix button alignment
            -- TODO: Tested on English only, test on other supported languages
            e.UIBox.alignment.offset.x = (e.config.ref_table.ability.consumeable and -0.25) or -0.15
        else
            e.config.colour = HEX("FFA726")  -- Light Orange

            -- Reset button alignment
            e.UIBox.alignment.offset.x = (e.config.ref_table.ability.consumeable and -0.65) or -0.55
        end
    end
end
