-- Called when the lock/unlock button is clicked
-- TODO: Implement lock_list and more
function G.FUNCS.ltd_lock_unlock(e)
    local card = e.config.ref_table ---@type LTDM.Card

    -- Lock/unlock card
    if not card.ltdm_state.locked then
        LTDM.state.ltd:lock_item(card)
    else
        LTDM.state.ltd:unlock_item(card.ltdm_state.id)
    end
end


-- Called when the card is being drawn, lock/unlock button
-- is only shown when the card is highlighted.
-- TODO: Implement other things
---@param e LTDM.Button
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

        -- Disable button when player can't afford
        if e.config.ref_table.ltdm_state.no_locked and LTDM.state.ltd.price > (G.GAME.dollars - G.GAME.bankrupt_at) then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        else
            e.config.button = 'ltd_lock_unlock'
            -- Change the button color according
            if e.config.ref_table.ltdm_state.locked then
                e.config.colour = HEX("6C757D")  -- Gray

                -- Fix button alignment
                -- TODO: Tested on English only, test on other supported languages
                if e.config.ref_table.ability.set == 'Booster' then
                    e.UIBox.alignment.offset.x = e.config.ltd_btn_conf.locked_offset_x.booster
                elseif e.config.ref_table.ability.consumeable then
                    e.UIBox.alignment.offset.x = e.config.ltd_btn_conf.locked_offset_x.consumeable
                elseif e.config.ref_table.ability.set == 'Voucher' then
                    e.UIBox.alignment.offset.x = e.config.ltd_btn_conf.locked_offset_x.voucher
                else
                    e.UIBox.alignment.offset.x = e.config.ltd_btn_conf.locked_offset_x.other
                end
            else
                e.config.colour = HEX("FFA726")  -- Light Orange

                -- Reset button alignment
                if e.config.ref_table.ability.set == 'Booster' then
                    e.UIBox.alignment.offset.x = e.config.ltd_btn_conf.lock_offset_x.booster
                elseif e.config.ref_table.ability.consumeable then
                    e.UIBox.alignment.offset.x = e.config.ltd_btn_conf.lock_offset_x.consumeable
                elseif e.config.ref_table.ability.set == 'Voucher' then
                    e.UIBox.alignment.offset.x = e.config.ltd_btn_conf.lock_offset_x.voucher
                else
                    e.UIBox.alignment.offset.x = e.config.ltd_btn_conf.lock_offset_x.other
                end
            end
        end
    end
end
