---@diagnostic disable:duplicate-set-field

LTDM.original.create_card_for_shop = create_card_for_shop
---@param area BALATRO_T.CardArea The card
function create_card_for_shop(area)
    -- TODO: Implement locked card logic
    return LTDM.original.create_card_for_shop(area)
end


LTDM.original.create_shop_card_ui = create_shop_card_ui
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
        LTDM.state.ltd_button_text[card.config.center.key].text = localize('ltd_button_locked')

    else
        LTDM.state.ltd_button_text[card.config.center.key] = {}
        LTDM.state.ltd_button_text[card.config.center.key].text = localize('ltd_button_lock')

        -- TODO: This can't go here
        LTDM.state.ltd_button_text[card.config.center.key].popup_title = "Cost"
        LTDM.state.ltd_button_text[card.config.center.key].popup_text = "$" .. 2
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
