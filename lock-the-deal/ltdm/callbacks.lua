-- Called when the lock/unlock button is clicked
-- TODO: Implement lock_list and more
function G.FUNCS.ltd_lock_unlock(e)
    local card = e.config.ref_table ---@type LTDM.Card

    -- Prevent errors due to controller input
    if not card.ltdm_state then return end

    -- Lock/unlock card
    if not card.ltdm_state.locked then
        LTDM.state.ltd:lock_item(card)
    else
        LTDM.state.ltd:unlock_item(card.ltdm_state.id)
    end
end


local ltd_g_dollars = 0
-- Called when the card is being drawn, lock/unlock button
-- is only shown when the card is highlighted.
-- TODO: Implement other things
---@param e LTDM.Button
function G.FUNCS.ltd_can_lock_unlock(e)
    -- Skip rendering modifications when unnecessary
    if (not e.config.ref_table.highlighted and not e.config.ltd_controller) then return end

    -- Controller guard, prevents errors after purchasing the card
    if not e.config.ref_table.ltdm_state and e.config.ltd_controller then
        -- Remove the current card popup
        -- TODO: We should find a way to remove just the LTD popup
        e.parent.parent.parent.parent.parent.parent:remove()
        e.UIBox:recalculate()

        return
    end

    ltd_g_dollars = G.GAME.dollars
    if to_number and type(G.GAME.dollars) == 'table' then ltd_g_dollars = to_number(G.GAME.dollars) end

    -- Disable lock/unlock call
    if e.config.ref_table.ltdm_state.no_locked and LTDM.state.ltd.price > (ltd_g_dollars - G.GAME.bankrupt_at) then
        e.config.button = nil

        if e.config.ltd_controller then
            e.parent.parent.parent.config.colour = LTDM.UIDEF.LTD_STATE_COLOR.DISABLED
        else
            e.config.colour = LTDM.UIDEF.LTD_STATE_COLOR.DISABLED
        end

        return
    else
        e.config.button = 'ltd_lock_unlock'
    end

    -- Controller guard
    if e.config.ltd_controller then return end

    -- Button UI
    if e.config.ref_table.ltdm_state.locked then
        e.config.colour = LTDM.UIDEF.LTD_STATE_COLOR.LOCKED
    else
        e.config.colour = LTDM.UIDEF.LTD_STATE_COLOR.UNLOCKED
    end

    -- Buy and Use button
    if e.config.ref_table.children.buy_and_use_button and e.config.ref_table.children.buy_and_use_button.states.visible then
        e.config.ref_table.children.buy_and_use_button.alignment.offset.y = -0.44
        e.UIBox.alignment.offset.y = 0.59
    else
        e.UIBox.alignment.offset.y = 0
    end
end
