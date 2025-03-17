function FRSM.activate(self)
    self.state.ui_active = true

    -- Remove overlays menus
    G.FUNCS.exit_overlay_menu()

    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu({
        definition = FRSM.UIDEF.frsm_ui(),
    })

    FRSM.UIDEF.UI = G.OVERLAY_MENU

    local card1 = Card(
        FRSM.UIDEF.shop_jokers.T.x + FRSM.UIDEF.shop_jokers.T.w / 2, FRSM.UIDEF.shop_jokers.T.y, G.CARD_W, G.CARD_H,
        nil, G.P_CENTERS.j_joker
    )
    local card2 = Card(
        FRSM.UIDEF.shop_jokers.T.x + FRSM.UIDEF.shop_jokers.T.w / 2, FRSM.UIDEF.shop_jokers.T.y, G.CARD_W, G.CARD_H,
        nil, FRSM.UIDEF.P_CENTERS.empty_joker
    )

    local voucher = Card(
        FRSM.UIDEF.shop_vouchers.T.x + FRSM.UIDEF.shop_vouchers.T.w / 2, FRSM.UIDEF.shop_vouchers.T.y, G.CARD_W, G.CARD_H,
        nil, FRSM.UIDEF.P_CENTERS.empty_voucher
    )

    local booster1 = Card(
        FRSM.UIDEF.shop_booster.T.x + FRSM.UIDEF.shop_booster.T.w / 2, FRSM.UIDEF.shop_booster.T.y, G.CARD_W * 1.15,
        G.CARD_H * 1.15, nil, FRSM.UIDEF.P_CENTERS.empty_pack
    )
    local booster2 = Card(
        FRSM.UIDEF.shop_booster.T.x + FRSM.UIDEF.shop_booster.T.w / 2, FRSM.UIDEF.shop_booster.T.y, G.CARD_W * 1.15,
        G.CARD_H * 1.15, nil, FRSM.UIDEF.P_CENTERS.empty_pack
    )

    FRSM.UIDEF.shop_jokers:emplace(card1)
    FRSM.UIDEF.shop_jokers:emplace(card2)

    FRSM.UIDEF.shop_vouchers:emplace(voucher)
    FRSM.UIDEF.shop_booster:emplace(booster1)
    FRSM.UIDEF.shop_booster:emplace(booster2)
end

--- FRSM callback handler
--- Used to prevent namespace collision with other mods or the game itself
---@param e BALATRO_T.UIElement | table
function G.FUNCS.frsm_callback_handler(e)
    local handler = nil

    -- Handle option cycle
    if e.cycle_config then
        handler = 'update_selection_page'
    else
        handler = string.sub(e.config.id, 6)
    end


    local callback = FRSM.callbacks[handler](e)
    if callback then callback() end
end


--- Switch card collection page
---@param e table
function FRSM.callbacks.update_selection_page(e)
    if not e or not e.cycle_config then return end

    local rows = FRSM.UIDEF.collection.rows
    local total_rows = FRSM.UIDEF.collection.total_rows
    local pool = FRSM.UIDEF.collection.pool
    local card_areas = FRSM.UIDEF.collection.card_areas
    local cards_page = FRSM.UIDEF.collection.cards_page * (e.cycle_config.current_option - 1)
    local args = FRSM.UIDEF.collection.args

    for r = 1, #card_areas do
            for i = #card_areas[r].cards, 1, -1 do
            local card = card_areas[r]:remove_card(card_areas[r].cards[i])
            card:remove()
            card = nil
            end
        end

    for r = 1, #rows do
        for i = 1, rows[r] do
            local center = pool[i + total_rows[r] + cards_page]
            if not center then break end

            local card = Card(
                card_areas[r].T.x + card_areas[r].T.w / 2, card_areas[r].T.y, G.CARD_W * args.card_scale,
                G.CARD_H * args.card_scale, nil, (args.center and G.P_CENTERS[args.center] or center)
            )

            if not args.no_materialize then card:start_materialize(nil, i > 1 or r > 1) end
            card_areas[r]:emplace(card)
        end
    end
end
