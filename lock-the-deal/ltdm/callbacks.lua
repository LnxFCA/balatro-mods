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
