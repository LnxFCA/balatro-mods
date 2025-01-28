---@diagnostic disable:duplicate-set-field

LTDM.original.create_card_for_shop = create_card_for_shop
---@param area BALATRO_T.CardArea The card
function create_card_for_shop(area)
    if LTDM.state.ltd.length == 0 then
        return LTDM.original.create_card_for_shop(area)
    end

    -- Get a locked item info for `area`
    local lock_item = LTDM.state.ltd:get_lock_item(area == G.shop_jokers and 'jokers' or nil)

    -- Use defaults if not item available for this area
    if not lock_item then return LTDM.original.create_card_for_shop(area) end

    ---@as LTDM.Card
    local card = SMODS.create_card({
        area = area,
        set = lock_item.set,
        edition = lock_item.edition,
        enhancement = lock_item.enhancement,
        key = lock_item.key,
        seal = lock_item.seal,
        skip_materialize = true,
    })

    -- Mark the item
    card.ltdm_saved_id = lock_item.id

    -- Restore card price
    card.cost = lock_item.price

    create_shop_card_ui(card)

    return card
end


LTDM.original.create_shop_card_ui = create_shop_card_ui
---@param card LTDM.Card
---@param type string
---@param area BALATRO_T.CardArea
function create_shop_card_ui(card, type, area)
    -- Create primary card UI
    LTDM.original.create_shop_card_ui(card, type, area)

    -- Skip on card opening
    if card.opening then return true end

    -- -- Skip booster packs if disabled
    if (area == G.shop_booster and not LTDM.mod.config.booster_pack_enabled) and not card.ltdm_saved_id then
        return true
    elseif (area ~= G.shop_jokers and area ~= G.shop_vouchers and area ~= G.shop_booster) and not card.ltdm_saved_id then
        return true
    end

    local force_lock = false
    if LTDM.mod.config.frjm_integration and card.frjm_shop_joker then
        force_lock = true
    end

    -- Register the item
    LTDM.state.ltd:register(card,
        (area == G.shop_jokers and "jokers") or (area == G.shop_vouchers and "vouchers") or
        (area == G.shop_booster and "booster") or "other", force_lock)

    -- TODO: Check if this is needed
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.30,
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

    ---@type LTDM.Card
    local card = e.config.ref_table

    -- Check for supported item
    if not card.ltdm_state then return end
    LTDM.state.ltd:reset(card)
end


LTDM.original.use_card = G.FUNCS.use_card
-- Remove the Voucher
function G.FUNCS.use_card(e, mute, nosave)
    LTDM.original.use_card(e, mute, nosave)

    ---@type LTDM.Card
    local card = e.config.ref_table

    if not card.ltdm_state then return end
    LTDM.state.ltd:reset(card)
end


LTDM.original.start_run = Game.start_run
function Game.start_run(self, args)
    if args.savetext then
        -- Load saved data from mod's configuration
        LTDM.state.ltd = LTDM.mt.State:new()
        LTDM.state.ltd:load_saved(LTDM.mod)
    else
        -- Load a new LTD status
        LTDM.state.ltd = LTDM.mt.State:new()
        LTDM.mod.config.ltd = nil
    end

    LTDM.original.start_run(self, args)
end


LTDM.original.save_run = save_run
save_run = function ()
    LTDM.original.save_run()

    -- TODO: Check if this is required
    if G.F_NO_SAVING == true then return end

    -- Save state
    if G.STATE == G.STATES.SHOP or G.STATE == G.STATES.BLIND_SELECT then
        if G.STATE == G.STATES.BLIND_SELECT then
            -- TODO: This should be moved to `toggle_shop` instead
            -- Reset when leaving the shop
            LTDM.state.ltd:reset_lock()
            LTDM.state.ltd:clear_local_state()
        end

        LTDM.state.ltd:save(LTDM.mod)
    end
end


LTDM.original.reroll_shop = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop(e)
    -- Reset price and generator before the reroll
    LTDM.state.ltd:reset_lock()

    LTDM.original.reroll_shop(e)
end
